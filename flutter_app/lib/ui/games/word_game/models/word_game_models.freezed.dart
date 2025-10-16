// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word_game_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WordGameSettings {

 WordGameMode get mode; QuestionType get questionType; int get questionCount; int get optionCount;
/// Create a copy of WordGameSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordGameSettingsCopyWith<WordGameSettings> get copyWith => _$WordGameSettingsCopyWithImpl<WordGameSettings>(this as WordGameSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordGameSettings&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.questionType, questionType) || other.questionType == questionType)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.optionCount, optionCount) || other.optionCount == optionCount));
}


@override
int get hashCode => Object.hash(runtimeType,mode,questionType,questionCount,optionCount);

@override
String toString() {
  return 'WordGameSettings(mode: $mode, questionType: $questionType, questionCount: $questionCount, optionCount: $optionCount)';
}


}

/// @nodoc
abstract mixin class $WordGameSettingsCopyWith<$Res>  {
  factory $WordGameSettingsCopyWith(WordGameSettings value, $Res Function(WordGameSettings) _then) = _$WordGameSettingsCopyWithImpl;
@useResult
$Res call({
 WordGameMode mode, QuestionType questionType, int questionCount, int optionCount
});




}
/// @nodoc
class _$WordGameSettingsCopyWithImpl<$Res>
    implements $WordGameSettingsCopyWith<$Res> {
  _$WordGameSettingsCopyWithImpl(this._self, this._then);

  final WordGameSettings _self;
  final $Res Function(WordGameSettings) _then;

/// Create a copy of WordGameSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? questionType = null,Object? questionCount = null,Object? optionCount = null,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as WordGameMode,questionType: null == questionType ? _self.questionType : questionType // ignore: cast_nullable_to_non_nullable
as QuestionType,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,optionCount: null == optionCount ? _self.optionCount : optionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WordGameSettings].
extension WordGameSettingsPatterns on WordGameSettings {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordGameSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordGameSettings() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordGameSettings value)  $default,){
final _that = this;
switch (_that) {
case _WordGameSettings():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordGameSettings value)?  $default,){
final _that = this;
switch (_that) {
case _WordGameSettings() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( WordGameMode mode,  QuestionType questionType,  int questionCount,  int optionCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordGameSettings() when $default != null:
return $default(_that.mode,_that.questionType,_that.questionCount,_that.optionCount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( WordGameMode mode,  QuestionType questionType,  int questionCount,  int optionCount)  $default,) {final _that = this;
switch (_that) {
case _WordGameSettings():
return $default(_that.mode,_that.questionType,_that.questionCount,_that.optionCount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( WordGameMode mode,  QuestionType questionType,  int questionCount,  int optionCount)?  $default,) {final _that = this;
switch (_that) {
case _WordGameSettings() when $default != null:
return $default(_that.mode,_that.questionType,_that.questionCount,_that.optionCount);case _:
  return null;

}
}

}

/// @nodoc


class _WordGameSettings extends WordGameSettings {
  const _WordGameSettings({this.mode = WordGameMode.hiraganaMode, this.questionType = QuestionType.pictureToText, this.questionCount = 5, this.optionCount = 4}): super._();
  

@override@JsonKey() final  WordGameMode mode;
@override@JsonKey() final  QuestionType questionType;
@override@JsonKey() final  int questionCount;
@override@JsonKey() final  int optionCount;

/// Create a copy of WordGameSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordGameSettingsCopyWith<_WordGameSettings> get copyWith => __$WordGameSettingsCopyWithImpl<_WordGameSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordGameSettings&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.questionType, questionType) || other.questionType == questionType)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.optionCount, optionCount) || other.optionCount == optionCount));
}


@override
int get hashCode => Object.hash(runtimeType,mode,questionType,questionCount,optionCount);

@override
String toString() {
  return 'WordGameSettings(mode: $mode, questionType: $questionType, questionCount: $questionCount, optionCount: $optionCount)';
}


}

/// @nodoc
abstract mixin class _$WordGameSettingsCopyWith<$Res> implements $WordGameSettingsCopyWith<$Res> {
  factory _$WordGameSettingsCopyWith(_WordGameSettings value, $Res Function(_WordGameSettings) _then) = __$WordGameSettingsCopyWithImpl;
@override @useResult
$Res call({
 WordGameMode mode, QuestionType questionType, int questionCount, int optionCount
});




}
/// @nodoc
class __$WordGameSettingsCopyWithImpl<$Res>
    implements _$WordGameSettingsCopyWith<$Res> {
  __$WordGameSettingsCopyWithImpl(this._self, this._then);

  final _WordGameSettings _self;
  final $Res Function(_WordGameSettings) _then;

/// Create a copy of WordGameSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? questionType = null,Object? questionCount = null,Object? optionCount = null,}) {
  return _then(_WordGameSettings(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as WordGameMode,questionType: null == questionType ? _self.questionType : questionType // ignore: cast_nullable_to_non_nullable
as QuestionType,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,optionCount: null == optionCount ? _self.optionCount : optionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$WordGameProblem {

 String get word;// 単語（例：くるま）
 String get imagePath;// 画像パス
 List<String> get options;// 選択肢
 int get correctIndex;// 正解のインデックス
 QuestionType get questionType;// 問題タイプ
 String get scriptType;
/// Create a copy of WordGameProblem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordGameProblemCopyWith<WordGameProblem> get copyWith => _$WordGameProblemCopyWithImpl<WordGameProblem>(this as WordGameProblem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordGameProblem&&(identical(other.word, word) || other.word == word)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.correctIndex, correctIndex) || other.correctIndex == correctIndex)&&(identical(other.questionType, questionType) || other.questionType == questionType)&&(identical(other.scriptType, scriptType) || other.scriptType == scriptType));
}


@override
int get hashCode => Object.hash(runtimeType,word,imagePath,const DeepCollectionEquality().hash(options),correctIndex,questionType,scriptType);

@override
String toString() {
  return 'WordGameProblem(word: $word, imagePath: $imagePath, options: $options, correctIndex: $correctIndex, questionType: $questionType, scriptType: $scriptType)';
}


}

/// @nodoc
abstract mixin class $WordGameProblemCopyWith<$Res>  {
  factory $WordGameProblemCopyWith(WordGameProblem value, $Res Function(WordGameProblem) _then) = _$WordGameProblemCopyWithImpl;
@useResult
$Res call({
 String word, String imagePath, List<String> options, int correctIndex, QuestionType questionType, String scriptType
});




}
/// @nodoc
class _$WordGameProblemCopyWithImpl<$Res>
    implements $WordGameProblemCopyWith<$Res> {
  _$WordGameProblemCopyWithImpl(this._self, this._then);

  final WordGameProblem _self;
  final $Res Function(WordGameProblem) _then;

/// Create a copy of WordGameProblem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? word = null,Object? imagePath = null,Object? options = null,Object? correctIndex = null,Object? questionType = null,Object? scriptType = null,}) {
  return _then(_self.copyWith(
word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>,correctIndex: null == correctIndex ? _self.correctIndex : correctIndex // ignore: cast_nullable_to_non_nullable
as int,questionType: null == questionType ? _self.questionType : questionType // ignore: cast_nullable_to_non_nullable
as QuestionType,scriptType: null == scriptType ? _self.scriptType : scriptType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WordGameProblem].
extension WordGameProblemPatterns on WordGameProblem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordGameProblem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordGameProblem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordGameProblem value)  $default,){
final _that = this;
switch (_that) {
case _WordGameProblem():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordGameProblem value)?  $default,){
final _that = this;
switch (_that) {
case _WordGameProblem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String word,  String imagePath,  List<String> options,  int correctIndex,  QuestionType questionType,  String scriptType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordGameProblem() when $default != null:
return $default(_that.word,_that.imagePath,_that.options,_that.correctIndex,_that.questionType,_that.scriptType);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String word,  String imagePath,  List<String> options,  int correctIndex,  QuestionType questionType,  String scriptType)  $default,) {final _that = this;
switch (_that) {
case _WordGameProblem():
return $default(_that.word,_that.imagePath,_that.options,_that.correctIndex,_that.questionType,_that.scriptType);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String word,  String imagePath,  List<String> options,  int correctIndex,  QuestionType questionType,  String scriptType)?  $default,) {final _that = this;
switch (_that) {
case _WordGameProblem() when $default != null:
return $default(_that.word,_that.imagePath,_that.options,_that.correctIndex,_that.questionType,_that.scriptType);case _:
  return null;

}
}

}

/// @nodoc


class _WordGameProblem extends WordGameProblem {
  const _WordGameProblem({required this.word, required this.imagePath, required final  List<String> options, required this.correctIndex, required this.questionType, required this.scriptType}): _options = options,super._();
  

@override final  String word;
// 単語（例：くるま）
@override final  String imagePath;
// 画像パス
 final  List<String> _options;
// 画像パス
@override List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

// 選択肢
@override final  int correctIndex;
// 正解のインデックス
@override final  QuestionType questionType;
// 問題タイプ
@override final  String scriptType;

/// Create a copy of WordGameProblem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordGameProblemCopyWith<_WordGameProblem> get copyWith => __$WordGameProblemCopyWithImpl<_WordGameProblem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordGameProblem&&(identical(other.word, word) || other.word == word)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.correctIndex, correctIndex) || other.correctIndex == correctIndex)&&(identical(other.questionType, questionType) || other.questionType == questionType)&&(identical(other.scriptType, scriptType) || other.scriptType == scriptType));
}


@override
int get hashCode => Object.hash(runtimeType,word,imagePath,const DeepCollectionEquality().hash(_options),correctIndex,questionType,scriptType);

@override
String toString() {
  return 'WordGameProblem(word: $word, imagePath: $imagePath, options: $options, correctIndex: $correctIndex, questionType: $questionType, scriptType: $scriptType)';
}


}

/// @nodoc
abstract mixin class _$WordGameProblemCopyWith<$Res> implements $WordGameProblemCopyWith<$Res> {
  factory _$WordGameProblemCopyWith(_WordGameProblem value, $Res Function(_WordGameProblem) _then) = __$WordGameProblemCopyWithImpl;
@override @useResult
$Res call({
 String word, String imagePath, List<String> options, int correctIndex, QuestionType questionType, String scriptType
});




}
/// @nodoc
class __$WordGameProblemCopyWithImpl<$Res>
    implements _$WordGameProblemCopyWith<$Res> {
  __$WordGameProblemCopyWithImpl(this._self, this._then);

  final _WordGameProblem _self;
  final $Res Function(_WordGameProblem) _then;

/// Create a copy of WordGameProblem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? word = null,Object? imagePath = null,Object? options = null,Object? correctIndex = null,Object? questionType = null,Object? scriptType = null,}) {
  return _then(_WordGameProblem(
word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>,correctIndex: null == correctIndex ? _self.correctIndex : correctIndex // ignore: cast_nullable_to_non_nullable
as int,questionType: null == questionType ? _self.questionType : questionType // ignore: cast_nullable_to_non_nullable
as QuestionType,scriptType: null == scriptType ? _self.scriptType : scriptType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$WordGameSession {

 int get index; int get total; List<bool?> get results; WordGameProblem? get currentProblem; List<int> get selectedIndices;// 選択された選択肢
 int get wrongAnswers;
/// Create a copy of WordGameSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordGameSessionCopyWith<WordGameSession> get copyWith => _$WordGameSessionCopyWithImpl<WordGameSession>(this as WordGameSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordGameSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&const DeepCollectionEquality().equals(other.selectedIndices, selectedIndices)&&(identical(other.wrongAnswers, wrongAnswers) || other.wrongAnswers == wrongAnswers));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(results),currentProblem,const DeepCollectionEquality().hash(selectedIndices),wrongAnswers);

@override
String toString() {
  return 'WordGameSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, selectedIndices: $selectedIndices, wrongAnswers: $wrongAnswers)';
}


}

/// @nodoc
abstract mixin class $WordGameSessionCopyWith<$Res>  {
  factory $WordGameSessionCopyWith(WordGameSession value, $Res Function(WordGameSession) _then) = _$WordGameSessionCopyWithImpl;
@useResult
$Res call({
 int index, int total, List<bool?> results, WordGameProblem? currentProblem, List<int> selectedIndices, int wrongAnswers
});


$WordGameProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class _$WordGameSessionCopyWithImpl<$Res>
    implements $WordGameSessionCopyWith<$Res> {
  _$WordGameSessionCopyWithImpl(this._self, this._then);

  final WordGameSession _self;
  final $Res Function(WordGameSession) _then;

/// Create a copy of WordGameSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? selectedIndices = null,Object? wrongAnswers = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as WordGameProblem?,selectedIndices: null == selectedIndices ? _self.selectedIndices : selectedIndices // ignore: cast_nullable_to_non_nullable
as List<int>,wrongAnswers: null == wrongAnswers ? _self.wrongAnswers : wrongAnswers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of WordGameSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordGameProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $WordGameProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}


/// Adds pattern-matching-related methods to [WordGameSession].
extension WordGameSessionPatterns on WordGameSession {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordGameSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordGameSession() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordGameSession value)  $default,){
final _that = this;
switch (_that) {
case _WordGameSession():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordGameSession value)?  $default,){
final _that = this;
switch (_that) {
case _WordGameSession() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  WordGameProblem? currentProblem,  List<int> selectedIndices,  int wrongAnswers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordGameSession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.selectedIndices,_that.wrongAnswers);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  WordGameProblem? currentProblem,  List<int> selectedIndices,  int wrongAnswers)  $default,) {final _that = this;
switch (_that) {
case _WordGameSession():
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.selectedIndices,_that.wrongAnswers);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  int total,  List<bool?> results,  WordGameProblem? currentProblem,  List<int> selectedIndices,  int wrongAnswers)?  $default,) {final _that = this;
switch (_that) {
case _WordGameSession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.selectedIndices,_that.wrongAnswers);case _:
  return null;

}
}

}

/// @nodoc


class _WordGameSession extends WordGameSession {
  const _WordGameSession({required this.index, required this.total, required final  List<bool?> results, this.currentProblem, final  List<int> selectedIndices = const [], this.wrongAnswers = 0}): _results = results,_selectedIndices = selectedIndices,super._();
  

@override final  int index;
@override final  int total;
 final  List<bool?> _results;
@override List<bool?> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override final  WordGameProblem? currentProblem;
 final  List<int> _selectedIndices;
@override@JsonKey() List<int> get selectedIndices {
  if (_selectedIndices is EqualUnmodifiableListView) return _selectedIndices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedIndices);
}

// 選択された選択肢
@override@JsonKey() final  int wrongAnswers;

/// Create a copy of WordGameSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordGameSessionCopyWith<_WordGameSession> get copyWith => __$WordGameSessionCopyWithImpl<_WordGameSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordGameSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&const DeepCollectionEquality().equals(other._selectedIndices, _selectedIndices)&&(identical(other.wrongAnswers, wrongAnswers) || other.wrongAnswers == wrongAnswers));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(_results),currentProblem,const DeepCollectionEquality().hash(_selectedIndices),wrongAnswers);

@override
String toString() {
  return 'WordGameSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, selectedIndices: $selectedIndices, wrongAnswers: $wrongAnswers)';
}


}

/// @nodoc
abstract mixin class _$WordGameSessionCopyWith<$Res> implements $WordGameSessionCopyWith<$Res> {
  factory _$WordGameSessionCopyWith(_WordGameSession value, $Res Function(_WordGameSession) _then) = __$WordGameSessionCopyWithImpl;
@override @useResult
$Res call({
 int index, int total, List<bool?> results, WordGameProblem? currentProblem, List<int> selectedIndices, int wrongAnswers
});


@override $WordGameProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class __$WordGameSessionCopyWithImpl<$Res>
    implements _$WordGameSessionCopyWith<$Res> {
  __$WordGameSessionCopyWithImpl(this._self, this._then);

  final _WordGameSession _self;
  final $Res Function(_WordGameSession) _then;

/// Create a copy of WordGameSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? selectedIndices = null,Object? wrongAnswers = null,}) {
  return _then(_WordGameSession(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as WordGameProblem?,selectedIndices: null == selectedIndices ? _self._selectedIndices : selectedIndices // ignore: cast_nullable_to_non_nullable
as List<int>,wrongAnswers: null == wrongAnswers ? _self.wrongAnswers : wrongAnswers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of WordGameSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordGameProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $WordGameProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}

/// @nodoc
mixin _$WordGameState {

 CommonGamePhase get phase; WordGameSettings? get settings; WordGameSession? get session; AnswerResult? get lastResult; int get epoch;
/// Create a copy of WordGameState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordGameStateCopyWith<WordGameState> get copyWith => _$WordGameStateCopyWithImpl<WordGameState>(this as WordGameState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordGameState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.lastResult, lastResult) || other.lastResult == lastResult)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,lastResult,epoch);

@override
String toString() {
  return 'WordGameState(phase: $phase, settings: $settings, session: $session, lastResult: $lastResult, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class $WordGameStateCopyWith<$Res>  {
  factory $WordGameStateCopyWith(WordGameState value, $Res Function(WordGameState) _then) = _$WordGameStateCopyWithImpl;
@useResult
$Res call({
 CommonGamePhase phase, WordGameSettings? settings, WordGameSession? session, AnswerResult? lastResult, int epoch
});


$WordGameSettingsCopyWith<$Res>? get settings;$WordGameSessionCopyWith<$Res>? get session;$AnswerResultCopyWith<$Res>? get lastResult;

}
/// @nodoc
class _$WordGameStateCopyWithImpl<$Res>
    implements $WordGameStateCopyWith<$Res> {
  _$WordGameStateCopyWithImpl(this._self, this._then);

  final WordGameState _self;
  final $Res Function(WordGameState) _then;

/// Create a copy of WordGameState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? lastResult = freezed,Object? epoch = null,}) {
  return _then(_self.copyWith(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as WordGameSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as WordGameSession?,lastResult: freezed == lastResult ? _self.lastResult : lastResult // ignore: cast_nullable_to_non_nullable
as AnswerResult?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of WordGameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordGameSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $WordGameSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of WordGameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordGameSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $WordGameSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of WordGameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnswerResultCopyWith<$Res>? get lastResult {
    if (_self.lastResult == null) {
    return null;
  }

  return $AnswerResultCopyWith<$Res>(_self.lastResult!, (value) {
    return _then(_self.copyWith(lastResult: value));
  });
}
}


/// Adds pattern-matching-related methods to [WordGameState].
extension WordGameStatePatterns on WordGameState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordGameState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordGameState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordGameState value)  $default,){
final _that = this;
switch (_that) {
case _WordGameState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordGameState value)?  $default,){
final _that = this;
switch (_that) {
case _WordGameState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CommonGamePhase phase,  WordGameSettings? settings,  WordGameSession? session,  AnswerResult? lastResult,  int epoch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordGameState() when $default != null:
return $default(_that.phase,_that.settings,_that.session,_that.lastResult,_that.epoch);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CommonGamePhase phase,  WordGameSettings? settings,  WordGameSession? session,  AnswerResult? lastResult,  int epoch)  $default,) {final _that = this;
switch (_that) {
case _WordGameState():
return $default(_that.phase,_that.settings,_that.session,_that.lastResult,_that.epoch);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CommonGamePhase phase,  WordGameSettings? settings,  WordGameSession? session,  AnswerResult? lastResult,  int epoch)?  $default,) {final _that = this;
switch (_that) {
case _WordGameState() when $default != null:
return $default(_that.phase,_that.settings,_that.session,_that.lastResult,_that.epoch);case _:
  return null;

}
}

}

/// @nodoc


class _WordGameState extends WordGameState {
  const _WordGameState({this.phase = CommonGamePhase.ready, this.settings, this.session, this.lastResult, this.epoch = 0}): super._();
  

@override@JsonKey() final  CommonGamePhase phase;
@override final  WordGameSettings? settings;
@override final  WordGameSession? session;
@override final  AnswerResult? lastResult;
@override@JsonKey() final  int epoch;

/// Create a copy of WordGameState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordGameStateCopyWith<_WordGameState> get copyWith => __$WordGameStateCopyWithImpl<_WordGameState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordGameState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.lastResult, lastResult) || other.lastResult == lastResult)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,lastResult,epoch);

@override
String toString() {
  return 'WordGameState(phase: $phase, settings: $settings, session: $session, lastResult: $lastResult, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class _$WordGameStateCopyWith<$Res> implements $WordGameStateCopyWith<$Res> {
  factory _$WordGameStateCopyWith(_WordGameState value, $Res Function(_WordGameState) _then) = __$WordGameStateCopyWithImpl;
@override @useResult
$Res call({
 CommonGamePhase phase, WordGameSettings? settings, WordGameSession? session, AnswerResult? lastResult, int epoch
});


@override $WordGameSettingsCopyWith<$Res>? get settings;@override $WordGameSessionCopyWith<$Res>? get session;@override $AnswerResultCopyWith<$Res>? get lastResult;

}
/// @nodoc
class __$WordGameStateCopyWithImpl<$Res>
    implements _$WordGameStateCopyWith<$Res> {
  __$WordGameStateCopyWithImpl(this._self, this._then);

  final _WordGameState _self;
  final $Res Function(_WordGameState) _then;

/// Create a copy of WordGameState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? lastResult = freezed,Object? epoch = null,}) {
  return _then(_WordGameState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as WordGameSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as WordGameSession?,lastResult: freezed == lastResult ? _self.lastResult : lastResult // ignore: cast_nullable_to_non_nullable
as AnswerResult?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of WordGameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordGameSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $WordGameSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of WordGameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordGameSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $WordGameSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of WordGameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnswerResultCopyWith<$Res>? get lastResult {
    if (_self.lastResult == null) {
    return null;
  }

  return $AnswerResultCopyWith<$Res>(_self.lastResult!, (value) {
    return _then(_self.copyWith(lastResult: value));
  });
}
}

/// @nodoc
mixin _$AnswerResult {

 int get selectedIndex; int get correctIndex; bool get isCorrect; bool get isPerfect;
/// Create a copy of AnswerResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnswerResultCopyWith<AnswerResult> get copyWith => _$AnswerResultCopyWithImpl<AnswerResult>(this as AnswerResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnswerResult&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.correctIndex, correctIndex) || other.correctIndex == correctIndex)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.isPerfect, isPerfect) || other.isPerfect == isPerfect));
}


@override
int get hashCode => Object.hash(runtimeType,selectedIndex,correctIndex,isCorrect,isPerfect);

@override
String toString() {
  return 'AnswerResult(selectedIndex: $selectedIndex, correctIndex: $correctIndex, isCorrect: $isCorrect, isPerfect: $isPerfect)';
}


}

/// @nodoc
abstract mixin class $AnswerResultCopyWith<$Res>  {
  factory $AnswerResultCopyWith(AnswerResult value, $Res Function(AnswerResult) _then) = _$AnswerResultCopyWithImpl;
@useResult
$Res call({
 int selectedIndex, int correctIndex, bool isCorrect, bool isPerfect
});




}
/// @nodoc
class _$AnswerResultCopyWithImpl<$Res>
    implements $AnswerResultCopyWith<$Res> {
  _$AnswerResultCopyWithImpl(this._self, this._then);

  final AnswerResult _self;
  final $Res Function(AnswerResult) _then;

/// Create a copy of AnswerResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedIndex = null,Object? correctIndex = null,Object? isCorrect = null,Object? isPerfect = null,}) {
  return _then(_self.copyWith(
selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,correctIndex: null == correctIndex ? _self.correctIndex : correctIndex // ignore: cast_nullable_to_non_nullable
as int,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,isPerfect: null == isPerfect ? _self.isPerfect : isPerfect // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AnswerResult].
extension AnswerResultPatterns on AnswerResult {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnswerResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnswerResult() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnswerResult value)  $default,){
final _that = this;
switch (_that) {
case _AnswerResult():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnswerResult value)?  $default,){
final _that = this;
switch (_that) {
case _AnswerResult() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int selectedIndex,  int correctIndex,  bool isCorrect,  bool isPerfect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnswerResult() when $default != null:
return $default(_that.selectedIndex,_that.correctIndex,_that.isCorrect,_that.isPerfect);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int selectedIndex,  int correctIndex,  bool isCorrect,  bool isPerfect)  $default,) {final _that = this;
switch (_that) {
case _AnswerResult():
return $default(_that.selectedIndex,_that.correctIndex,_that.isCorrect,_that.isPerfect);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int selectedIndex,  int correctIndex,  bool isCorrect,  bool isPerfect)?  $default,) {final _that = this;
switch (_that) {
case _AnswerResult() when $default != null:
return $default(_that.selectedIndex,_that.correctIndex,_that.isCorrect,_that.isPerfect);case _:
  return null;

}
}

}

/// @nodoc


class _AnswerResult implements AnswerResult {
  const _AnswerResult({required this.selectedIndex, required this.correctIndex, required this.isCorrect, required this.isPerfect});
  

@override final  int selectedIndex;
@override final  int correctIndex;
@override final  bool isCorrect;
@override final  bool isPerfect;

/// Create a copy of AnswerResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnswerResultCopyWith<_AnswerResult> get copyWith => __$AnswerResultCopyWithImpl<_AnswerResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnswerResult&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.correctIndex, correctIndex) || other.correctIndex == correctIndex)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.isPerfect, isPerfect) || other.isPerfect == isPerfect));
}


@override
int get hashCode => Object.hash(runtimeType,selectedIndex,correctIndex,isCorrect,isPerfect);

@override
String toString() {
  return 'AnswerResult(selectedIndex: $selectedIndex, correctIndex: $correctIndex, isCorrect: $isCorrect, isPerfect: $isPerfect)';
}


}

/// @nodoc
abstract mixin class _$AnswerResultCopyWith<$Res> implements $AnswerResultCopyWith<$Res> {
  factory _$AnswerResultCopyWith(_AnswerResult value, $Res Function(_AnswerResult) _then) = __$AnswerResultCopyWithImpl;
@override @useResult
$Res call({
 int selectedIndex, int correctIndex, bool isCorrect, bool isPerfect
});




}
/// @nodoc
class __$AnswerResultCopyWithImpl<$Res>
    implements _$AnswerResultCopyWith<$Res> {
  __$AnswerResultCopyWithImpl(this._self, this._then);

  final _AnswerResult _self;
  final $Res Function(_AnswerResult) _then;

/// Create a copy of AnswerResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedIndex = null,Object? correctIndex = null,Object? isCorrect = null,Object? isPerfect = null,}) {
  return _then(_AnswerResult(
selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,correctIndex: null == correctIndex ? _self.correctIndex : correctIndex // ignore: cast_nullable_to_non_nullable
as int,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,isPerfect: null == isPerfect ? _self.isPerfect : isPerfect // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
