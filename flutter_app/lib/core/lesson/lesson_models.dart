/// レッスンデータモデル
class LessonData {
  final int day;
  final String title;
  final ChieLesson chie;
  final KazuLesson kazu;
  final MojiLesson moji;

  const LessonData({
    required this.day,
    required this.title,
    required this.chie,
    required this.kazu,
    required this.moji,
  });

  factory LessonData.fromMap(Map<String, dynamic> map) {
    return LessonData(
      day: map['day'] as int,
      title: map['title'] as String,
      chie: ChieLesson.fromMap(map['chie'] as Map<String, dynamic>),
      kazu: KazuLesson.fromMap(map['kazu'] as Map<String, dynamic>),
      moji: MojiLesson.fromMap(map['moji'] as Map<String, dynamic>),
    );
  }
}

/// ちえレッスン設定
class ChieLesson {
  final String range;
  final int questionCount;
  final List<String> shapes;

  const ChieLesson({
    required this.range,
    required this.questionCount,
    required this.shapes,
  });

  factory ChieLesson.fromMap(Map<String, dynamic> map) {
    return ChieLesson(
      range: map['range'] as String,
      questionCount: map['questionCount'] as int,
      shapes: List<String>.from(map['shapes'] as List),
    );
  }
}

/// かずレッスン設定
class KazuLesson {
  final String range;
  final String displayType;
  final int optionCount;
  final String questionType;
  final int questionCount;

  const KazuLesson({
    required this.range,
    required this.displayType,
    required this.optionCount,
    required this.questionType,
    required this.questionCount,
  });

  factory KazuLesson.fromMap(Map<String, dynamic> map) {
    return KazuLesson(
      range: map['range'] as String,
      displayType: map['displayType'] as String,
      optionCount: map['optionCount'] as int,
      questionType: map['questionType'] as String,
      questionCount: map['questionCount'] as int,
    );
  }
}

/// もじレッスン設定
class MojiLesson {
  final String category;
  final List<String> characters;
  final List<int> sequence;

  const MojiLesson({
    required this.category,
    required this.characters,
    required this.sequence,
  });

  factory MojiLesson.fromMap(Map<String, dynamic> map) {
    return MojiLesson(
      category: map['category'] as String,
      characters: List<String>.from(map['characters'] as List),
      sequence: List<int>.from(map['sequence'] as List),
    );
  }
}

/// コース全体のメタデータ
class CourseMetadata {
  final String title;
  final String description;
  final String version;

  const CourseMetadata({
    required this.title,
    required this.description,
    required this.version,
  });

  factory CourseMetadata.fromMap(Map<String, dynamic> map) {
    return CourseMetadata(
      title: map['title'] as String,
      description: map['description'] as String,
      version: map['version'] as String,
    );
  }
}

/// 4歳コース全体
class Course4yo {
  final List<Map<String, dynamic>> lessons;
  int _currentDay = 1;

  Course4yo({
    required this.lessons,
  });

  factory Course4yo.fromMap(Map<String, dynamic> map) {
    return Course4yo(
      lessons: (map['lessons'] as List)
          .map((lesson) => lesson as Map<String, dynamic>)
          .toList(),
    );
  }
  
  /// 指定された日のレッスンを取得
  Map<String, dynamic>? getLessonByDay(int day) {
    if (day > 0 && day <= lessons.length) {
      return lessons[day - 1];
    }
    return null;
  }

  /// 現在のレッスンを取得
  Map<String, dynamic> get currentLesson => getLessonByDay(_currentDay) ?? lessons.first;
  
  /// 現在のレッスン番号を取得（例：Ａ-１）
  String get currentLessonNumber {
    final level = ((_currentDay - 1) ~/ 10) + 1; // 10日ごとにレベルアップ
    final lessonInLevel = ((_currentDay - 1) % 10) + 1;
    
    // レベルをアルファベットに変換（1=Ａ, 2=Ｂ, 3=Ｃ...）
    final levelChar = String.fromCharCode(0xFF21 + (level - 1)); // 全角Ａから
    final lessonNum = '${lessonInLevel}'.padLeft(1, '０'); // 全角数字
    
    return 'レベル$levelChar-$lessonNum';
  }
  
  /// 現在のレッスンタイトル（例：４さい レベルＡ-１）
  String get currentLessonTitle => '４さい $currentLessonNumber';
  
  /// 現在の日数を取得
  int get currentDay => _currentDay;
  
  /// 次のレッスンに進む（今日のレッスン完了時）
  void advanceToNextLesson() {
    if (_currentDay < lessons.length) {
      _currentDay++;
    }
  }
  
  /// 今日のレッスンを取得（後方互換性のため）
  LessonData get todayLesson => LessonData.fromMap(currentLesson);
}