import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import '../base/common_game_phase.dart';
import 'writing_game_models.dart';
import '../../../services/character_recognition_service.dart';
import '../../../core/debug_logger.dart';
import '../../components/drawing/drawing_models.dart';

class WritingGameLogic extends StateNotifier<WritingGameState> {
  final CharacterRecognizer _recognitionService = getRecognizer();
  WritingGameSettings? _currentSettings;
  VoidCallback? _onCompleted; // Orchestrator管理時の完了コールバック
  bool _skipResultScreen = false; // Orchestrator管理フラグ

  WritingGameLogic() : super(const WritingGameState()) {
    _initialize();
  }
  
  // Orchestrator管理設定
  void setOrchestratorMode({VoidCallback? onCompleted, bool skipResultScreen = false}) {
    Log.d('WritingGameLogic: Setting orchestrator mode - skipResultScreen: $skipResultScreen');
    _onCompleted = onCompleted;
    _skipResultScreen = skipResultScreen;
  }

  Future<void> _initialize() async {
    Log.d('WritingGameLogic: Initializing...');
    try {
      await _recognitionService.initialize();
      Log.d('WritingGameLogic: Initialization completed');
    } catch (e) {
      Log.e('WritingGameLogic: Initialization failed: $e');
    }
  }

  // カテゴリを選択
  void selectCategory(CharacterCategory category) {
    Log.d('WritingGameLogic: Selected category: ${category.displayName}');
    state = state.copyWith(
      selectedCategory: category,
      phase: CommonGamePhase.displaying,  // モード選択へ
      internalPhase: WritingPhase.modeSelection,
    );
    
    // BaseGameScreenが自動的に読み上げを処理
  }

  // 文字を選択
  void selectCharacter(CharacterData character) {
    Log.d('WritingGameLogic: Selected character: ${character.character}');
    
    // 練習シーケンスがある場合は最初のモードを使用、ない場合は選択されたモードを使用
    final sequence = state.practiceSequence;
    WritingMode currentMode;
    CommonGamePhase nextPhase;
    
    if (sequence.isNotEmpty) {
      // シーケンスがある場合は最初のモードから開始
      currentMode = sequence.first;
      state = state.copyWith(
        currentPracticeIndex: 0,
        selectedMode: currentMode,
      );
    } else {
      // 従来の単体モード
      currentMode = state.selectedMode ?? WritingMode.freeWrite;
    }
    
    switch (currentMode) {
      case WritingMode.tracing:
        nextPhase = CommonGamePhase.questioning;
        break;
      case WritingMode.tracingFree:
        nextPhase = CommonGamePhase.questioning;
        break;
      case WritingMode.freeWrite:
        nextPhase = CommonGamePhase.questioning;
        break;
    }
    
    state = state.copyWith(
      selectedCharacter: character,
      phase: nextPhase,
      currentStrokeIndex: 0, // 新しい文字を選んだ時のみリセット
      maxStrokeProgress: 0.0, // 新しい文字用にリセット
      drawingData: const DrawingData(paths: [], canvasSize: Size(300, 300)), // 描画データをリセット
    );
    
    // BaseGameScreenが自動的に読み上げを処理
    
    if (currentMode == WritingMode.tracing) {
      _startTracingAnimation();
    }
  }

  // 練習モードを選択（旧版 - 後方互換性のため残す）
  void selectMode(WritingMode mode) {
    Log.d('WritingGameLogic: Selected mode: ${mode.displayName}');
    state = state.copyWith(
      selectedMode: mode,
      phase: CommonGamePhase.displaying,  // 文字選択へ
    );
    
    // BaseGameScreenが自動的に読み上げを処理
  }

  // 練習コンビネーションを選択
  void selectCombination(PracticeCombination combination) {
    Log.d('WritingGameLogic: Selected combination: ${combination.displayName}');
    final sequence = combination.generateSequence();
    Log.d('WritingGameLogic: Generated sequence with ${sequence.length} items: ${sequence.map((m) => m.displayName).join(", ")}');
    
    state = state.copyWith(
      selectedCombination: combination,
      practiceSequence: sequence,
      currentPracticeIndex: 0,
      selectedMode: sequence.isNotEmpty ? sequence.first : null,
      phase: CommonGamePhase.displaying,  // 文字選択へ
      internalPhase: WritingPhase.characterSelection,
    );
    
    Log.d('WritingGameLogic: State after selectCombination - sequence: ${state.practiceSequence.length}, index: ${state.currentPracticeIndex}');
    
    // BaseGameScreenが自動的に読み上げを処理
  }

  // なぞり書きのアニメーション開始（簡略版）
  void _startTracingAnimation() {
    final character = state.selectedCharacter;
    if (character == null) return;

    Log.d('WritingGameLogic: Starting tracing guide for ${character.character}');
    
    // SVGがないため、簡単なアニメーションのみ実行
    state = state.copyWith(
      isAnimatingStrokes: true,
      currentStrokeIndex: 0,
    );

    // 2秒後にアニメーション終了
    Future.delayed(const Duration(seconds: 2), () {
      state = state.copyWith(
        isAnimatingStrokes: false,
      );
      
      // BaseGameScreenが自動的に読み上げを処理
    });
  }

  // スムーズトレーシング専用（従来の描画システム不使用）
  void startDrawing(Offset point) {
    // スムーズトレーシングでは Drawing オブジェクトを使用しない
    // インターフェース互換性のため残すがログのみ
    Log.d('WritingGameLogic: Starting smooth tracing at $point');
  }

  // スムーズトレーシング専用（従来の描画システム不使用）
  void updateDrawing(Offset point) {
    // スムーズトレーシングでは Drawing オブジェクトを使用しない
    // インターフェース互換性のため残すがログのみ
    // Log.d('WritingGameLogic: Updating smooth tracing at $point');
  }

