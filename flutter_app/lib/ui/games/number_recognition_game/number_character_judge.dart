import '../../../core/debug_logger.dart';
import '../writing_game/writing_game_models.dart';

/// 数字認識用の文字判定システム
/// 文字練習の AdvancedCharacterJudge と同様の候補ベース判定を数字に適用
class NumberCharacterJudge {
  /// 数字パターンの正規表現（0-9の数字のみ）
  static const String _numberPattern = r'^[0-9]$';

  /// 数字認識結果を判定する（候補ベース）
  ///
  /// [targetNumber] 期待する数字（例: 3）
  /// [result] ML Kitからの認識結果
  static NumberJudgmentResult judge({
    required int targetNumber,
    required RecognitionResult result,
  }) {
    final targetString = targetNumber.toString();
    Log.d('NumberCharacterJudge: Starting judgment for target="$targetString"');
    Log.d('NumberCharacterJudge: Input candidates: ${result.candidates.length}');

    // デバッグ：全候補を表示
    for (int i = 0; i < result.candidates.length; i++) {
      final c = result.candidates[i];
      Log.d('NumberCharacterJudge: Raw candidate ${i + 1}: "${c.text}"');
    }

    // 1. 数字フィルタリング（0-9の1桁のみ）
    final filtered = _filterNumberCandidates(result.candidates);
    Log.d('NumberCharacterJudge: After filtering: ${filtered.length} candidates');

    if (filtered.isEmpty) {
      return NumberJudgmentResult(
        isAccepted: false,
        reason: 'No number candidates found',
        targetRank: -1,
        targetScore: 0.0,
        numberRanking: [],
        debugInfo: 'Number filter eliminated all candidates',
      );
    }

    // 2. スコア順でソート
    final sortedCandidates = List<RecognizedCandidate>.from(filtered);
    sortedCandidates.sort((a, b) => b.confidence.compareTo(a.confidence));

    // 3. トップスコアを基準とした詳細ログ
    final bestScore = sortedCandidates.first.confidence;
    Log.d('NumberCharacterJudge: Best score: ${bestScore.toStringAsFixed(3)}');
    _logCandidateDetails(sortedCandidates, bestScore);

    // 4. 全候補の詳細表示（自由書きのような候補リスト出力）
    Log.d('NumberCharacterJudge: ===== 認識候補一覧 =====');
    for (int i = 0; i < sortedCandidates.length && i < 15; i++) {
      final candidate = sortedCandidates[i];
      Log.d('NumberCharacterJudge: ${i + 1}位: "${candidate.text}"');
    }
    if (sortedCandidates.length > 15) {
      Log.d('NumberCharacterJudge: ... その他 ${sortedCandidates.length - 15} 個の候補');
    }

    // 5. ターゲット数字の検索
    RecognizedCandidate? targetCandidate;
    int targetRank = -1;

    for (int i = 0; i < sortedCandidates.length; i++) {
      final candidate = sortedCandidates[i];
      if (candidate.text == targetString) {
        targetCandidate = candidate;
        targetRank = i + 1; // 1-indexed
        break;
      }
    }

    if (targetCandidate == null) {
      Log.d('NumberCharacterJudge: ❌ 目標数字 "$targetString" は候補に含まれていません');
      Log.d('NumberCharacterJudge: 上位候補: ${sortedCandidates.take(5).map((c) => '"${c.text}"').join(', ')}');
      return NumberJudgmentResult(
        isAccepted: false,
        reason: 'Target number "$targetString" not found in candidates',
        targetRank: -1,
        targetScore: 0.0,
        numberRanking: _createNumberRanking(sortedCandidates),
        debugInfo: 'Target not found in ${sortedCandidates.length} candidates',
      );
    }

    // 6. 候補存在判定（文字練習と同じロジック）
    final targetScore = targetCandidate.confidence;
    const isAccepted = true; // 候補に含まれていれば自動的に合格
    final reason = 'Accepted: Target found in candidates at rank $targetRank';

    Log.d('NumberCharacterJudge: ✅ 目標数字 "$targetString" が第${targetRank}位で発見されました！');

    return NumberJudgmentResult(
      isAccepted: isAccepted,
      reason: reason,
      targetRank: targetRank,
      targetScore: targetScore,
      numberRanking: _createNumberRanking(sortedCandidates),
      debugInfo: 'Target found at rank $targetRank with score ${targetScore.toStringAsFixed(3)}',
    );
  }

