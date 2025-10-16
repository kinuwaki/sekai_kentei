// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word_trace_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CharPosition {

 int get x; int get y;
/// Create a copy of CharPosition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CharPositionCopyWith<CharPosition> get copyWith => _$CharPositionCopyWithImpl<CharPosition>(this as CharPosition, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharPosition&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}


@override
int get hashCode => Object.hash(runtimeType,x,y);



}

/// @nodoc
abstract mixin class $CharPositionCopyWith<$Res>  {
  factory $CharPositionCopyWith(CharPosition value, $Res Function(CharPosition) _then) = _$CharPositionCopyWithImpl;
@useResult
$Res call({
 int x, int y
});




}
/// @nodoc
class _$CharPositionCopyWithImpl<$Res>
    implements $CharPositionCopyWith<$Res> {
  _$CharPositionCopyWithImpl(this._self, this._then);

  final CharPosition _self;
  final $Res Function(CharPosition) _then;

/// Create a copy of CharPosition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? x = null,Object? y = null,}) {
  return _then(_self.copyWith(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as int,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CharPosition].
extension CharPositionPatterns on CharPosition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CharPosition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CharPosition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CharPosition value)  $default,){
final _that = this;
switch (_that) {
case _CharPosition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CharPosition value)?  $default,){
final _that = this;
switch (_that) {
case _CharPosition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int x,  int y)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CharPosition() when $default != null:
return $default(_that.x,_that.y);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int x,  int y)  $default,) {final _that = this;
switch (_that) {
case _CharPosition():
return $default(_that.x,_that.y);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int x,  int y)?  $default,) {final _that = this;
switch (_that) {
case _CharPosition() when $default != null:
return $default(_that.x,_that.y);case _:
  return null;

}
}

}

/// @nodoc


class _CharPosition extends CharPosition {
  const _CharPosition({required this.x, required this.y}): super._();
  

@override final  int x;
@override final  int y;

/// Create a copy of CharPosition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CharPositionCopyWith<_CharPosition> get copyWith => __$CharPositionCopyWithImpl<_CharPosition>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CharPosition&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}


@override
int get hashCode => Object.hash(runtimeType,x,y);



}