  // 描画終了（ストローク完了時）- スムーズトレーシング専用
  void endDrawing([double? actualCanvasSize]) {
    Log.d('WritingGameLogic: Stroke ended');
    
    if (state.selectedMode == WritingMode.tracing) {
      final character = state.selectedCharacter;
      if (character != null) {
        _handleSmoothTracingComplete(character);
      }
    } else if (state.selectedMode == WritingMode.freeWrite) {
      _handleFreeWriteComplete();
    }
  }


  // スムーズトレーシング専用完了処理
  void _handleSmoothTracingComplete(CharacterData character) async {
    final targetPaths = _getTargetPaths(character.character);
    final currentStrokeIndex = state.currentStrokeIndex;
    
    // 全ストローク完了チェック
    if (currentStrokeIndex + 1 >= targetPaths.length) {
      _handleTracingComplete();
    } else {
      // 次のストロークに進む
      state = state.copyWith(
        currentStrokeIndex: currentStrokeIndex + 1,
        maxStrokeProgress: 0.0,
        recognitionResult: RecognitionResult(
          text: '${currentStrokeIndex + 1}画目完了 (${currentStrokeIndex + 1}/${targetPaths.length}画)',
          confidence: 1.0,
        ),
      );
      
      
      
      if (currentStrokeIndex + 2 <= targetPaths.length) {
        
      }
    }
  }

