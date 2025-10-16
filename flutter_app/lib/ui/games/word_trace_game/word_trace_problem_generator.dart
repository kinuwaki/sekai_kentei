import 'dart:math';
import 'models/word_trace_models.dart';

class WordTraceProblemGenerator {
  static final _random = Random();

  static final List<_WordData> _wordList = [
    _WordData('あさごはんをたべる', '「あさごはんをたべる」\nをなぞろう'),
    _WordData('みずをのむ', '「みずをのむ」\nをなぞろう'),
    _WordData('てをあらう', '「てをあらう」\nをなぞろう'),
    _WordData('そらをみあげる', '「そらをみあげる」\nをなぞろう'),
    _WordData('はをみがく', '「はをみがく」\nをなぞろう'),
    _WordData('くつをはく', '「くつをはく」\nをなぞろう'),
    _WordData('ともだちとあそぶ', '「ともだちとあそぶ」\nをなぞろう'),
    _WordData('ほんをよむ', '「ほんをよむ」\nをなぞろう'),
    _WordData('いぬがはしる', '「いぬがはしる」\nをなぞろう'),
    _WordData('ねこがないてる', '「ねこがないてる」\nをなぞろう'),
    _WordData('おにぎりをたべる', '「おにぎりをたべる」\nをなぞろう'),
    _WordData('あめがふる', '「あめがふる」\nをなぞろう'),
    _WordData('ゆきがつもる', '「ゆきがつもる」\nをなぞろう'),
    _WordData('かぜがふく', '「かぜがふく」\nをなぞろう'),
    _WordData('つきがでている', '「つきがでている」\nをなぞろう'),
    _WordData('ほしがひかる', '「ほしがひかる」\nをなぞろう'),
    _WordData('えをかく', '「えをかく」\nをなぞろう'),
    _WordData('うたをうたう', '「うたをうたう」\nをなぞろう'),
    _WordData('おどりをする', '「おどりをする」\nをなぞろう'),
    _WordData('でんしゃにのる', '「でんしゃにのる」\nをなぞろう'),
    _WordData('くるまがはしる', '「くるまがはしる」\nをなぞろう'),
    _WordData('かわであそぶ', '「かわであそぶ」\nをなぞろう'),
    _WordData('うみでおよぐ', '「うみでおよぐ」\nをなぞろう'),
    _WordData('やまにのぼる', '「やまにのぼる」\nをなぞろう'),
    _WordData('もりをあるく', '「もりをあるく」\nをなぞろう'),
    _WordData('たまごをやく', '「たまごをやく」\nをなぞろう'),
    _WordData('りんごをたべる', '「りんごをたべる」\nをなぞろう'),
    _WordData('すいかをわる', '「すいかをわる」\nをなぞろう'),
    _WordData('おちゃをのむ', '「おちゃをのむ」\nをなぞろう'),
    _WordData('あいさつをする', '「あいさつをする」\nをなぞろう'),
  ];

  static final List<String> _allHiragana = [
    'あ', 'い', 'う', 'え', 'お',
    'か', 'き', 'く', 'け', 'こ',
    'さ', 'し', 'す', 'せ', 'そ',
    'た', 'ち', 'つ', 'て', 'と',
    'な', 'に', 'ぬ', 'ね', 'の',
    'は', 'ひ', 'ふ', 'へ', 'ほ',
    'ま', 'み', 'む', 'め', 'も',
    'や', 'ゆ', 'よ',
    'ら', 'り', 'る', 'れ', 'ろ',
    'わ', 'を', 'ん',
  ];

  static List<WordTraceProblem> generateProblems(int count) {
    final problems = <WordTraceProblem>[];
    final usedWords = <String>{};

    for (int i = 0; i < count; i++) {
      // 使用していない単語をランダムに選択
      final availableWords = _wordList.where((w) => !usedWords.contains(w.word)).toList();
      if (availableWords.isEmpty) {
        usedWords.clear();
        availableWords.addAll(_wordList);
      }

      final wordData = availableWords[_random.nextInt(availableWords.length)];
      usedWords.add(wordData.word);

      problems.add(_generateProblem(wordData));
    }

    return problems;
  }

