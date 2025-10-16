// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'instant_memory_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MemoryItem {

 String get word;// 単語
 int get id;// 一意なID
 double get x;// X座標（0.0-1.0の相対位置）
 double get y;
/// Create a copy of MemoryItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemoryItemCopyWith<MemoryItem> get copyWith => _$MemoryItemCopyWithImpl<MemoryItem>(this as MemoryItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemoryItem&&(identical(other.word, word) || other.word == word)&&(identical(other.id, id) || other.id == id)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}


@override
int get hashCode => Object.hash(runtimeType,word,id,x,y);

@override
String toString() {
  return 'MemoryItem(word: $word, id: $id, x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class $MemoryItemCopyWith<$Res>  {
  factory $MemoryItemCopyWith(MemoryItem value, $Res Function(MemoryItem) _then) = _$MemoryItemCopyWithImpl;
@useResult
$Res call({
 String word, int id, double x, double y
});




}
/// @nodoc
class _$MemoryItemCopyWithImpl<$Res>
    implements $MemoryItemCopyWith<$Res> {
  _$MemoryItemCopyWithImpl(this._self, this._then);

  final MemoryItem _self;
  final $Res Function(MemoryItem) _then;

/// Create a copy of MemoryItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? word = null,Object? id = null,Object? x = null,Object? y = null,}) {
  return _then(_self.copyWith(
word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MemoryItem].
extension MemoryItemPatterns on MemoryItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemoryItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemoryItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemoryItem value)  $default,){
final _that = this;
switch (_that) {
case _MemoryItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemoryItem value)?  $default,){
final _that = this;
switch (_that) {
case _MemoryItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String word,  int id,  double x,  double y)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemoryItem() when $default != null:
return $default(_that.word,_that.id,_that.x,_that.y);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String word,  int id,  double x,  double y)  $default,) {final _that = this;
switch (_that) {
case _MemoryItem():
return $default(_that.word,_that.id,_that.x,_that.y);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String word,  int id,  double x,  double y)?  $default,) {final _that = this;
switch (_that) {
case _MemoryItem() when $default != null:
return $default(_that.word,_that.id,_that.x,_that.y);case _:
  return null;

}
}

}

/// @nodoc