  // なぞり書き完了処理（全ストローク完成時）
  void _handleTracingComplete() async {
    final character = state.selectedCharacter;
    if (character == null) return;
    
    Log.d('WritingGameLogic: Tracing completed successfully!');
    Log.d('WritingGameLogic: Current sequence: ${state.practiceSequence.length} items, index: ${state.currentPracticeIndex}');
    Log.d('WritingGameLogic: Sequence: [${state.practiceSequence.map((m) => m.displayName).join(", ")}]');
    
    // 練習シーケンスがある場合は次のステップへ、ない場合は結果画面へ
    if (state.practiceSequence.isNotEmpty) {
      // 成功エフェクトを表示してから自動的に次の練習に進む
      if (!mounted) return;
      state = state.copyWith(showSuccessEffect: true);
      
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          _proceedToNextPractice();
        }
      });
    } else {
      // 単体モードの場合は結果画面へ（または完了通知）
      Log.d('WritingGameLogic: Single mode completed - skipResultScreen: $_skipResultScreen');
      if (_skipResultScreen && _onCompleted != null) {
        Log.d('WritingGameLogic: Orchestrator mode - calling completion callback instead of showing result');
        _onCompleted!();
      } else {
        Log.d('WritingGameLogic: Normal mode - transitioning to result screen');
        state = state.copyWith(
          phase: CommonGamePhase.completed,
          internalPhase: WritingPhase.result,
          showSuccessEffect: false,  // Orchestratorがエフェクトを管理
          recognitionResult: RecognitionResult(
            text: character.character,
            confidence: 1.0,
          ),
        );
      }
    }
  }
  
  // なぞりがき２モード完了処理
  void completeTracingFree() {
    final character = state.selectedCharacter;
    if (character == null) return;
    
    Log.d('WritingGameLogic: TracingFree completed');
    
    // 成功エフェクトを表示してから自動的に次の練習に進む
    if (!mounted) return;
    state = state.copyWith(showSuccessEffect: true);
    
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        _proceedToNextPractice();
      }
    });
  }
  
  // なぞりがき２のやり直し
  void retryTracingFree() {
    Log.d('WritingGameLogic: Retrying TracingFree');
    clearDrawing();
  }

  // じゆうがきのやり直し
  void retryFreeWriting() {
    Log.d('WritingGameLogic: Retrying FreeWriting');
    clearDrawing();
  }

  // 練習シーケンスの次のステップに進む
  void _proceedToNextPractice() {
    final sequence = state.practiceSequence;
    final currentIndex = state.currentPracticeIndex;
    
    Log.d('WritingGameLogic: _proceedToNextPractice called - currentIndex: $currentIndex, sequence length: ${sequence.length}');
    Log.d('WritingGameLogic: Current sequence: [${sequence.map((m) => m.displayName).join(", ")}]');
    
    if (sequence.isEmpty) {
      // シーケンスがない場合は結果画面へ
      Log.d('WritingGameLogic: No sequence, going to result');
      _goToResult();
      return;
    }
    
    final nextIndex = currentIndex + 1;
    
    if (nextIndex >= sequence.length) {
      // 全ての練習が完了したら結果画面へ
      Log.d('WritingGameLogic: All practices done (nextIndex: $nextIndex >= length: ${sequence.length}), going to result');
      _goToResult();
    } else {
      // 次の練習モードへ
      final nextMode = sequence[nextIndex];
      CommonGamePhase nextPhase;
      WritingPhase nextInternalPhase;

      switch (nextMode) {
        case WritingMode.tracing:
          nextPhase = CommonGamePhase.questioning;
          nextInternalPhase = WritingPhase.tracing;
          break;
        case WritingMode.tracingFree:
          nextPhase = CommonGamePhase.questioning;
          nextInternalPhase = WritingPhase.tracingFree;
          break;
        case WritingMode.freeWrite:
          nextPhase = CommonGamePhase.questioning;
          nextInternalPhase = WritingPhase.freeWriting;
          break;
      }
      
      Log.d('WritingGameLogic: Moving to next practice: ${nextMode.displayName} (${nextIndex + 1}/${sequence.length})');
      Log.d('WritingGameLogic: Phase transition: ${state.phase.name} -> ${nextPhase.name}');
      
      // エフェクトを非表示にしてから次の練習に移行
      state = state.copyWith(
        currentPracticeIndex: nextIndex,
        selectedMode: nextMode,
        phase: nextPhase,
        internalPhase: nextInternalPhase,
        showSuccessEffect: false,
        drawingData: const DrawingData(paths: [], canvasSize: Size(300, 300)), // リセット
        currentStrokeIndex: 0,
        maxStrokeProgress: 0.0,
      );
      
      // なぞりがきの場合はアニメーション開始
      if (nextMode == WritingMode.tracing) {
        Log.d('WritingGameLogic: Starting tracing animation for next practice');
        _startTracingAnimation();
      }
    }
  }

  // 結果画面へ遷移
  void _goToResult() {
    final character = state.selectedCharacter;
    if (character == null) return;
    
    Log.d('WritingGameLogic: All practices completed, going to result');
    
    // 最後のエフェクトを表示してから結果画面へ
    if (!mounted) return;
    state = state.copyWith(showSuccessEffect: true);
    
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        Log.d('WritingGameLogic: TracingFree completion delayed callback - skipResultScreen: $_skipResultScreen');
        if (_skipResultScreen && _onCompleted != null) {
          Log.d('WritingGameLogic: Orchestrator mode - calling completion callback instead of showing result');
          _onCompleted!();
        } else {
          Log.d('WritingGameLogic: Normal mode - transitioning to result screen');
          state = state.copyWith(
            phase: CommonGamePhase.completed,
            internalPhase: WritingPhase.result,
            showSuccessEffect: false,
            recognitionResult: RecognitionResult(
              text: character.character,
              confidence: 1.0,
            ),
          );
        }
      }
    });
  }

  // カテゴリに応じた認識タイプを取得
  RecognitionType _getRecognitionTypeForCategory(CharacterCategory? category) {
    if (category == null) {
      Log.w('WritingGameLogic: No category selected, defaulting to hiragana recognition');
      return RecognitionType.hiragana;
    }
    
    Log.d('WritingGameLogic: Determining recognition type for category: ${category.displayName}');
    
    switch (category.name) {
      case 'numbers':
        Log.d('WritingGameLogic: Selected numbers recognition type');
        return RecognitionType.numbers;
      case 'katakana':
        Log.d('WritingGameLogic: Selected katakana recognition type');
        return RecognitionType.katakana;
      case 'hiragana':
      default:
        Log.d('WritingGameLogic: Selected hiragana recognition type (default)');
        return RecognitionType.hiragana;
    }
  }

  // 文字に応じた目標パスを取得
  List<String> _getTargetPaths(String character) {
    switch (character) {
      case 'あ':
        // AnimCJK data (12354.svg) - proper stroke order
        return [
          "M 174,258 251,308 440,306 697,241",
          "M 331,137 420,185 373,388 367,632 409,728 431,777",
          "M 570,440 610,484 460,727 200,836 181,682 342,556 466,514 641,499 754,520 838,606 845,763 703,869 508,922",
        ];
      case 'い':
        // AnimCJK data (12356.svg) - actual stroke paths from svgsJaKana
        return [
          "M 95,249 149,282 222,589 272,704 369,788 372,702 406,628",  // 左側の縦線
          "M 678,273 754,342 836,472 867,639",  // 右側の曲線
        ];
      case 'う':
        // AnimCJK data (12358.svg) - actual stroke paths from svgsJaKana
        return [
          "M 400,113 654,205",  // 上の横線
          "M 213,423 286,450 494,372 610,360 684,394 718,462 672,690 492,911",  // 大きな曲線
        ];
      case 'え':
        // AnimCJK data (12360.svg) - actual stroke paths from svgsJaKana
        return [
          "M 400,113 654,205",  // 上の横線
          "M 197,436 277,460 618,334 654,363 608,380 203,762 204,804 333,709 407,692 482,722 596,836 793,835 855,853",  // 複雑な曲線
        ];
      case 'お':
        // AnimCJK data (12362.svg) - actual stroke paths from svgsJaKana
        return [
          "M 111.6,323.2 174,363.7 327,362.1 535.2,309.4",  // 1画目：横線
          "M 287,100 338,140 311,847 282,898 234,906 218,900 165,836 158,764 243,671 525,536 748,543 835,691 763,820 588,917",  // 2画目：縦線と曲線
          "M 710,189 794,229 868,350",  // 3画目：右上の点
        ];
      case 'か':
        // AnimCJK data (12363.svg) - actual stroke paths from svgsJaKana
        return [
          "M 104,461 154,476 413,401 492,396 544,419 572,511 409,881 319,786",  // 1画目：左の縦線
          "M 354,131 392,199 143,835",  // 2画目：右上から左下の斜線
          "M 649,283 836,441 902,626",  // 3画目：右の曲線
        ];
      case 'き':
        // AnimCJK data (12365.svg) - actual stroke paths from svgsJaKana
        return [
          "M 294,332 433,342 677,253",  // 1画目：上の横線
          "M 376,512 526,520 777,426",  // 2画目：中の横線
          "M 367,135 414,140 688,620 688,693 636,653 572,642",  // 3画目：縦線
          "M 299,734 273,794 322,870 628,903",  // 4画目：下の横線
        ];
      case 'く':
        // AnimCJK data (12367.svg) - actual stroke paths from svgsJaKana
        return [
          "M 561,111 605,180 337,479 346,523 625,884.9",  // 1画目：大きな曲線
        ];
      case 'け':
        // AnimCJK data (12369.svg) - actual stroke paths from svgsJaKana
        return [
          "M 217,156 254,202 180,714 219,842 237,847 286,637",  // 1画目：縦線
          "M 417,399 786,347 865,357",  // 2画目：横線
          "M 636,119 707,152 693,621 659,790 565,915",  // 3画目：右の縦線
        ];
      case 'こ':
        // AnimCJK data (12371.svg) - actual stroke paths from svgsJaKana
        return [
          "M 288,222 318,227 536,214 678,254 715,283 630,280 518,327",  // 1画目：上の横線
          "M 248,635 245,714 312,792 511,840 704,838 783,851",  // 2画目：下の横線
        ];
      case 'さ':
        // AnimCJK data (12373.svg) - actual stroke paths from svgsJaKana
        return [
          "M 274,415 751,300",  // 1画目：上の横線
          "M 377,124 430,125 583,397 738,574 740,642 678,591 602,572",  // 2画目：縦線と曲線
          "M 317,714 284,756 298,817 466,898 690,913",  // 3画目：下の横線
        ];
      case 'し':
        // AnimCJK data (12375.svg) - actual stroke paths from svgsJaKana
        return [
          "M 287,128 346,192 299,732 328,833 411,894 568,894 674,855 812,770",  // 1画目：縦線と曲線
        ];
      case 'す':
        // AnimCJK data (12377.svg) - actual stroke paths from svgsJaKana
        return [
          "M 129,345 195,368 468,313 790,275 893,303",  // 1画目：上の横線
          "M 507,120 570,155 561,240 566,663 482,654 420,607 401,526 436,457 H 486 L 536,493 563,576 561,710 491,828 368,916",  // 2画目：右側の縦線と曲線
        ];
      case 'せ':
        // AnimCJK data (12379.svg) - actual stroke paths from svgsJaKana
        return [
          "M 98,575 146,578 409,491 824,412 935,441",  // 1画目：上の横線
          "M 637,121 696,174 635,665 607,722 542,684",  // 2画目：縦線
          "M 313,199 368,260 369,785 434,860 792,879",  // 3画目：左の線と下の横線
        ];
      case 'そ':
        // AnimCJK data (12381.svg) - actual stroke paths from svgsJaKana
        return [
          "M 142,338 222,380 756,167 786,192 678,245 518,431 482,581 531,734 759,888",  // 1画目：複雑な曲線
        ];
      case 'た':
        // AnimCJK data (12383.svg) - actual stroke paths from svgsJaKana
        return [
          "M 194,339 330,372 676,290",  // 1画目：上の横線
          "M 424,116 464,176 172,916",  // 2画目：縦線
          "M 516,563 730,514 811,533",  // 3画目：中の横線
          "M 505,776 549,841 858,868",  // 4画目：下の横線
        ];
      case 'ち':
        // AnimCJK data (12385.svg) - actual stroke paths from svgsJaKana
        return [
          "M 199,326 366,344 666,291",  // 1画目：上の横線
          "M 425,108 475,153 311,679 315,710 516,575 705,553 793,614 782,767 663,864 482,917",  // 2画目：縦線と曲線
        ];
      case 'つ':
        // AnimCJK data (12388.svg) - actual stroke paths from svgsJaKana
        return [
          "M 107,418 161,448 547,300 791,304 891,398 878,550 683,707 508,769",  // 1画目：曲線
        ];
      case 'て':
        // AnimCJK data (12390.svg) - actual stroke paths from svgsJaKana
        return [
          "M 142,338 222,380 756,167 786,192 678,245 518,431 482,581 531,734 759,888",  // 1画目：曲線
        ];
      case 'と':
        // AnimCJK data (12392.svg) - actual stroke paths from svgsJaKana
        return [
          "M 221,157 299,181 407,492",  // 1画目：縦線
          "M 675,242 763,289 408,522 289,647 259,718 262,782 286,818 410,861 775,865",  // 2画目：曲線
        ];
      case 'な':
        // AnimCJK data (12394.svg) - actual stroke paths from svgsJaKana
        return [
          "M 140,306 266,324 506,268 574,270",  // 1画目：上の横線
          "M 382,111 412,176 234,622",  // 2画目：縦線
          "M 762,322 797,347 882,443 882,469 843,435 783,435",  // 3画目：右の点
          "M 632,464 601,514 594,849 485,914 398,902 344,861 340,808 390,745 770,919",  // 4画目：下の曲線
        ];
      case 'に':
        // AnimCJK data (12395.svg) - actual stroke paths from svgsJaKana
        return [
          "M 201,152 242,235 156,607 168,829 201,884 201,809 251,695",  // 1画目：縦線
          "M 513,294 747,240 836,262",  // 2画目：上の横線
          "M 479,670 496,735 583,790 883,785",  // 3画目：下の横線
        ];
      case 'ぬ':
        // AnimCJK data (12396.svg) - actual stroke paths from svgsJaKana
        return [
          "M 223,230 314,623 426,866",  // 1画目：縦線
          "M 491,125 546,208 390,669 170,844 118,761 217,516 470,354 660,302 850,374 890,644 750,774 590,774 579,688 672,669 923,857",  // 2画目：複雑な曲線
        ];
      case 'ね':
        // AnimCJK data (12397.svg) - actual stroke paths from svgsJaKana
        return [
          "M 284,110 339,151 308,910",  // 1画目：縦線
          "M 131,406 180,404 364,299 402,323 190,658 133,766 145,814 360,564 600,334 750,270 900,364 891,606 747,812 600,804 580,724 685,666 780,719 952,878",  // 2画目：複雑な曲線
        ];
      case 'の':
        // AnimCJK data (12398.svg) - actual stroke paths from svgsJaKana
        return [
          "M 505 239 540 439 468 605 337 772 202 791 125 651 132 491 193 384 330 264 480 207 655 199 794 266 888 446 858 668 706 804 577 864",  // 1画目：円形の曲線
        ];
      case 'は':
        // AnimCJK data (12399.svg) - actual stroke paths from svgsJaKana
        return [
          "M 178,152 225,224 158,713 192,874 207,874 272,720",  // 1画目：縦線
          "M 461,363 585,375 841,336",  // 2画目：横線
          "M 655,140 708,178 694,815 500,859 411,818 407,777 433,742 484,717 644,748 868,868",  // 3画目：右の縦線と曲線
        ];
      case 'ひ':
        // AnimCJK data (12402.svg) - actual stroke paths from svgsJaKana
        return [
          "M 160,236 269,239 386,182 417,200 225,544 203,758 312,875 553,805 653,536 689,176 907,614",  // 1画目：複雑な曲線
        ];
      case 'ふ':
        // AnimCJK data (12405.svg) - actual stroke paths from svgsJaKana
        return [
          "M 440,147 558,213 573,259 451,306",  // 1画目：点
          "M 403,387 403,466 506,564 571,746 525,831 412,840 342,785",  // 2画目：曲線
          "M 106,684 110,742 181,847 224,767",  // 3画目：左下の点
          "M 750,565 865,673 905,781",  // 4画目：右下の点
        ];
      case 'へ':
        // AnimCJK data (12408.svg) - actual stroke paths from svgsJaKana
        return [
          "M 75,438 138,469 247,372 375,309 940,710",  // 1画目：へ形の曲線
        ];
      case 'ほ':
        // AnimCJK data (12411.svg) - actual stroke paths from svgsJaKana
        return [
          "M 179,146 207,224 138,713 180,871 252,720",  // 1画目：縦線
          "M 487,182 562,205 818,158",  // 2画目：上の横線
          "M 440,442 508,470 875,403",  // 3画目：中の横線
          "M 655,219 708,252 694,815 500,859 451,818 447,777 473,742 524,717 644,748 894,884",  // 4画目：右の縦線と曲線
        ];
      case 'ま':
        // ま行 - actual stroke paths from hiragana_data_registry
        return [
          "M255 273L379 301L699 233L769 238",  // 1画目：上の横線
          "M258 513L391 542L770 479",  // 2画目：中の横線
          "M477 88L530 130L530 830L480 880L390 910L305 894L280 834L310 775L400 763L759 885L792 929",  // 3画目：縦線と下の曲線
        ];
      case 'み':
        // み - actual stroke paths from hiragana_data_registry
        return [
          "M 273,208 340,236 586,178 267,765 238,796 190,824 146,814 121,754 136,682 269,547 469,513 932,740",  // 1画目：縦線と曲線複合
          "M 756,409 786,505 710,707 516,896",  // 2画目：右の曲線
        ];
      case 'む':
        // む - actual stroke paths from hiragana_data_registry
        return [
          "M 137,321 233,350 585,278",  // 1画目：上の横線
          "M 297,90 358,140 311,847 282,898 234,906 158,764 154,662 224,639 427,863 650,874 753,728 740,488",  // 2画目：縦線と大きな曲線
          "M 731,159 826,217 887,341",  // 3画目：右上の小さな点
        ];
      case 'め':
        // め - actual stroke paths from hiragana_data_registry
        return [
          "M 218,228 247,265 300,573 426,866",  // 1画目：縦線
          "M 491,125 546,208 390,669 170,844 118,761 217,516 470,354 660,302 851,359 890,649 783,777 570,852",  // 2画目：大きな曲線
        ];
      case 'も':
        // も - actual stroke paths from hiragana_data_registry
        return [
          "M 390,90 434,153 375,809 473,909 661,877 715,755 673,568",  // 1画目：縦線
          "M 221,285 325,314 604,279",  // 2画目：上の横線
          "M 218,548 325,592 611,537",  // 3画目：下の横線
        ];
      case 'や':
        // や - actual stroke paths from hiragana_data_registry
        return [
          "M 81,517 148,533 491,379 740,305 860,311 921,409 817,524 647,552",  // 1画目：上の大きな曲線
          "M 503,105 611,168 624,213 530,209",  // 2画目：右上の短い線
          "M 317,214 273,209 273,281 350,522 513,918",  // 3画目：縦線
        ];
      case 'ゆ':
        // ゆ - actual stroke paths from hiragana_data_registry
        return [
          "M 182,239 209,305 170,503 168,738 189,759 215,604 278,478 470,312 674,252 824,338 829,545 696,665 531,643 427,517",  // 1画目：大きな曲線
          "M 505,126 559,114 608,158 565,709 418,916",  // 2画目：右の縦線
        ];
      case 'よ':
        // よ - actual stroke paths from hiragana_data_registry
        return [
          "M 568,358 787,324",  // 1画目：上の横線
          "M 484,114 532,164 501,827 341,864 242,812 235,718 356,671 785,913",  // 2画目：縦線と下の曲線
        ];
      case 'ら':
        // ら - actual stroke paths from hiragana_data_registry
        return [
          "M 378,113 508,240 396,275",  // 1画目：上部の曲線
          "M 327,344 308,376 235,685 264,717 529,616 697,600 758,647 772,753 662,849 493,916",  // 2画目：大きな曲線
        ];
      case 'り':
        // り - actual stroke paths from hiragana_data_registry
        return [
          "M 344,93 368,143 326,483 350,531 441,302",  // 1画目：縦線
          "M 583,199 656,236 652,613 556,836 487,911",  // 2画目：右の曲線
        ];
      case 'る':
        // る - actual stroke paths from hiragana_data_registry
        return [
          "M 300,221 333,229 595,162 628,191 213,688 230,710 468,571 697,551 796,653 741,818 623,884 420,884 387,834 439,784 590,850",  // 1画目：大きな曲線複合
        ];
      case 'れ':
        // れ - actual stroke paths from hiragana_data_registry
        return [
          "M 290,116 328,146 313,914",  // 1画目：縦線
          "M 97,440 155,436 352,320 388,344 114,767 132,792 416,488 652,295 703,316 700,797 783,818 946,687",  // 2画目：複雑な曲線
        ];
      case 'ろ':
        // ろ - actual stroke paths from hiragana_data_registry
        return [
          "M 291,208 325,217 598,147 632,177 201,694 218,717 466,572 704,551 807,657 750,829 627,898 438,900.2",  // 1画目：大きな曲線
        ];
      case 'わ':
        // わ - actual stroke paths from hiragana_data_registry
        return [
          "M 296,112 331,153 313,913",  // 1画目：縦線
          "M 105,441 168,440 403,336 425,354 137,714 160,742 463,534 681,454 828,479 884,649 785,784 656,856",  // 2画目：複雑な曲線
        ];
      case 'ん':
        // ん - actual stroke paths from hiragana_data_registry
        return [
          "M 502,112 543,175 146,854 152,894 242,729 392,579 506,535 565,613 530,864 611,908 793,793 875,566",  // 1画目：大きな曲線
        ];
      case 'を':
        // を - actual stroke paths from hiragana_data_registry
        return [
          "M 180,292 298,323 648,267",  // 1画目：上の横線
          "M 415,117 461,181 215,557 227,569 330,504 450,524 468,754.9",  // 2画目：縦線と曲線
          "M 668,440 718,482 314,714 258,802 328,892 690,902.7",  // 3画目：下の部分
        ];
      case '1':
        return [
          "M 200,80 L 200,320",
          "M 120,350 L 280,350",
        ];
      default:
        return ["M 100,200 L 300,200"];
    }
  }

  // 自由書き完了処理
  void _handleFreeWriteComplete() async {
    final drawing = state.currentDrawing;
    if (drawing == null || drawing.isEmpty) return;

    try {
      Log.d('WritingGameLogic: Starting character recognition...');
      
      // Canvasを画像に変換
      final imageData = await _convertDrawingToImage(drawing);
      
      // 認識タイプを動的に決定
      final recognitionType = _getRecognitionTypeForCategory(state.selectedCategory);
      Log.d('WritingGameLogic: Using recognition type: $recognitionType for category: ${state.selectedCategory?.displayName}');
      
      // 文字認識実行（自由書き）
      final result = await _recognitionService.recognize(imageData, type: recognitionType);
      
      Log.d('WritingGameLogic: Recognition completed - text: "${result.text}", confidence: ${result.confidence.toStringAsFixed(3)}, isRecognized: ${result.isRecognized}');
      Log.d('WritingGameLogic: Recognition candidates: ${result.candidates.map((c) => '"${c.text}" (${c.confidence.toStringAsFixed(3)})').join(", ")}');
      Log.d('WritingGameLogic: SkipResultScreen: $_skipResultScreen');
      
      if (_skipResultScreen && _onCompleted != null) {
        Log.d('WritingGameLogic: Orchestrator mode - calling completion callback instead of showing result');
        state = state.copyWith(recognitionResult: result);
        _onCompleted!();
      } else {
        Log.d('WritingGameLogic: Normal mode - transitioning to result screen');
        state = state.copyWith(
          phase: CommonGamePhase.completed,
          internalPhase: WritingPhase.result,
          recognitionResult: result,
        );
      }
      
      // 認識結果を音声で読み上げ
      
      
    } catch (e) {
      Log.e('WritingGameLogic: Recognition failed: $e');
      
      // エラー時の処理
      Log.d('WritingGameLogic: Recognition error - skipResultScreen: $_skipResultScreen');
      if (_skipResultScreen && _onCompleted != null) {
        Log.d('WritingGameLogic: Orchestrator mode - calling completion callback on error');
        state = state.copyWith(
          recognitionResult: RecognitionResult(
            text: '？',
            confidence: 0.0,
          ),
        );
        _onCompleted!();
      } else {
        Log.d('WritingGameLogic: Normal mode - showing error result screen');
        state = state.copyWith(
          phase: CommonGamePhase.completed,
          internalPhase: WritingPhase.result,
          recognitionResult: RecognitionResult(
            text: '？',
            confidence: 0.0,
          ),
        );
      }
      
      
    }
  }

  // 描画を画像に変換
  Future<Uint8List> _convertDrawingToImage(Drawing drawing) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    
    // 背景を白で塗りつぶし
    canvas.drawRect(
      Rect.fromLTWH(0, 0, drawing.canvasSize.width, drawing.canvasSize.height),
      Paint()..color = Colors.white,
    );
    
    // ストロークを描画
    for (final stroke in drawing.strokes) {
      final paint = Paint()
        ..color = stroke.color
        ..strokeWidth = stroke.strokeWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;
      
      for (int i = 0; i < stroke.points.length - 1; i++) {
        canvas.drawLine(stroke.points[i], stroke.points[i + 1], paint);
      }
    }
    
    final picture = recorder.endRecording();
    final img = await picture.toImage(
      drawing.canvasSize.width.toInt(),
      drawing.canvasSize.height.toInt(),
    );
    
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  // 描画をクリア
  void clearDrawing() {
    Log.d('WritingGameLogic: clearDrawing called, current paths: ${state.drawingData.paths.length}');
    state = state.copyWith(
      currentDrawing: Drawing(
        strokes: [],
        canvasSize: state.currentDrawing?.canvasSize ?? const Size(300, 300),
      ),
      drawingData: state.drawingData.clear(),
      recognitionResult: null,
    );
    Log.d('WritingGameLogic: Drawing cleared, now has ${state.drawingData.paths.length} paths');
  }

  // 共通描画システム用：描画パスを追加
  void addDrawingPath(DrawingPath path) {
    Log.d('WritingGameLogic: addDrawingPath called with ${path.points.length} points');
    Log.d('WritingGameLogic: Current state has ${state.drawingData.paths.length} paths');
    
    final newDrawingData = state.drawingData.addPath(path);
    Log.d('WritingGameLogic: New drawing data will have ${newDrawingData.paths.length} paths');
    
    state = state.copyWith(
      drawingData: newDrawingData,
    );
    
    Log.d('WritingGameLogic: State updated, now has ${state.drawingData.paths.length} paths');
  }

  // 自由描画の認識を実行
  void recognizeFreeWriting() {
    if (state.selectedMode == WritingMode.freeWrite) {
      _handleFreeWriteCompleteFromDrawingData();
    }
  }

  // DrawingDataから自由書き完了処理
  void _handleFreeWriteCompleteFromDrawingData() async {
    final drawingData = state.drawingData;
    if (drawingData.isEmpty) return;

    try {
      Log.d('WritingGameLogic: Starting character recognition from DrawingData...');
      
      // DrawingDataを画像に変換
      final imageData = await _convertDrawingDataToImage(drawingData);
      
      // 認識タイプを動的に決定
      final recognitionType = _getRecognitionTypeForCategory(state.selectedCategory);
      Log.d('WritingGameLogic: Using recognition type: $recognitionType for category: ${state.selectedCategory?.displayName}');
      
      // 文字認識実行（自由書き・DrawingData版）
      final result = await _recognitionService.recognize(imageData, type: recognitionType);
      
      Log.d('WritingGameLogic: Recognition completed - text: "${result.text}", confidence: ${result.confidence.toStringAsFixed(3)}, isRecognized: ${result.isRecognized}');
      Log.d('WritingGameLogic: Recognition candidates: ${result.candidates.map((c) => '"${c.text}" (${c.confidence.toStringAsFixed(3)})').join(", ")}');
      
      // 練習シーケンスがある場合は次のステップへ、ない場合は結果画面へ
      if (state.practiceSequence.isNotEmpty) {
        // 認識結果を一時的に保存して成功エフェクトを表示してから次のステップへ
        if (!mounted) return;
        state = state.copyWith(
          recognitionResult: result,
          showSuccessEffect: true,
        );
        
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) {
            _proceedToNextPractice();
          }
        });
      } else {
        // 単体モードの場合は結果画面へ
        Log.d('WritingGameLogic: Single FreeWriting mode completed - skipResultScreen: $_skipResultScreen');
        if (_skipResultScreen && _onCompleted != null) {
          Log.d('WritingGameLogic: Orchestrator mode - calling completion callback instead of showing result');
          state = state.copyWith(recognitionResult: result);
          _onCompleted!();
        } else {
          Log.d('WritingGameLogic: Normal mode - transitioning to result screen');
          state = state.copyWith(
            phase: CommonGamePhase.completed,
            internalPhase: WritingPhase.result,
            recognitionResult: result,
          );
        }

        final character = state.selectedCharacter;
        final isCorrect = character != null && 
            result.text.toLowerCase() == character.character.toLowerCase();
        
        Log.d('WritingGameLogic: Character comparison - expected: "${character?.character}", recognized: "${result.text}", isCorrect: $isCorrect');
        
        if (isCorrect) {
          state = state.copyWith(showSuccessEffect: true);
          
          Future.delayed(const Duration(milliseconds: 2000), () {
            if (mounted) {
              state = state.copyWith(showSuccessEffect: false);
            }
          });
        }
      }
      
    } catch (e) {
      Log.e('WritingGameLogic: Recognition failed: $e');
      
      Log.d('WritingGameLogic: FreeWriting recognition error - skipResultScreen: $_skipResultScreen');
      if (_skipResultScreen && _onCompleted != null) {
        Log.d('WritingGameLogic: Orchestrator mode - calling completion callback on FreeWriting error');
        state = state.copyWith(
          recognitionResult: RecognitionResult(
            text: '認識できませんでした',
            confidence: 0.0,
          ),
        );
        _onCompleted!();
      } else {
        Log.d('WritingGameLogic: Normal mode - showing FreeWriting error result screen');
        state = state.copyWith(
          phase: CommonGamePhase.completed,
          internalPhase: WritingPhase.result,
          recognitionResult: RecognitionResult(
            text: '認識できませんでした',
            confidence: 0.0,
          ),
        );
      }
      
      
    }
  }

  // DrawingDataを画像に変換
  Future<Uint8List> _convertDrawingDataToImage(DrawingData drawingData) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final size = drawingData.canvasSize;

    // 白い背景
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.white,
    );

    // 描画パスを描画
    for (final path in drawingData.paths) {
      final paint = Paint()
        ..color = path.color
        ..strokeWidth = path.strokeWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      if (path.points.isNotEmpty) {
        final pathToDraw = Path();
        pathToDraw.moveTo(path.points.first.dx, path.points.first.dy);
        for (int i = 1; i < path.points.length; i++) {
          pathToDraw.lineTo(path.points[i].dx, path.points[i].dy);
        }
        canvas.drawPath(pathToDraw, paint);
      }
    }

    final picture = recorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }


  // 削除済み: 重複するresetGameメソッド（BaseGameScreen互換版を使用）

  // カテゴリ選択に戻る
  void backToCategories() {
    Log.d('WritingGameLogic: Back to categories');
    state = state.copyWith(
      phase: CommonGamePhase.ready,
      internalPhase: WritingPhase.categorySelection,
      selectedCategory: null,
      selectedCharacter: null,
      selectedMode: null,
      currentDrawing: null,
      drawingData: const DrawingData(paths: [], canvasSize: Size(300, 300)),
      recognitionResult: null,
      // currentStrokeIndex をリセットしない - 進行を保持
    );
  }

  // モード選択に戻る
  void backToModes() {
    Log.d('WritingGameLogic: Back to modes');
    state = state.copyWith(
      phase: CommonGamePhase.displaying,
      internalPhase: WritingPhase.modeSelection,
      selectedCharacter: null,
      selectedMode: null,
      currentDrawing: null,
      drawingData: const DrawingData(paths: [], canvasSize: Size(300, 300)),
      recognitionResult: null,
      // currentStrokeIndex をリセットしない - 進行を保持
    );
  }

  // 文字選択に戻る
  void backToCharacters() {
    Log.d('WritingGameLogic: Back to characters');
    state = state.copyWith(
      phase: CommonGamePhase.displaying,
      internalPhase: WritingPhase.characterSelection,
      selectedCharacter: null,
      currentDrawing: null,
      drawingData: const DrawingData(paths: [], canvasSize: Size(300, 300)),
      recognitionResult: null,
      // currentStrokeIndex をリセットしない - 進行を保持
    );
  }

  // 同じ文字で再挑戦
  void retry() {
    Log.d('WritingGameLogic: Retrying with same character and mode');
    final mode = state.selectedMode;
    if (mode == null) return;
    
    state = state.copyWith(
      phase: CommonGamePhase.questioning,
      internalPhase: mode == WritingMode.tracing
        ? WritingPhase.tracing
        : mode == WritingMode.tracingFree
          ? WritingPhase.tracingFree
          : WritingPhase.freeWriting,
      // なぞりがきモードでは描画を保持、フリーライティングではクリア
      currentDrawing: mode == WritingMode.tracing ? state.currentDrawing : null,
      drawingData: mode == WritingMode.tracing ? state.drawingData : const DrawingData(paths: [], canvasSize: Size(300, 300)),
      recognitionResult: null,
      showSuccessEffect: false,
      isAnimatingStrokes: false,
      // currentStrokeIndex をリセットしない - 現在の進行を保持
    );

    if (mode == WritingMode.tracing) {
      _startTracingAnimation();
    }
  }

  // 最大進行度を更新
  void updateMaxProgress(double progress) {
    if (progress > state.maxStrokeProgress) {
      state = state.copyWith(maxStrokeProgress: progress);
    }
  }

  // ========== BaseGameScreen互換メソッド ==========
  
  /// ゲーム開始（設定を受け取って直接プレイフェーズへ）
  void startGame(WritingGameSettings settings) {
    Log.d('WritingGameLogic: Starting game with settings: ${settings.displayName}');
    _currentSettings = settings;
    
    // 練習シーケンスがすでに設定されている場合は、それを保持する
    // （selectCombinationから来た場合）
    final existingSequence = state.practiceSequence;
    final existingIndex = state.currentPracticeIndex;
    
    CommonGamePhase initialPhase;
    WritingPhase initialInternalPhase;
    WritingMode actualMode;

    if (existingSequence.isNotEmpty && existingIndex < existingSequence.length) {
      // シーケンスがある場合は現在のインデックスのモードを使用
      actualMode = existingSequence[existingIndex];
      Log.d('WritingGameLogic: Using sequence mode at index $existingIndex: ${actualMode.displayName}');
    } else {
      // シーケンスがない場合は設定のモードを使用
      actualMode = settings.mode;
    }

    switch (actualMode) {
      case WritingMode.tracing:
        initialPhase = CommonGamePhase.questioning;
        initialInternalPhase = WritingPhase.tracing;
        break;
      case WritingMode.tracingFree:
        initialPhase = CommonGamePhase.questioning;
        initialInternalPhase = WritingPhase.tracingFree;
        break;
      case WritingMode.freeWrite:
        initialPhase = CommonGamePhase.questioning;
        initialInternalPhase = WritingPhase.freeWriting;
        break;
    }
    
    state = state.copyWith(
      selectedCategory: settings.category,
      selectedMode: actualMode,
      selectedCharacter: settings.character,
      phase: initialPhase,
      internalPhase: initialInternalPhase,
      currentStrokeIndex: 0,
      maxStrokeProgress: 0.0,
      drawingData: const DrawingData(paths: [], canvasSize: Size(300, 300)),
      showSuccessEffect: false,  // エフェクトをリセット
      // 重要: 練習シーケンスとインデックスは保持する
      practiceSequence: existingSequence,
      currentPracticeIndex: existingIndex,
    );
    
    if (actualMode == WritingMode.tracing) {
      _startTracingAnimation();
    }
  }
  
  /// ゲームリセット（設定画面に戻る）
  void resetGame() {
    Log.d('WritingGameLogic: Resetting game - Full cleanup');
    _currentSettings = null;
    
    // 完全な初期状態に戻す
    state = WritingGameState(
      phase: CommonGamePhase.ready,
      internalPhase: WritingPhase.categorySelection,
      selectedCategory: null,
      selectedCharacter: null,
      selectedMode: null,
      isAnimatingStrokes: false,
      currentStrokeIndex: 0,
      maxStrokeProgress: 0.0,
      drawingData: const DrawingData(paths: [], canvasSize: Size(300, 300)),
      recognitionResult: null,
      showSuccessEffect: false,
      selectedCombination: null,
      practiceSequence: const [],
      currentPracticeIndex: 0,
    );
  }

  @override
  void dispose() {
    _recognitionService.dispose();
    super.dispose();
  }
}

// プロバイダー
final writingGameLogicProvider = StateNotifierProvider<WritingGameLogic, WritingGameState>(
  (ref) => WritingGameLogic(),
);