import '../../../core/debug_logger.dart';
import 'writing_game_models.dart';

/// 相対スコア方式の文字認識判定システム
/// トップ候補のスコアを基準とした相対評価で判定を行う
class AdvancedCharacterJudge {
  static const double _defaultRatioThreshold = 0.5; // トップスコアに対する比率閾値（甘め設定）

  /// スクリプトタイプ別の正規表現パターン
  static const Map<ScriptType, String> _scriptPatterns = {
    ScriptType.hiragana: r'^[\u3041-\u3096\u3099-\u309F]+$',
    ScriptType.katakana: r'^[\u30A1-\u30FA\u30FC-\u30FF\uFF66-\uFF9F]+$',
    ScriptType.kanji: r'^[\u3400-\u9FFF\u3005\u3006]+$',
    ScriptType.mixed: r'^[\u3041-\u3096\u3099-\u309F\u30A1-\u30FA\u30FC-\u30FF\uFF66-\uFF9F\u3400-\u9FFF\u3005\u3006]+$',
  };

  /// 相対スコア方式で文字認識結果を判定する
  ///
  /// [targetChar] 期待する文字（例: "あ"）
  /// [result] ML Kitからの認識結果
  /// [scriptType] 期待するスクリプトタイプ
  /// [ratioThreshold] トップスコアに対する比率閾値（デフォルト: 0.5）
  static CharacterJudgmentResult judge({
    required String targetChar,
    required RecognitionResult result,
    required ScriptType scriptType,
    double ratioThreshold = _defaultRatioThreshold,
  }) {
    Log.d('AdvancedCharacterJudge: Starting judgment for target="$targetChar"');
    Log.d('AdvancedCharacterJudge: Input candidates: ${result.candidates.length}');
    // デバッグ：全候補を表示
    for (int i = 0; i < result.candidates.length; i++) {
      final c = result.candidates[i];
      Log.d('AdvancedCharacterJudge: Raw candidate ${i + 1}: "${c.text}"');
    }

    // 1. スクリプト別フィルタリング + 文字数フィルタリング
    final filtered = _filterCandidates(result.candidates, scriptType);
    Log.d('AdvancedCharacterJudge: After filtering: ${filtered.length} candidates');

    if (filtered.isEmpty) {
      return CharacterJudgmentResult(
        isAccepted: false,
        reason: 'No candidates match the expected script type',
        targetRank: -1,
        targetScore: 0.0,
        characterRanking: [],
        debugInfo: 'Script filter eliminated all candidates',
      );
    }

    // 2. スコア順でソート
    final sortedCandidates = List<RecognizedCandidate>.from(filtered);
    sortedCandidates.sort((a, b) => b.confidence.compareTo(a.confidence));

    if (sortedCandidates.isEmpty) {
      return CharacterJudgmentResult(
        isAccepted: false,
        reason: 'No valid candidates found',
        targetRank: -1,
        targetScore: 0.0,
        characterRanking: [],
        debugInfo: 'Empty candidate list after filtering',
      );
    }

    // 3. トップスコアを基準とした相対評価
    final bestScore = sortedCandidates.first.confidence;
    Log.d('AdvancedCharacterJudge: Best score: ${bestScore.toStringAsFixed(3)}');

    // 4. 詳細なデバッグ出力
    _logCandidateDetails(sortedCandidates, bestScore);

    // 5. ターゲット文字の検索と判定
    RecognizedCandidate? targetCandidate;
    int targetRank = -1;

    for (int i = 0; i < sortedCandidates.length; i++) {
      final candidate = sortedCandidates[i];
      if (candidate.text == targetChar) {
        targetCandidate = candidate;
        targetRank = i + 1; // 1-indexed
        break;
      }
    }

    if (targetCandidate == null) {
      return CharacterJudgmentResult(
        isAccepted: false,
        reason: 'Target character "$targetChar" not found in candidates',
        targetRank: -1,
        targetScore: 0.0,
        characterRanking: _createCharacterRanking(sortedCandidates),
        debugInfo: 'Target not found in ${sortedCandidates.length} candidates',
      );
    }

    // 6. 候補存在判定（スコア不要）
    final targetScore = targetCandidate.confidence;
    const isAccepted = true; // 候補に含まれていれば自動的に合格
    const reason = 'Accepted: Target found in candidates';

    Log.d('AdvancedCharacterJudge: Target "$targetChar" - rank: $targetRank');

    return CharacterJudgmentResult(
      isAccepted: isAccepted,
      reason: reason,
      targetRank: targetRank,
      targetScore: targetScore,
      characterRanking: _createCharacterRanking(sortedCandidates),
      debugInfo: 'Target found at rank $targetRank',
    );
  }