  /// 数字候補のフィルタリング（0-9の1桁のみ）
  static List<RecognizedCandidate> _filterNumberCandidates(
    List<RecognizedCandidate> candidates,
  ) {
    final regex = RegExp(_numberPattern);

    // 数字パターンでフィルタリング
    final numberFiltered = candidates.where((candidate) =>
      regex.hasMatch(candidate.text)
    ).toList();

    Log.d('NumberCharacterJudge: Number filter: ${candidates.length} -> ${numberFiltered.length}');

    // フィルタリング後の候補をデバッグ出力
    if (numberFiltered.isNotEmpty) {
      final top10Filtered = numberFiltered.take(10).map((c) =>
        '${c.text}(${c.confidence.toStringAsFixed(2)})'
      ).join(', ');
      Log.d('NumberCharacterJudge: Filtered candidates (top 10): $top10Filtered');
    } else {
      // 数字が見つからない場合のデバッグ情報
      Log.d('NumberCharacterJudge: No numbers found! Available candidates:');
      final allCandidates = candidates.take(10).map((c) =>
        '${c.text}(len=${c.text.length}, conf=${c.confidence.toStringAsFixed(2)})'
      ).join(', ');
      Log.d('NumberCharacterJudge: All candidates: $allCandidates');
    }

    return numberFiltered;
  }

  /// 候補の詳細なデバッグログを出力
  static void _logCandidateDetails(List<RecognizedCandidate> sortedCandidates, double bestScore) {
    Log.d('NumberCharacterJudge: === Recognition Candidates ===');

    final displayCount = sortedCandidates.length > 10 ? 10 : sortedCandidates.length;
    for (int i = 0; i < displayCount; i++) {
      final candidate = sortedCandidates[i];
      final ratio = candidate.confidence / bestScore;
      Log.d('NumberCharacterJudge: text=\'${candidate.text}\', score=${candidate.confidence.toStringAsFixed(3)}, ratio=${ratio.toStringAsFixed(2)}');
    }

    if (sortedCandidates.length > 10) {
      Log.d('NumberCharacterJudge: ... and ${sortedCandidates.length - 10} more candidates');
    }
  }

  /// 候補リストからNumberScoreランキングを作成
  static List<NumberScore> _createNumberRanking(List<RecognizedCandidate> sortedCandidates) {
    return sortedCandidates.map((candidate) =>
      NumberScore(number: candidate.text, score: candidate.confidence)
    ).toList();
  }
}

/// 数字のスコア情報
class NumberScore {
  final String number;
  final double score;

  const NumberScore({
    required this.number,
    required this.score,
  });

  @override
  String toString() => '$number: ${score.toStringAsFixed(3)}';
}

/// 数字判定結果
class NumberJudgmentResult {
  final bool isAccepted;
  final String reason;
  final int targetRank; // -1 if not found
  final double targetScore;
  final List<NumberScore> numberRanking;
  final String debugInfo;

  const NumberJudgmentResult({
    required this.isAccepted,
    required this.reason,
    required this.targetRank,
    required this.targetScore,
    required this.numberRanking,
    required this.debugInfo,
  });

  @override
  String toString() {
    final top5 = numberRanking.take(5).map((ns) => ns.toString()).join(', ');
    final cleanReason = reason.replaceAll('NaN', 'N/A');
    return 'NumberJudgmentResult(accepted: $isAccepted, reason: "$cleanReason", ranking: [$top5])';
  }
}