class _MemoryItem extends MemoryItem {
  const _MemoryItem({required this.word, required this.id, required this.x, required this.y}): super._();
  

@override final  String word;
// 単語
@override final  int id;
// 一意なID
@override final  double x;
// X座標（0.0-1.0の相対位置）
@override final  double y;

/// Create a copy of MemoryItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemoryItemCopyWith<_MemoryItem> get copyWith => __$MemoryItemCopyWithImpl<_MemoryItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemoryItem&&(identical(other.word, word) || other.word == word)&&(identical(other.id, id) || other.id == id)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}


@override
int get hashCode => Object.hash(runtimeType,word,id,x,y);

@override
String toString() {
  return 'MemoryItem(word: $word, id: $id, x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class _$MemoryItemCopyWith<$Res> implements $MemoryItemCopyWith<$Res> {
  factory _$MemoryItemCopyWith(_MemoryItem value, $Res Function(_MemoryItem) _then) = __$MemoryItemCopyWithImpl;
@override @useResult
$Res call({
 String word, int id, double x, double y
});




}
/// @nodoc
class __$MemoryItemCopyWithImpl<$Res>
    implements _$MemoryItemCopyWith<$Res> {
  __$MemoryItemCopyWithImpl(this._self, this._then);

  final _MemoryItem _self;
  final $Res Function(_MemoryItem) _then;

/// Create a copy of MemoryItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? word = null,Object? id = null,Object? x = null,Object? y = null,}) {
  return _then(_MemoryItem(
word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$InstantMemorySettings {

 InstantMemoryDifficulty get difficulty; int get questionCount; int get memorySeconds;
/// Create a copy of InstantMemorySettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstantMemorySettingsCopyWith<InstantMemorySettings> get copyWith => _$InstantMemorySettingsCopyWithImpl<InstantMemorySettings>(this as InstantMemorySettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InstantMemorySettings&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.memorySeconds, memorySeconds) || other.memorySeconds == memorySeconds));
}


@override
int get hashCode => Object.hash(runtimeType,difficulty,questionCount,memorySeconds);

@override
String toString() {
  return 'InstantMemorySettings(difficulty: $difficulty, questionCount: $questionCount, memorySeconds: $memorySeconds)';
}


}

/// @nodoc
abstract mixin class $InstantMemorySettingsCopyWith<$Res>  {
  factory $InstantMemorySettingsCopyWith(InstantMemorySettings value, $Res Function(InstantMemorySettings) _then) = _$InstantMemorySettingsCopyWithImpl;
@useResult
$Res call({
 InstantMemoryDifficulty difficulty, int questionCount, int memorySeconds
});




}
/// @nodoc
class _$InstantMemorySettingsCopyWithImpl<$Res>
    implements $InstantMemorySettingsCopyWith<$Res> {
  _$InstantMemorySettingsCopyWithImpl(this._self, this._then);

  final InstantMemorySettings _self;
  final $Res Function(InstantMemorySettings) _then;

/// Create a copy of InstantMemorySettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? difficulty = null,Object? questionCount = null,Object? memorySeconds = null,}) {
  return _then(_self.copyWith(
difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as InstantMemoryDifficulty,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,memorySeconds: null == memorySeconds ? _self.memorySeconds : memorySeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [InstantMemorySettings].
extension InstantMemorySettingsPatterns on InstantMemorySettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InstantMemorySettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InstantMemorySettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InstantMemorySettings value)  $default,){
final _that = this;
switch (_that) {
case _InstantMemorySettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InstantMemorySettings value)?  $default,){
final _that = this;
switch (_that) {
case _InstantMemorySettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( InstantMemoryDifficulty difficulty,  int questionCount,  int memorySeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InstantMemorySettings() when $default != null:
return $default(_that.difficulty,_that.questionCount,_that.memorySeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( InstantMemoryDifficulty difficulty,  int questionCount,  int memorySeconds)  $default,) {final _that = this;
switch (_that) {
case _InstantMemorySettings():
return $default(_that.difficulty,_that.questionCount,_that.memorySeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( InstantMemoryDifficulty difficulty,  int questionCount,  int memorySeconds)?  $default,) {final _that = this;
switch (_that) {
case _InstantMemorySettings() when $default != null:
return $default(_that.difficulty,_that.questionCount,_that.memorySeconds);case _:
  return null;

}
}

}

/// @nodoc


class _InstantMemorySettings extends InstantMemorySettings {
  const _InstantMemorySettings({this.difficulty = InstantMemoryDifficulty.easy, this.questionCount = 3, this.memorySeconds = 8}): super._();
  

@override@JsonKey() final  InstantMemoryDifficulty difficulty;
@override@JsonKey() final  int questionCount;
@override@JsonKey() final  int memorySeconds;

/// Create a copy of InstantMemorySettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstantMemorySettingsCopyWith<_InstantMemorySettings> get copyWith => __$InstantMemorySettingsCopyWithImpl<_InstantMemorySettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InstantMemorySettings&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.memorySeconds, memorySeconds) || other.memorySeconds == memorySeconds));
}


@override
int get hashCode => Object.hash(runtimeType,difficulty,questionCount,memorySeconds);

@override
String toString() {
  return 'InstantMemorySettings(difficulty: $difficulty, questionCount: $questionCount, memorySeconds: $memorySeconds)';
}


}

/// @nodoc
abstract mixin class _$InstantMemorySettingsCopyWith<$Res> implements $InstantMemorySettingsCopyWith<$Res> {
  factory _$InstantMemorySettingsCopyWith(_InstantMemorySettings value, $Res Function(_InstantMemorySettings) _then) = __$InstantMemorySettingsCopyWithImpl;
@override @useResult
$Res call({
 InstantMemoryDifficulty difficulty, int questionCount, int memorySeconds
});




}
/// @nodoc
class __$InstantMemorySettingsCopyWithImpl<$Res>
    implements _$InstantMemorySettingsCopyWith<$Res> {
  __$InstantMemorySettingsCopyWithImpl(this._self, this._then);

  final _InstantMemorySettings _self;
  final $Res Function(_InstantMemorySettings) _then;

/// Create a copy of InstantMemorySettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? difficulty = null,Object? questionCount = null,Object? memorySeconds = null,}) {
  return _then(_InstantMemorySettings(
difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as InstantMemoryDifficulty,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,memorySeconds: null == memorySeconds ? _self.memorySeconds : memorySeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$InstantMemoryProblem {

 List<MemoryItem> get initialItems;// 最初の図形リスト
 List<MemoryItem> get changedItems;// 変化後の図形リスト
 ChangeType get changeType;// 変化の種類
 int get changedIndex;// 変化した位置（正解）
 String get displayWord;// 表示する単語
 String get memoryPhaseText; String get addedQuestionText; String get replacedQuestionText;
/// Create a copy of InstantMemoryProblem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstantMemoryProblemCopyWith<InstantMemoryProblem> get copyWith => _$InstantMemoryProblemCopyWithImpl<InstantMemoryProblem>(this as InstantMemoryProblem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InstantMemoryProblem&&const DeepCollectionEquality().equals(other.initialItems, initialItems)&&const DeepCollectionEquality().equals(other.changedItems, changedItems)&&(identical(other.changeType, changeType) || other.changeType == changeType)&&(identical(other.changedIndex, changedIndex) || other.changedIndex == changedIndex)&&(identical(other.displayWord, displayWord) || other.displayWord == displayWord)&&(identical(other.memoryPhaseText, memoryPhaseText) || other.memoryPhaseText == memoryPhaseText)&&(identical(other.addedQuestionText, addedQuestionText) || other.addedQuestionText == addedQuestionText)&&(identical(other.replacedQuestionText, replacedQuestionText) || other.replacedQuestionText == replacedQuestionText));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(initialItems),const DeepCollectionEquality().hash(changedItems),changeType,changedIndex,displayWord,memoryPhaseText,addedQuestionText,replacedQuestionText);

@override
String toString() {
  return 'InstantMemoryProblem(initialItems: $initialItems, changedItems: $changedItems, changeType: $changeType, changedIndex: $changedIndex, displayWord: $displayWord, memoryPhaseText: $memoryPhaseText, addedQuestionText: $addedQuestionText, replacedQuestionText: $replacedQuestionText)';
}


}

/// @nodoc
abstract mixin class $InstantMemoryProblemCopyWith<$Res>  {
  factory $InstantMemoryProblemCopyWith(InstantMemoryProblem value, $Res Function(InstantMemoryProblem) _then) = _$InstantMemoryProblemCopyWithImpl;
@useResult
$Res call({
 List<MemoryItem> initialItems, List<MemoryItem> changedItems, ChangeType changeType, int changedIndex, String displayWord, String memoryPhaseText, String addedQuestionText, String replacedQuestionText
});




}
/// @nodoc
class _$InstantMemoryProblemCopyWithImpl<$Res>
    implements $InstantMemoryProblemCopyWith<$Res> {
  _$InstantMemoryProblemCopyWithImpl(this._self, this._then);

  final InstantMemoryProblem _self;
  final $Res Function(InstantMemoryProblem) _then;

/// Create a copy of InstantMemoryProblem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? initialItems = null,Object? changedItems = null,Object? changeType = null,Object? changedIndex = null,Object? displayWord = null,Object? memoryPhaseText = null,Object? addedQuestionText = null,Object? replacedQuestionText = null,}) {
  return _then(_self.copyWith(
initialItems: null == initialItems ? _self.initialItems : initialItems // ignore: cast_nullable_to_non_nullable
as List<MemoryItem>,changedItems: null == changedItems ? _self.changedItems : changedItems // ignore: cast_nullable_to_non_nullable
as List<MemoryItem>,changeType: null == changeType ? _self.changeType : changeType // ignore: cast_nullable_to_non_nullable
as ChangeType,changedIndex: null == changedIndex ? _self.changedIndex : changedIndex // ignore: cast_nullable_to_non_nullable
as int,displayWord: null == displayWord ? _self.displayWord : displayWord // ignore: cast_nullable_to_non_nullable
as String,memoryPhaseText: null == memoryPhaseText ? _self.memoryPhaseText : memoryPhaseText // ignore: cast_nullable_to_non_nullable
as String,addedQuestionText: null == addedQuestionText ? _self.addedQuestionText : addedQuestionText // ignore: cast_nullable_to_non_nullable
as String,replacedQuestionText: null == replacedQuestionText ? _self.replacedQuestionText : replacedQuestionText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [InstantMemoryProblem].
extension InstantMemoryProblemPatterns on InstantMemoryProblem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InstantMemoryProblem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InstantMemoryProblem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InstantMemoryProblem value)  $default,){
final _that = this;
switch (_that) {
case _InstantMemoryProblem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InstantMemoryProblem value)?  $default,){
final _that = this;
switch (_that) {
case _InstantMemoryProblem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MemoryItem> initialItems,  List<MemoryItem> changedItems,  ChangeType changeType,  int changedIndex,  String displayWord,  String memoryPhaseText,  String addedQuestionText,  String replacedQuestionText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InstantMemoryProblem() when $default != null:
return $default(_that.initialItems,_that.changedItems,_that.changeType,_that.changedIndex,_that.displayWord,_that.memoryPhaseText,_that.addedQuestionText,_that.replacedQuestionText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MemoryItem> initialItems,  List<MemoryItem> changedItems,  ChangeType changeType,  int changedIndex,  String displayWord,  String memoryPhaseText,  String addedQuestionText,  String replacedQuestionText)  $default,) {final _that = this;
switch (_that) {
case _InstantMemoryProblem():
return $default(_that.initialItems,_that.changedItems,_that.changeType,_that.changedIndex,_that.displayWord,_that.memoryPhaseText,_that.addedQuestionText,_that.replacedQuestionText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MemoryItem> initialItems,  List<MemoryItem> changedItems,  ChangeType changeType,  int changedIndex,  String displayWord,  String memoryPhaseText,  String addedQuestionText,  String replacedQuestionText)?  $default,) {final _that = this;
switch (_that) {
case _InstantMemoryProblem() when $default != null:
return $default(_that.initialItems,_that.changedItems,_that.changeType,_that.changedIndex,_that.displayWord,_that.memoryPhaseText,_that.addedQuestionText,_that.replacedQuestionText);case _:
  return null;

}
}

}

/// @nodoc


class _InstantMemoryProblem extends InstantMemoryProblem {
  const _InstantMemoryProblem({required final  List<MemoryItem> initialItems, required final  List<MemoryItem> changedItems, required this.changeType, required this.changedIndex, required this.displayWord, this.memoryPhaseText = 'どのえがあるか\n８びょうでおぼえてね', this.addedQuestionText = 'どのえがふえたかな', this.replacedQuestionText = 'どのえがおきかわったかな'}): _initialItems = initialItems,_changedItems = changedItems,super._();
  

 final  List<MemoryItem> _initialItems;
@override List<MemoryItem> get initialItems {
  if (_initialItems is EqualUnmodifiableListView) return _initialItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_initialItems);
}

// 最初の図形リスト
 final  List<MemoryItem> _changedItems;
// 最初の図形リスト
@override List<MemoryItem> get changedItems {
  if (_changedItems is EqualUnmodifiableListView) return _changedItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_changedItems);
}

// 変化後の図形リスト
@override final  ChangeType changeType;
// 変化の種類
@override final  int changedIndex;
// 変化した位置（正解）
@override final  String displayWord;
// 表示する単語
@override@JsonKey() final  String memoryPhaseText;
@override@JsonKey() final  String addedQuestionText;
@override@JsonKey() final  String replacedQuestionText;

/// Create a copy of InstantMemoryProblem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstantMemoryProblemCopyWith<_InstantMemoryProblem> get copyWith => __$InstantMemoryProblemCopyWithImpl<_InstantMemoryProblem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InstantMemoryProblem&&const DeepCollectionEquality().equals(other._initialItems, _initialItems)&&const DeepCollectionEquality().equals(other._changedItems, _changedItems)&&(identical(other.changeType, changeType) || other.changeType == changeType)&&(identical(other.changedIndex, changedIndex) || other.changedIndex == changedIndex)&&(identical(other.displayWord, displayWord) || other.displayWord == displayWord)&&(identical(other.memoryPhaseText, memoryPhaseText) || other.memoryPhaseText == memoryPhaseText)&&(identical(other.addedQuestionText, addedQuestionText) || other.addedQuestionText == addedQuestionText)&&(identical(other.replacedQuestionText, replacedQuestionText) || other.replacedQuestionText == replacedQuestionText));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_initialItems),const DeepCollectionEquality().hash(_changedItems),changeType,changedIndex,displayWord,memoryPhaseText,addedQuestionText,replacedQuestionText);

@override
String toString() {
  return 'InstantMemoryProblem(initialItems: $initialItems, changedItems: $changedItems, changeType: $changeType, changedIndex: $changedIndex, displayWord: $displayWord, memoryPhaseText: $memoryPhaseText, addedQuestionText: $addedQuestionText, replacedQuestionText: $replacedQuestionText)';
}


}

/// @nodoc
abstract mixin class _$InstantMemoryProblemCopyWith<$Res> implements $InstantMemoryProblemCopyWith<$Res> {
  factory _$InstantMemoryProblemCopyWith(_InstantMemoryProblem value, $Res Function(_InstantMemoryProblem) _then) = __$InstantMemoryProblemCopyWithImpl;
@override @useResult
$Res call({
 List<MemoryItem> initialItems, List<MemoryItem> changedItems, ChangeType changeType, int changedIndex, String displayWord, String memoryPhaseText, String addedQuestionText, String replacedQuestionText
});




}
/// @nodoc
class __$InstantMemoryProblemCopyWithImpl<$Res>
    implements _$InstantMemoryProblemCopyWith<$Res> {
  __$InstantMemoryProblemCopyWithImpl(this._self, this._then);

  final _InstantMemoryProblem _self;
  final $Res Function(_InstantMemoryProblem) _then;

/// Create a copy of InstantMemoryProblem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? initialItems = null,Object? changedItems = null,Object? changeType = null,Object? changedIndex = null,Object? displayWord = null,Object? memoryPhaseText = null,Object? addedQuestionText = null,Object? replacedQuestionText = null,}) {
  return _then(_InstantMemoryProblem(
initialItems: null == initialItems ? _self._initialItems : initialItems // ignore: cast_nullable_to_non_nullable
as List<MemoryItem>,changedItems: null == changedItems ? _self._changedItems : changedItems // ignore: cast_nullable_to_non_nullable
as List<MemoryItem>,changeType: null == changeType ? _self.changeType : changeType // ignore: cast_nullable_to_non_nullable
as ChangeType,changedIndex: null == changedIndex ? _self.changedIndex : changedIndex // ignore: cast_nullable_to_non_nullable
as int,displayWord: null == displayWord ? _self.displayWord : displayWord // ignore: cast_nullable_to_non_nullable
as String,memoryPhaseText: null == memoryPhaseText ? _self.memoryPhaseText : memoryPhaseText // ignore: cast_nullable_to_non_nullable
as String,addedQuestionText: null == addedQuestionText ? _self.addedQuestionText : addedQuestionText // ignore: cast_nullable_to_non_nullable
as String,replacedQuestionText: null == replacedQuestionText ? _self.replacedQuestionText : replacedQuestionText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$InstantMemorySession {

 int get index; int get total; List<bool?> get results; InstantMemoryProblem? get currentProblem; int get wrongAttempts; bool get showingAnswer;
/// Create a copy of InstantMemorySession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstantMemorySessionCopyWith<InstantMemorySession> get copyWith => _$InstantMemorySessionCopyWithImpl<InstantMemorySession>(this as InstantMemorySession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InstantMemorySession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&(identical(other.wrongAttempts, wrongAttempts) || other.wrongAttempts == wrongAttempts)&&(identical(other.showingAnswer, showingAnswer) || other.showingAnswer == showingAnswer));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(results),currentProblem,wrongAttempts,showingAnswer);

@override
String toString() {
  return 'InstantMemorySession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, wrongAttempts: $wrongAttempts, showingAnswer: $showingAnswer)';
}


}

/// @nodoc
abstract mixin class $InstantMemorySessionCopyWith<$Res>  {
  factory $InstantMemorySessionCopyWith(InstantMemorySession value, $Res Function(InstantMemorySession) _then) = _$InstantMemorySessionCopyWithImpl;
@useResult
$Res call({
 int index, int total, List<bool?> results, InstantMemoryProblem? currentProblem, int wrongAttempts, bool showingAnswer
});


$InstantMemoryProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class _$InstantMemorySessionCopyWithImpl<$Res>
    implements $InstantMemorySessionCopyWith<$Res> {
  _$InstantMemorySessionCopyWithImpl(this._self, this._then);

  final InstantMemorySession _self;
  final $Res Function(InstantMemorySession) _then;

/// Create a copy of InstantMemorySession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? wrongAttempts = null,Object? showingAnswer = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as InstantMemoryProblem?,wrongAttempts: null == wrongAttempts ? _self.wrongAttempts : wrongAttempts // ignore: cast_nullable_to_non_nullable
as int,showingAnswer: null == showingAnswer ? _self.showingAnswer : showingAnswer // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of InstantMemorySession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InstantMemoryProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $InstantMemoryProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}


/// Adds pattern-matching-related methods to [InstantMemorySession].
extension InstantMemorySessionPatterns on InstantMemorySession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InstantMemorySession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InstantMemorySession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InstantMemorySession value)  $default,){
final _that = this;
switch (_that) {
case _InstantMemorySession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InstantMemorySession value)?  $default,){
final _that = this;
switch (_that) {
case _InstantMemorySession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  InstantMemoryProblem? currentProblem,  int wrongAttempts,  bool showingAnswer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InstantMemorySession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAttempts,_that.showingAnswer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  InstantMemoryProblem? currentProblem,  int wrongAttempts,  bool showingAnswer)  $default,) {final _that = this;
switch (_that) {
case _InstantMemorySession():
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAttempts,_that.showingAnswer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  int total,  List<bool?> results,  InstantMemoryProblem? currentProblem,  int wrongAttempts,  bool showingAnswer)?  $default,) {final _that = this;
switch (_that) {
case _InstantMemorySession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAttempts,_that.showingAnswer);case _:
  return null;

}
}

}

/// @nodoc


class _InstantMemorySession extends InstantMemorySession {
  const _InstantMemorySession({required this.index, required this.total, required final  List<bool?> results, this.currentProblem, this.wrongAttempts = 0, this.showingAnswer = false}): _results = results,super._();
  

@override final  int index;
@override final  int total;
 final  List<bool?> _results;
@override List<bool?> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override final  InstantMemoryProblem? currentProblem;
@override@JsonKey() final  int wrongAttempts;
@override@JsonKey() final  bool showingAnswer;

/// Create a copy of InstantMemorySession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstantMemorySessionCopyWith<_InstantMemorySession> get copyWith => __$InstantMemorySessionCopyWithImpl<_InstantMemorySession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InstantMemorySession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&(identical(other.wrongAttempts, wrongAttempts) || other.wrongAttempts == wrongAttempts)&&(identical(other.showingAnswer, showingAnswer) || other.showingAnswer == showingAnswer));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(_results),currentProblem,wrongAttempts,showingAnswer);

@override
String toString() {
  return 'InstantMemorySession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, wrongAttempts: $wrongAttempts, showingAnswer: $showingAnswer)';
}


}

/// @nodoc
abstract mixin class _$InstantMemorySessionCopyWith<$Res> implements $InstantMemorySessionCopyWith<$Res> {
  factory _$InstantMemorySessionCopyWith(_InstantMemorySession value, $Res Function(_InstantMemorySession) _then) = __$InstantMemorySessionCopyWithImpl;
@override @useResult
$Res call({
 int index, int total, List<bool?> results, InstantMemoryProblem? currentProblem, int wrongAttempts, bool showingAnswer
});


@override $InstantMemoryProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class __$InstantMemorySessionCopyWithImpl<$Res>
    implements _$InstantMemorySessionCopyWith<$Res> {
  __$InstantMemorySessionCopyWithImpl(this._self, this._then);

  final _InstantMemorySession _self;
  final $Res Function(_InstantMemorySession) _then;

/// Create a copy of InstantMemorySession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? wrongAttempts = null,Object? showingAnswer = null,}) {
  return _then(_InstantMemorySession(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as InstantMemoryProblem?,wrongAttempts: null == wrongAttempts ? _self.wrongAttempts : wrongAttempts // ignore: cast_nullable_to_non_nullable
as int,showingAnswer: null == showingAnswer ? _self.showingAnswer : showingAnswer // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of InstantMemorySession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InstantMemoryProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $InstantMemoryProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}

/// @nodoc
mixin _$InstantMemoryState {

 CommonGamePhase get phase; InstantMemorySettings? get settings; InstantMemorySession? get session; int get epoch;
/// Create a copy of InstantMemoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstantMemoryStateCopyWith<InstantMemoryState> get copyWith => _$InstantMemoryStateCopyWithImpl<InstantMemoryState>(this as InstantMemoryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InstantMemoryState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,epoch);

@override
String toString() {
  return 'InstantMemoryState(phase: $phase, settings: $settings, session: $session, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class $InstantMemoryStateCopyWith<$Res>  {
  factory $InstantMemoryStateCopyWith(InstantMemoryState value, $Res Function(InstantMemoryState) _then) = _$InstantMemoryStateCopyWithImpl;
@useResult
$Res call({
 CommonGamePhase phase, InstantMemorySettings? settings, InstantMemorySession? session, int epoch
});


$InstantMemorySettingsCopyWith<$Res>? get settings;$InstantMemorySessionCopyWith<$Res>? get session;

}
/// @nodoc
class _$InstantMemoryStateCopyWithImpl<$Res>
    implements $InstantMemoryStateCopyWith<$Res> {
  _$InstantMemoryStateCopyWithImpl(this._self, this._then);

  final InstantMemoryState _self;
  final $Res Function(InstantMemoryState) _then;

/// Create a copy of InstantMemoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? epoch = null,}) {
  return _then(_self.copyWith(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as InstantMemorySettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as InstantMemorySession?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of InstantMemoryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InstantMemorySettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $InstantMemorySettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of InstantMemoryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InstantMemorySessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $InstantMemorySessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}


/// Adds pattern-matching-related methods to [InstantMemoryState].
extension InstantMemoryStatePatterns on InstantMemoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InstantMemoryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InstantMemoryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InstantMemoryState value)  $default,){
final _that = this;
switch (_that) {
case _InstantMemoryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InstantMemoryState value)?  $default,){
final _that = this;
switch (_that) {
case _InstantMemoryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CommonGamePhase phase,  InstantMemorySettings? settings,  InstantMemorySession? session,  int epoch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InstantMemoryState() when $default != null:
return $default(_that.phase,_that.settings,_that.session,_that.epoch);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CommonGamePhase phase,  InstantMemorySettings? settings,  InstantMemorySession? session,  int epoch)  $default,) {final _that = this;
switch (_that) {
case _InstantMemoryState():
return $default(_that.phase,_that.settings,_that.session,_that.epoch);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CommonGamePhase phase,  InstantMemorySettings? settings,  InstantMemorySession? session,  int epoch)?  $default,) {final _that = this;
switch (_that) {
case _InstantMemoryState() when $default != null:
return $default(_that.phase,_that.settings,_that.session,_that.epoch);case _:
  return null;

}
}

}

/// @nodoc


class _InstantMemoryState extends InstantMemoryState {
  const _InstantMemoryState({this.phase = CommonGamePhase.ready, this.settings, this.session, this.epoch = 0}): super._();
  

@override@JsonKey() final  CommonGamePhase phase;
@override final  InstantMemorySettings? settings;
@override final  InstantMemorySession? session;
@override@JsonKey() final  int epoch;

/// Create a copy of InstantMemoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstantMemoryStateCopyWith<_InstantMemoryState> get copyWith => __$InstantMemoryStateCopyWithImpl<_InstantMemoryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InstantMemoryState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,epoch);

@override
String toString() {
  return 'InstantMemoryState(phase: $phase, settings: $settings, session: $session, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class _$InstantMemoryStateCopyWith<$Res> implements $InstantMemoryStateCopyWith<$Res> {
  factory _$InstantMemoryStateCopyWith(_InstantMemoryState value, $Res Function(_InstantMemoryState) _then) = __$InstantMemoryStateCopyWithImpl;
@override @useResult
$Res call({
 CommonGamePhase phase, InstantMemorySettings? settings, InstantMemorySession? session, int epoch
});


@override $InstantMemorySettingsCopyWith<$Res>? get settings;@override $InstantMemorySessionCopyWith<$Res>? get session;

}
/// @nodoc
class __$InstantMemoryStateCopyWithImpl<$Res>
    implements _$InstantMemoryStateCopyWith<$Res> {
  __$InstantMemoryStateCopyWithImpl(this._self, this._then);

  final _InstantMemoryState _self;
  final $Res Function(_InstantMemoryState) _then;

/// Create a copy of InstantMemoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? epoch = null,}) {
  return _then(_InstantMemoryState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as InstantMemorySettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as InstantMemorySession?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of InstantMemoryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InstantMemorySettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $InstantMemorySettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of InstantMemoryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InstantMemorySessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $InstantMemorySessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

// dart format on