  /// スクリプト別フィルタリング + 文字数フィルタリング
  static List<RecognizedCandidate> _filterCandidates(
    List<RecognizedCandidate> candidates,
    ScriptType scriptType,
  ) {
    final pattern = _scriptPatterns[scriptType];
    if (pattern == null) return candidates;

    final regex = RegExp(pattern);

    // 1. スクリプトタイプでフィルタリング
    final scriptFiltered = candidates.where((candidate) => regex.hasMatch(candidate.text)).toList();

    // 2. 1文字のみでフィルタリング（複数文字の候補を除外）
    final singleCharFiltered = scriptFiltered.where((candidate) => candidate.text.length == 1).toList();

    Log.d('AdvancedCharacterJudge: Script filter: ${candidates.length} -> ${scriptFiltered.length}');
    Log.d('AdvancedCharacterJudge: Single char filter: ${scriptFiltered.length} -> ${singleCharFiltered.length}');

    // フィルタリング後の候補をデバッグ出力（ひらがなが見つからない場合を考慮）
    if (singleCharFiltered.isNotEmpty) {
      final top10Filtered = singleCharFiltered.take(10).map((c) => '${c.text}(${c.confidence.toStringAsFixed(2)})').join(', ');
      Log.d('AdvancedCharacterJudge: Filtered candidates (top 10): $top10Filtered');
    } else {
      // ひらがなが見つからない場合のデバッグ情報
      Log.d('AdvancedCharacterJudge: No hiragana found! Available candidates:');
      final allCandidates = candidates.take(10).map((c) => '${c.text}(len=${c.text.length}, conf=${c.confidence.toStringAsFixed(2)})').join(', ');
      Log.d('AdvancedCharacterJudge: All candidates: $allCandidates');
    }

    return singleCharFiltered;
  }

  /// 候補の詳細なデバッグログを出力
  static void _logCandidateDetails(List<RecognizedCandidate> sortedCandidates, double bestScore) {
    Log.d('AdvancedCharacterJudge: === Recognition Candidates ===');

    final displayCount = sortedCandidates.length > 10 ? 10 : sortedCandidates.length;
    for (int i = 0; i < displayCount; i++) {
      final candidate = sortedCandidates[i];
      final ratio = candidate.confidence / bestScore;
      Log.d('AdvancedCharacterJudge: text=\'${candidate.text}\', score=${candidate.confidence.toStringAsFixed(3)}, ratio=${ratio.toStringAsFixed(2)}');
    }

    if (sortedCandidates.length > 10) {
      Log.d('AdvancedCharacterJudge: ... and ${sortedCandidates.length - 10} more candidates');
    }
  }

  /// 候補リストからCharacterScoreランキングを作成
  static List<CharacterScore> _createCharacterRanking(List<RecognizedCandidate> sortedCandidates) {
    return sortedCandidates.map((candidate) =>
      CharacterScore(character: candidate.text, score: candidate.confidence)
    ).toList();
  }
}

/// スクリプトタイプ
enum ScriptType {
  hiragana,
  katakana,
  kanji,
  mixed, // ひらがな・カタカナ・漢字の組み合わせ
}

/// 文字のスコア情報
class CharacterScore {
  final String character;
  final double score;

  const CharacterScore({
    required this.character,
    required this.score,
  });

  @override
  String toString() => '$character: ${score.toStringAsFixed(3)}';
}

/// 文字判定結果
class CharacterJudgmentResult {
  final bool isAccepted;
  final String reason;
  final int targetRank; // -1 if not found
  final double targetScore;
  final List<CharacterScore> characterRanking;
  final String debugInfo;

  const CharacterJudgmentResult({
    required this.isAccepted,
    required this.reason,
    required this.targetRank,
    required this.targetScore,
    required this.characterRanking,
    required this.debugInfo,
  });

  @override
  String toString() {
    final top5 = characterRanking.take(5).map((cs) => cs.toString()).join(', ');
    // reasonがNaNを含む場合は適切に表示
    final cleanReason = reason.replaceAll('NaN', 'N/A');
    return 'CharacterJudgmentResult(accepted: $isAccepted, reason: "$cleanReason", ranking: [$top5])';
  }
}