/// @nodoc
abstract mixin class _$CharPositionCopyWith<$Res> implements $CharPositionCopyWith<$Res> {
  factory _$CharPositionCopyWith(_CharPosition value, $Res Function(_CharPosition) _then) = __$CharPositionCopyWithImpl;
@override @useResult
$Res call({
 int x, int y
});




}
/// @nodoc
class __$CharPositionCopyWithImpl<$Res>
    implements _$CharPositionCopyWith<$Res> {
  __$CharPositionCopyWithImpl(this._self, this._then);

  final _CharPosition _self;
  final $Res Function(_CharPosition) _then;

/// Create a copy of CharPosition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? x = null,Object? y = null,}) {
  return _then(_CharPosition(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as int,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$WordTraceProblem {

 String get targetWord; List<List<String>> get grid;// 6x4のグリッド
 List<CharPosition> get correctPath; String get questionText;
/// Create a copy of WordTraceProblem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordTraceProblemCopyWith<WordTraceProblem> get copyWith => _$WordTraceProblemCopyWithImpl<WordTraceProblem>(this as WordTraceProblem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordTraceProblem&&(identical(other.targetWord, targetWord) || other.targetWord == targetWord)&&const DeepCollectionEquality().equals(other.grid, grid)&&const DeepCollectionEquality().equals(other.correctPath, correctPath)&&(identical(other.questionText, questionText) || other.questionText == questionText));
}


@override
int get hashCode => Object.hash(runtimeType,targetWord,const DeepCollectionEquality().hash(grid),const DeepCollectionEquality().hash(correctPath),questionText);

@override
String toString() {
  return 'WordTraceProblem(targetWord: $targetWord, grid: $grid, correctPath: $correctPath, questionText: $questionText)';
}


}

/// @nodoc
abstract mixin class $WordTraceProblemCopyWith<$Res>  {
  factory $WordTraceProblemCopyWith(WordTraceProblem value, $Res Function(WordTraceProblem) _then) = _$WordTraceProblemCopyWithImpl;
@useResult
$Res call({
 String targetWord, List<List<String>> grid, List<CharPosition> correctPath, String questionText
});




}
/// @nodoc
class _$WordTraceProblemCopyWithImpl<$Res>
    implements $WordTraceProblemCopyWith<$Res> {
  _$WordTraceProblemCopyWithImpl(this._self, this._then);

  final WordTraceProblem _self;
  final $Res Function(WordTraceProblem) _then;

/// Create a copy of WordTraceProblem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? targetWord = null,Object? grid = null,Object? correctPath = null,Object? questionText = null,}) {
  return _then(_self.copyWith(
targetWord: null == targetWord ? _self.targetWord : targetWord // ignore: cast_nullable_to_non_nullable
as String,grid: null == grid ? _self.grid : grid // ignore: cast_nullable_to_non_nullable
as List<List<String>>,correctPath: null == correctPath ? _self.correctPath : correctPath // ignore: cast_nullable_to_non_nullable
as List<CharPosition>,questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WordTraceProblem].
extension WordTraceProblemPatterns on WordTraceProblem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordTraceProblem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordTraceProblem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordTraceProblem value)  $default,){
final _that = this;
switch (_that) {
case _WordTraceProblem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordTraceProblem value)?  $default,){
final _that = this;
switch (_that) {
case _WordTraceProblem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String targetWord,  List<List<String>> grid,  List<CharPosition> correctPath,  String questionText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordTraceProblem() when $default != null:
return $default(_that.targetWord,_that.grid,_that.correctPath,_that.questionText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String targetWord,  List<List<String>> grid,  List<CharPosition> correctPath,  String questionText)  $default,) {final _that = this;
switch (_that) {
case _WordTraceProblem():
return $default(_that.targetWord,_that.grid,_that.correctPath,_that.questionText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String targetWord,  List<List<String>> grid,  List<CharPosition> correctPath,  String questionText)?  $default,) {final _that = this;
switch (_that) {
case _WordTraceProblem() when $default != null:
return $default(_that.targetWord,_that.grid,_that.correctPath,_that.questionText);case _:
  return null;

}
}

}

/// @nodoc


class _WordTraceProblem implements WordTraceProblem {
  const _WordTraceProblem({required this.targetWord, required final  List<List<String>> grid, required final  List<CharPosition> correctPath, this.questionText = 'ことばをみつけてね'}): _grid = grid,_correctPath = correctPath;
  

@override final  String targetWord;
 final  List<List<String>> _grid;
@override List<List<String>> get grid {
  if (_grid is EqualUnmodifiableListView) return _grid;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_grid);
}

// 6x4のグリッド
 final  List<CharPosition> _correctPath;
// 6x4のグリッド
@override List<CharPosition> get correctPath {
  if (_correctPath is EqualUnmodifiableListView) return _correctPath;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_correctPath);
}

@override@JsonKey() final  String questionText;

/// Create a copy of WordTraceProblem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordTraceProblemCopyWith<_WordTraceProblem> get copyWith => __$WordTraceProblemCopyWithImpl<_WordTraceProblem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordTraceProblem&&(identical(other.targetWord, targetWord) || other.targetWord == targetWord)&&const DeepCollectionEquality().equals(other._grid, _grid)&&const DeepCollectionEquality().equals(other._correctPath, _correctPath)&&(identical(other.questionText, questionText) || other.questionText == questionText));
}


@override
int get hashCode => Object.hash(runtimeType,targetWord,const DeepCollectionEquality().hash(_grid),const DeepCollectionEquality().hash(_correctPath),questionText);

@override
String toString() {
  return 'WordTraceProblem(targetWord: $targetWord, grid: $grid, correctPath: $correctPath, questionText: $questionText)';
}


}