  static WordTraceProblem _generateProblem(_WordData wordData) {
    const rows = 4;
    const cols = 6;

    // 6x4のグリッドを初期化
    final grid = List.generate(rows, (_) => List.filled(cols, ''));

    // 単語のパスを生成
    final path = _generatePath(wordData.word.length, rows, cols);

    // 単語を配置
    for (int i = 0; i < wordData.word.length; i++) {
      final pos = path[i];
      grid[pos.y][pos.x] = wordData.word[i];
    }

    // 正解に含まれる文字のセットを作成
    final usedChars = wordData.word.split('').toSet();

    // 正解に含まれない文字のリストを作成
    final availableChars = _allHiragana.where((char) => !usedChars.contains(char)).toList();

    // 残りのマスをランダムなひらがなで埋める（正解に含まれない文字のみ）
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        if (grid[y][x].isEmpty) {
          if (availableChars.isNotEmpty) {
            grid[y][x] = availableChars[_random.nextInt(availableChars.length)];
          } else {
            // 万が一利用可能な文字がない場合はすべての文字から選ぶ
            grid[y][x] = _allHiragana[_random.nextInt(_allHiragana.length)];
          }
        }
      }
    }

    return WordTraceProblem(
      targetWord: wordData.word,
      grid: grid,
      correctPath: path,
      questionText: wordData.question,
    );
  }

  static List<CharPosition> _generatePath(int length, int rows, int cols) {
    const maxAttempts = 100;

    for (int attempt = 0; attempt < maxAttempts; attempt++) {
      // ランダムな開始位置
      final startX = _random.nextInt(cols);
      final startY = _random.nextInt(rows);

      final path = [CharPosition(x: startX, y: startY)];
      final visited = <String>{};
      visited.add('$startX,$startY');

      bool success = true;
      for (int i = 1; i < length; i++) {
        final current = path.last;
        final neighbors = _getAvailableNeighbors(current, rows, cols, visited);

        if (neighbors.isEmpty) {
          success = false;
          break;
        }

        final next = neighbors[_random.nextInt(neighbors.length)];
        path.add(next);
        visited.add('${next.x},${next.y}');
      }

      if (success && path.length == length) {
        return path;
      }
    }

    // フォールバック：蛇行パターンで確実に繋がるパスを生成
    final path = <CharPosition>[];
    int x = 0;
    int y = 0;
    int direction = 1; // 1: 右, -1: 左

    for (int i = 0; i < length; i++) {
      path.add(CharPosition(x: x, y: y));

      // 次の位置を決定
      if (x + direction >= 0 && x + direction < cols) {
        x += direction;
      } else {
        // 端に到達したら下に移動して方向転換
        if (y + 1 < rows) {
          y++;
          direction *= -1;
        } else {
          // これ以上進めない場合は同じ行で折り返し
          direction *= -1;
          if (x + direction >= 0 && x + direction < cols) {
            x += direction;
          }
        }
      }
    }

    return path.take(length).toList();
  }

  static List<CharPosition> _getAvailableNeighbors(
    CharPosition current,
    int rows,
    int cols,
    Set<String> visited,
  ) {
    final neighbors = <CharPosition>[];

    // 4方向（上下左右のみ、斜め禁止）
    final directions = [
      [-1, 0], // 左
      [1, 0],  // 右
      [0, -1], // 上
      [0, 1],  // 下
    ];

    for (final dir in directions) {
      final newX = current.x + dir[0];
      final newY = current.y + dir[1];

      if (newX >= 0 &&
          newX < cols &&
          newY >= 0 &&
          newY < rows &&
          !visited.contains('$newX,$newY')) {
        neighbors.add(CharPosition(x: newX, y: newY));
      }
    }

    return neighbors;
  }
}

class _WordData {
  final String word;
  final String question;

  _WordData(this.word, this.question);
}