/// @nodoc
abstract mixin class _$WordTraceProblemCopyWith<$Res> implements $WordTraceProblemCopyWith<$Res> {
  factory _$WordTraceProblemCopyWith(_WordTraceProblem value, $Res Function(_WordTraceProblem) _then) = __$WordTraceProblemCopyWithImpl;
@override @useResult
$Res call({
 String targetWord, List<List<String>> grid, List<CharPosition> correctPath, String questionText
});




}
/// @nodoc
class __$WordTraceProblemCopyWithImpl<$Res>
    implements _$WordTraceProblemCopyWith<$Res> {
  __$WordTraceProblemCopyWithImpl(this._self, this._then);

  final _WordTraceProblem _self;
  final $Res Function(_WordTraceProblem) _then;

/// Create a copy of WordTraceProblem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? targetWord = null,Object? grid = null,Object? correctPath = null,Object? questionText = null,}) {
  return _then(_WordTraceProblem(
targetWord: null == targetWord ? _self.targetWord : targetWord // ignore: cast_nullable_to_non_nullable
as String,grid: null == grid ? _self._grid : grid // ignore: cast_nullable_to_non_nullable
as List<List<String>>,correctPath: null == correctPath ? _self._correctPath : correctPath // ignore: cast_nullable_to_non_nullable
as List<CharPosition>,questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$WordTraceSettings {

 int get questionCount;
/// Create a copy of WordTraceSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordTraceSettingsCopyWith<WordTraceSettings> get copyWith => _$WordTraceSettingsCopyWithImpl<WordTraceSettings>(this as WordTraceSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordTraceSettings&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount));
}


@override
int get hashCode => Object.hash(runtimeType,questionCount);

@override
String toString() {
  return 'WordTraceSettings(questionCount: $questionCount)';
}


}

/// @nodoc
abstract mixin class $WordTraceSettingsCopyWith<$Res>  {
  factory $WordTraceSettingsCopyWith(WordTraceSettings value, $Res Function(WordTraceSettings) _then) = _$WordTraceSettingsCopyWithImpl;
@useResult
$Res call({
 int questionCount
});




}
/// @nodoc
class _$WordTraceSettingsCopyWithImpl<$Res>
    implements $WordTraceSettingsCopyWith<$Res> {
  _$WordTraceSettingsCopyWithImpl(this._self, this._then);

  final WordTraceSettings _self;
  final $Res Function(WordTraceSettings) _then;

/// Create a copy of WordTraceSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionCount = null,}) {
  return _then(_self.copyWith(
questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WordTraceSettings].
extension WordTraceSettingsPatterns on WordTraceSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordTraceSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordTraceSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordTraceSettings value)  $default,){
final _that = this;
switch (_that) {
case _WordTraceSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordTraceSettings value)?  $default,){
final _that = this;
switch (_that) {
case _WordTraceSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int questionCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordTraceSettings() when $default != null:
return $default(_that.questionCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int questionCount)  $default,) {final _that = this;
switch (_that) {
case _WordTraceSettings():
return $default(_that.questionCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int questionCount)?  $default,) {final _that = this;
switch (_that) {
case _WordTraceSettings() when $default != null:
return $default(_that.questionCount);case _:
  return null;

}
}

}

/// @nodoc


class _WordTraceSettings extends WordTraceSettings {
  const _WordTraceSettings({this.questionCount = 5}): super._();
  

@override@JsonKey() final  int questionCount;

/// Create a copy of WordTraceSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordTraceSettingsCopyWith<_WordTraceSettings> get copyWith => __$WordTraceSettingsCopyWithImpl<_WordTraceSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordTraceSettings&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount));
}


@override
int get hashCode => Object.hash(runtimeType,questionCount);

@override
String toString() {
  return 'WordTraceSettings(questionCount: $questionCount)';
}


}

/// @nodoc
abstract mixin class _$WordTraceSettingsCopyWith<$Res> implements $WordTraceSettingsCopyWith<$Res> {
  factory _$WordTraceSettingsCopyWith(_WordTraceSettings value, $Res Function(_WordTraceSettings) _then) = __$WordTraceSettingsCopyWithImpl;
@override @useResult
$Res call({
 int questionCount
});




}
/// @nodoc
class __$WordTraceSettingsCopyWithImpl<$Res>
    implements _$WordTraceSettingsCopyWith<$Res> {
  __$WordTraceSettingsCopyWithImpl(this._self, this._then);

  final _WordTraceSettings _self;
  final $Res Function(_WordTraceSettings) _then;

/// Create a copy of WordTraceSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionCount = null,}) {
  return _then(_WordTraceSettings(
questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$WordTraceSession {

 int get index; int get total; List<bool?> get results; WordTraceProblem? get currentProblem; List<CharPosition> get selectedPath; int get wrongAttempts;
/// Create a copy of WordTraceSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordTraceSessionCopyWith<WordTraceSession> get copyWith => _$WordTraceSessionCopyWithImpl<WordTraceSession>(this as WordTraceSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordTraceSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&const DeepCollectionEquality().equals(other.selectedPath, selectedPath)&&(identical(other.wrongAttempts, wrongAttempts) || other.wrongAttempts == wrongAttempts));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(results),currentProblem,const DeepCollectionEquality().hash(selectedPath),wrongAttempts);

@override
String toString() {
  return 'WordTraceSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, selectedPath: $selectedPath, wrongAttempts: $wrongAttempts)';
}


}

/// @nodoc
abstract mixin class $WordTraceSessionCopyWith<$Res>  {
  factory $WordTraceSessionCopyWith(WordTraceSession value, $Res Function(WordTraceSession) _then) = _$WordTraceSessionCopyWithImpl;
@useResult
$Res call({
 int index, int total, List<bool?> results, WordTraceProblem? currentProblem, List<CharPosition> selectedPath, int wrongAttempts
});


$WordTraceProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class _$WordTraceSessionCopyWithImpl<$Res>
    implements $WordTraceSessionCopyWith<$Res> {
  _$WordTraceSessionCopyWithImpl(this._self, this._then);

  final WordTraceSession _self;
  final $Res Function(WordTraceSession) _then;

/// Create a copy of WordTraceSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? selectedPath = null,Object? wrongAttempts = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as WordTraceProblem?,selectedPath: null == selectedPath ? _self.selectedPath : selectedPath // ignore: cast_nullable_to_non_nullable
as List<CharPosition>,wrongAttempts: null == wrongAttempts ? _self.wrongAttempts : wrongAttempts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of WordTraceSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordTraceProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $WordTraceProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}


/// Adds pattern-matching-related methods to [WordTraceSession].
extension WordTraceSessionPatterns on WordTraceSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordTraceSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordTraceSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordTraceSession value)  $default,){
final _that = this;
switch (_that) {
case _WordTraceSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordTraceSession value)?  $default,){
final _that = this;
switch (_that) {
case _WordTraceSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  WordTraceProblem? currentProblem,  List<CharPosition> selectedPath,  int wrongAttempts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordTraceSession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.selectedPath,_that.wrongAttempts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  WordTraceProblem? currentProblem,  List<CharPosition> selectedPath,  int wrongAttempts)  $default,) {final _that = this;
switch (_that) {
case _WordTraceSession():
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.selectedPath,_that.wrongAttempts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  int total,  List<bool?> results,  WordTraceProblem? currentProblem,  List<CharPosition> selectedPath,  int wrongAttempts)?  $default,) {final _that = this;
switch (_that) {
case _WordTraceSession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.selectedPath,_that.wrongAttempts);case _:
  return null;

}
}

}

/// @nodoc


class _WordTraceSession extends WordTraceSession {
  const _WordTraceSession({required this.index, required this.total, required final  List<bool?> results, this.currentProblem, final  List<CharPosition> selectedPath = const [], this.wrongAttempts = 0}): _results = results,_selectedPath = selectedPath,super._();
  

@override final  int index;
@override final  int total;
 final  List<bool?> _results;
@override List<bool?> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override final  WordTraceProblem? currentProblem;
 final  List<CharPosition> _selectedPath;
@override@JsonKey() List<CharPosition> get selectedPath {
  if (_selectedPath is EqualUnmodifiableListView) return _selectedPath;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedPath);
}

@override@JsonKey() final  int wrongAttempts;

/// Create a copy of WordTraceSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordTraceSessionCopyWith<_WordTraceSession> get copyWith => __$WordTraceSessionCopyWithImpl<_WordTraceSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordTraceSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&const DeepCollectionEquality().equals(other._selectedPath, _selectedPath)&&(identical(other.wrongAttempts, wrongAttempts) || other.wrongAttempts == wrongAttempts));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(_results),currentProblem,const DeepCollectionEquality().hash(_selectedPath),wrongAttempts);

@override
String toString() {
  return 'WordTraceSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, selectedPath: $selectedPath, wrongAttempts: $wrongAttempts)';
}


}

/// @nodoc
abstract mixin class _$WordTraceSessionCopyWith<$Res> implements $WordTraceSessionCopyWith<$Res> {
  factory _$WordTraceSessionCopyWith(_WordTraceSession value, $Res Function(_WordTraceSession) _then) = __$WordTraceSessionCopyWithImpl;
@override @useResult
$Res call({
 int index, int total, List<bool?> results, WordTraceProblem? currentProblem, List<CharPosition> selectedPath, int wrongAttempts
});


@override $WordTraceProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class __$WordTraceSessionCopyWithImpl<$Res>
    implements _$WordTraceSessionCopyWith<$Res> {
  __$WordTraceSessionCopyWithImpl(this._self, this._then);

  final _WordTraceSession _self;
  final $Res Function(_WordTraceSession) _then;

/// Create a copy of WordTraceSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? selectedPath = null,Object? wrongAttempts = null,}) {
  return _then(_WordTraceSession(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as WordTraceProblem?,selectedPath: null == selectedPath ? _self._selectedPath : selectedPath // ignore: cast_nullable_to_non_nullable
as List<CharPosition>,wrongAttempts: null == wrongAttempts ? _self.wrongAttempts : wrongAttempts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of WordTraceSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordTraceProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $WordTraceProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}

/// @nodoc
mixin _$WordTraceState {

 CommonGamePhase get phase; WordTraceSettings? get settings; WordTraceSession? get session; int get epoch;
/// Create a copy of WordTraceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordTraceStateCopyWith<WordTraceState> get copyWith => _$WordTraceStateCopyWithImpl<WordTraceState>(this as WordTraceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordTraceState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,epoch);

@override
String toString() {
  return 'WordTraceState(phase: $phase, settings: $settings, session: $session, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class $WordTraceStateCopyWith<$Res>  {
  factory $WordTraceStateCopyWith(WordTraceState value, $Res Function(WordTraceState) _then) = _$WordTraceStateCopyWithImpl;
@useResult
$Res call({
 CommonGamePhase phase, WordTraceSettings? settings, WordTraceSession? session, int epoch
});


$WordTraceSettingsCopyWith<$Res>? get settings;$WordTraceSessionCopyWith<$Res>? get session;

}
/// @nodoc
class _$WordTraceStateCopyWithImpl<$Res>
    implements $WordTraceStateCopyWith<$Res> {
  _$WordTraceStateCopyWithImpl(this._self, this._then);

  final WordTraceState _self;
  final $Res Function(WordTraceState) _then;

/// Create a copy of WordTraceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? epoch = null,}) {
  return _then(_self.copyWith(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as WordTraceSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as WordTraceSession?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of WordTraceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordTraceSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $WordTraceSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of WordTraceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordTraceSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $WordTraceSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}


/// Adds pattern-matching-related methods to [WordTraceState].
extension WordTraceStatePatterns on WordTraceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordTraceState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordTraceState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordTraceState value)  $default,){
final _that = this;
switch (_that) {
case _WordTraceState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordTraceState value)?  $default,){
final _that = this;
switch (_that) {
case _WordTraceState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CommonGamePhase phase,  WordTraceSettings? settings,  WordTraceSession? session,  int epoch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordTraceState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CommonGamePhase phase,  WordTraceSettings? settings,  WordTraceSession? session,  int epoch)  $default,) {final _that = this;
switch (_that) {
case _WordTraceState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CommonGamePhase phase,  WordTraceSettings? settings,  WordTraceSession? session,  int epoch)?  $default,) {final _that = this;
switch (_that) {
case _WordTraceState() when $default != null:
return $default(_that.phase,_that.settings,_that.session,_that.epoch);case _:
  return null;

}
}

}

/// @nodoc


class _WordTraceState extends WordTraceState {
  const _WordTraceState({this.phase = CommonGamePhase.ready, this.settings, this.session, this.epoch = 0}): super._();
  

@override@JsonKey() final  CommonGamePhase phase;
@override final  WordTraceSettings? settings;
@override final  WordTraceSession? session;
@override@JsonKey() final  int epoch;

/// Create a copy of WordTraceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordTraceStateCopyWith<_WordTraceState> get copyWith => __$WordTraceStateCopyWithImpl<_WordTraceState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordTraceState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,epoch);

@override
String toString() {
  return 'WordTraceState(phase: $phase, settings: $settings, session: $session, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class _$WordTraceStateCopyWith<$Res> implements $WordTraceStateCopyWith<$Res> {
  factory _$WordTraceStateCopyWith(_WordTraceState value, $Res Function(_WordTraceState) _then) = __$WordTraceStateCopyWithImpl;
@override @useResult
$Res call({
 CommonGamePhase phase, WordTraceSettings? settings, WordTraceSession? session, int epoch
});


@override $WordTraceSettingsCopyWith<$Res>? get settings;@override $WordTraceSessionCopyWith<$Res>? get session;

}
/// @nodoc
class __$WordTraceStateCopyWithImpl<$Res>
    implements _$WordTraceStateCopyWith<$Res> {
  __$WordTraceStateCopyWithImpl(this._self, this._then);

  final _WordTraceState _self;
  final $Res Function(_WordTraceState) _then;

/// Create a copy of WordTraceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? epoch = null,}) {
  return _then(_WordTraceState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as WordTraceSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as WordTraceSession?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of WordTraceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordTraceSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $WordTraceSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of WordTraceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordTraceSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $WordTraceSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

// dart format on
