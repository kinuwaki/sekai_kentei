// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dot_copy_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DotPosition {

 int get x; int get y;
/// Create a copy of DotPosition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DotPositionCopyWith<DotPosition> get copyWith => _$DotPositionCopyWithImpl<DotPosition>(this as DotPosition, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DotPosition&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}


@override
int get hashCode => Object.hash(runtimeType,x,y);



}

/// @nodoc
abstract mixin class $DotPositionCopyWith<$Res>  {
  factory $DotPositionCopyWith(DotPosition value, $Res Function(DotPosition) _then) = _$DotPositionCopyWithImpl;
@useResult
$Res call({
 int x, int y
});




}
/// @nodoc
class _$DotPositionCopyWithImpl<$Res>
    implements $DotPositionCopyWith<$Res> {
  _$DotPositionCopyWithImpl(this._self, this._then);

  final DotPosition _self;
  final $Res Function(DotPosition) _then;

/// Create a copy of DotPosition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? x = null,Object? y = null,}) {
  return _then(_self.copyWith(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as int,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DotPosition].
extension DotPositionPatterns on DotPosition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DotPosition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DotPosition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DotPosition value)  $default,){
final _that = this;
switch (_that) {
case _DotPosition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DotPosition value)?  $default,){
final _that = this;
switch (_that) {
case _DotPosition() when $default != null:
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
case _DotPosition() when $default != null:
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
case _DotPosition():
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
case _DotPosition() when $default != null:
return $default(_that.x,_that.y);case _:
  return null;

}
}

}

/// @nodoc


class _DotPosition extends DotPosition {
  const _DotPosition({required this.x, required this.y}): super._();
  

@override final  int x;
@override final  int y;

/// Create a copy of DotPosition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DotPositionCopyWith<_DotPosition> get copyWith => __$DotPositionCopyWithImpl<_DotPosition>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DotPosition&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}


@override
int get hashCode => Object.hash(runtimeType,x,y);



}

/// @nodoc
abstract mixin class _$DotPositionCopyWith<$Res> implements $DotPositionCopyWith<$Res> {
  factory _$DotPositionCopyWith(_DotPosition value, $Res Function(_DotPosition) _then) = __$DotPositionCopyWithImpl;
@override @useResult
$Res call({
 int x, int y
});




}
/// @nodoc
class __$DotPositionCopyWithImpl<$Res>
    implements _$DotPositionCopyWith<$Res> {
  __$DotPositionCopyWithImpl(this._self, this._then);

  final _DotPosition _self;
  final $Res Function(_DotPosition) _then;

/// Create a copy of DotPosition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? x = null,Object? y = null,}) {
  return _then(_DotPosition(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as int,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$LineSegment {

 DotPosition get start; DotPosition get end;
/// Create a copy of LineSegment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LineSegmentCopyWith<LineSegment> get copyWith => _$LineSegmentCopyWithImpl<LineSegment>(this as LineSegment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LineSegment&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}


@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'LineSegment(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class $LineSegmentCopyWith<$Res>  {
  factory $LineSegmentCopyWith(LineSegment value, $Res Function(LineSegment) _then) = _$LineSegmentCopyWithImpl;
@useResult
$Res call({
 DotPosition start, DotPosition end
});


$DotPositionCopyWith<$Res> get start;$DotPositionCopyWith<$Res> get end;

}
/// @nodoc
class _$LineSegmentCopyWithImpl<$Res>
    implements $LineSegmentCopyWith<$Res> {
  _$LineSegmentCopyWithImpl(this._self, this._then);

  final LineSegment _self;
  final $Res Function(LineSegment) _then;

/// Create a copy of LineSegment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = null,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DotPosition,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DotPosition,
  ));
}
/// Create a copy of LineSegment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DotPositionCopyWith<$Res> get start {
  
  return $DotPositionCopyWith<$Res>(_self.start, (value) {
    return _then(_self.copyWith(start: value));
  });
}/// Create a copy of LineSegment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DotPositionCopyWith<$Res> get end {
  
  return $DotPositionCopyWith<$Res>(_self.end, (value) {
    return _then(_self.copyWith(end: value));
  });
}
}


/// Adds pattern-matching-related methods to [LineSegment].
extension LineSegmentPatterns on LineSegment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LineSegment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LineSegment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LineSegment value)  $default,){
final _that = this;
switch (_that) {
case _LineSegment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LineSegment value)?  $default,){
final _that = this;
switch (_that) {
case _LineSegment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DotPosition start,  DotPosition end)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LineSegment() when $default != null:
return $default(_that.start,_that.end);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DotPosition start,  DotPosition end)  $default,) {final _that = this;
switch (_that) {
case _LineSegment():
return $default(_that.start,_that.end);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DotPosition start,  DotPosition end)?  $default,) {final _that = this;
switch (_that) {
case _LineSegment() when $default != null:
return $default(_that.start,_that.end);case _:
  return null;

}
}

}

/// @nodoc


class _LineSegment extends LineSegment {
  const _LineSegment({required this.start, required this.end}): super._();
  

@override final  DotPosition start;
@override final  DotPosition end;

/// Create a copy of LineSegment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LineSegmentCopyWith<_LineSegment> get copyWith => __$LineSegmentCopyWithImpl<_LineSegment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LineSegment&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}


@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'LineSegment(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class _$LineSegmentCopyWith<$Res> implements $LineSegmentCopyWith<$Res> {
  factory _$LineSegmentCopyWith(_LineSegment value, $Res Function(_LineSegment) _then) = __$LineSegmentCopyWithImpl;
@override @useResult
$Res call({
 DotPosition start, DotPosition end
});


@override $DotPositionCopyWith<$Res> get start;@override $DotPositionCopyWith<$Res> get end;

}
/// @nodoc
class __$LineSegmentCopyWithImpl<$Res>
    implements _$LineSegmentCopyWith<$Res> {
  __$LineSegmentCopyWithImpl(this._self, this._then);

  final _LineSegment _self;
  final $Res Function(_LineSegment) _then;

/// Create a copy of LineSegment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,}) {
  return _then(_LineSegment(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DotPosition,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DotPosition,
  ));
}

/// Create a copy of LineSegment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DotPositionCopyWith<$Res> get start {
  
  return $DotPositionCopyWith<$Res>(_self.start, (value) {
    return _then(_self.copyWith(start: value));
  });
}/// Create a copy of LineSegment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DotPositionCopyWith<$Res> get end {
  
  return $DotPositionCopyWith<$Res>(_self.end, (value) {
    return _then(_self.copyWith(end: value));
  });
}
}

/// @nodoc
mixin _$DotCopySettings {

 int get gridSize; int get questionCount; DotCopyDifficulty get difficulty;
/// Create a copy of DotCopySettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DotCopySettingsCopyWith<DotCopySettings> get copyWith => _$DotCopySettingsCopyWithImpl<DotCopySettings>(this as DotCopySettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DotCopySettings&&(identical(other.gridSize, gridSize) || other.gridSize == gridSize)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty));
}


@override
int get hashCode => Object.hash(runtimeType,gridSize,questionCount,difficulty);

@override
String toString() {
  return 'DotCopySettings(gridSize: $gridSize, questionCount: $questionCount, difficulty: $difficulty)';
}


}

/// @nodoc
abstract mixin class $DotCopySettingsCopyWith<$Res>  {
  factory $DotCopySettingsCopyWith(DotCopySettings value, $Res Function(DotCopySettings) _then) = _$DotCopySettingsCopyWithImpl;
@useResult
$Res call({
 int gridSize, int questionCount, DotCopyDifficulty difficulty
});




}
/// @nodoc
class _$DotCopySettingsCopyWithImpl<$Res>
    implements $DotCopySettingsCopyWith<$Res> {
  _$DotCopySettingsCopyWithImpl(this._self, this._then);

  final DotCopySettings _self;
  final $Res Function(DotCopySettings) _then;

/// Create a copy of DotCopySettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gridSize = null,Object? questionCount = null,Object? difficulty = null,}) {
  return _then(_self.copyWith(
gridSize: null == gridSize ? _self.gridSize : gridSize // ignore: cast_nullable_to_non_nullable
as int,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as DotCopyDifficulty,
  ));
}

}


/// Adds pattern-matching-related methods to [DotCopySettings].
extension DotCopySettingsPatterns on DotCopySettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DotCopySettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DotCopySettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DotCopySettings value)  $default,){
final _that = this;
switch (_that) {
case _DotCopySettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DotCopySettings value)?  $default,){
final _that = this;
switch (_that) {
case _DotCopySettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int gridSize,  int questionCount,  DotCopyDifficulty difficulty)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DotCopySettings() when $default != null:
return $default(_that.gridSize,_that.questionCount,_that.difficulty);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int gridSize,  int questionCount,  DotCopyDifficulty difficulty)  $default,) {final _that = this;
switch (_that) {
case _DotCopySettings():
return $default(_that.gridSize,_that.questionCount,_that.difficulty);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int gridSize,  int questionCount,  DotCopyDifficulty difficulty)?  $default,) {final _that = this;
switch (_that) {
case _DotCopySettings() when $default != null:
return $default(_that.gridSize,_that.questionCount,_that.difficulty);case _:
  return null;

}
}

}

/// @nodoc


class _DotCopySettings extends DotCopySettings {
  const _DotCopySettings({this.gridSize = 3, this.questionCount = 5, this.difficulty = DotCopyDifficulty.easy}): super._();
  

@override@JsonKey() final  int gridSize;
@override@JsonKey() final  int questionCount;
@override@JsonKey() final  DotCopyDifficulty difficulty;

/// Create a copy of DotCopySettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DotCopySettingsCopyWith<_DotCopySettings> get copyWith => __$DotCopySettingsCopyWithImpl<_DotCopySettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DotCopySettings&&(identical(other.gridSize, gridSize) || other.gridSize == gridSize)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty));
}


@override
int get hashCode => Object.hash(runtimeType,gridSize,questionCount,difficulty);

@override
String toString() {
  return 'DotCopySettings(gridSize: $gridSize, questionCount: $questionCount, difficulty: $difficulty)';
}


}

/// @nodoc
abstract mixin class _$DotCopySettingsCopyWith<$Res> implements $DotCopySettingsCopyWith<$Res> {
  factory _$DotCopySettingsCopyWith(_DotCopySettings value, $Res Function(_DotCopySettings) _then) = __$DotCopySettingsCopyWithImpl;
@override @useResult
$Res call({
 int gridSize, int questionCount, DotCopyDifficulty difficulty
});




}
/// @nodoc
class __$DotCopySettingsCopyWithImpl<$Res>
    implements _$DotCopySettingsCopyWith<$Res> {
  __$DotCopySettingsCopyWithImpl(this._self, this._then);

  final _DotCopySettings _self;
  final $Res Function(_DotCopySettings) _then;

/// Create a copy of DotCopySettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gridSize = null,Object? questionCount = null,Object? difficulty = null,}) {
  return _then(_DotCopySettings(
gridSize: null == gridSize ? _self.gridSize : gridSize // ignore: cast_nullable_to_non_nullable
as int,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as DotCopyDifficulty,
  ));
}


}

/// @nodoc
mixin _$DotCopyProblem {

 int get gridSize; List<LineSegment> get patternLines; String get questionText;
/// Create a copy of DotCopyProblem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DotCopyProblemCopyWith<DotCopyProblem> get copyWith => _$DotCopyProblemCopyWithImpl<DotCopyProblem>(this as DotCopyProblem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DotCopyProblem&&(identical(other.gridSize, gridSize) || other.gridSize == gridSize)&&const DeepCollectionEquality().equals(other.patternLines, patternLines)&&(identical(other.questionText, questionText) || other.questionText == questionText));
}


@override
int get hashCode => Object.hash(runtimeType,gridSize,const DeepCollectionEquality().hash(patternLines),questionText);

@override
String toString() {
  return 'DotCopyProblem(gridSize: $gridSize, patternLines: $patternLines, questionText: $questionText)';
}


}

/// @nodoc
abstract mixin class $DotCopyProblemCopyWith<$Res>  {
  factory $DotCopyProblemCopyWith(DotCopyProblem value, $Res Function(DotCopyProblem) _then) = _$DotCopyProblemCopyWithImpl;
@useResult
$Res call({
 int gridSize, List<LineSegment> patternLines, String questionText
});




}
/// @nodoc
class _$DotCopyProblemCopyWithImpl<$Res>
    implements $DotCopyProblemCopyWith<$Res> {
  _$DotCopyProblemCopyWithImpl(this._self, this._then);

  final DotCopyProblem _self;
  final $Res Function(DotCopyProblem) _then;

/// Create a copy of DotCopyProblem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gridSize = null,Object? patternLines = null,Object? questionText = null,}) {
  return _then(_self.copyWith(
gridSize: null == gridSize ? _self.gridSize : gridSize // ignore: cast_nullable_to_non_nullable
as int,patternLines: null == patternLines ? _self.patternLines : patternLines // ignore: cast_nullable_to_non_nullable
as List<LineSegment>,questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DotCopyProblem].
extension DotCopyProblemPatterns on DotCopyProblem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DotCopyProblem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DotCopyProblem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DotCopyProblem value)  $default,){
final _that = this;
switch (_that) {
case _DotCopyProblem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DotCopyProblem value)?  $default,){
final _that = this;
switch (_that) {
case _DotCopyProblem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int gridSize,  List<LineSegment> patternLines,  String questionText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DotCopyProblem() when $default != null:
return $default(_that.gridSize,_that.patternLines,_that.questionText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int gridSize,  List<LineSegment> patternLines,  String questionText)  $default,) {final _that = this;
switch (_that) {
case _DotCopyProblem():
return $default(_that.gridSize,_that.patternLines,_that.questionText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int gridSize,  List<LineSegment> patternLines,  String questionText)?  $default,) {final _that = this;
switch (_that) {
case _DotCopyProblem() when $default != null:
return $default(_that.gridSize,_that.patternLines,_that.questionText);case _:
  return null;

}
}

}

/// @nodoc


class _DotCopyProblem extends DotCopyProblem {
  const _DotCopyProblem({required this.gridSize, required final  List<LineSegment> patternLines, this.questionText = 'おてほんとおなじずをかきましょう'}): _patternLines = patternLines,super._();
  

@override final  int gridSize;
 final  List<LineSegment> _patternLines;
@override List<LineSegment> get patternLines {
  if (_patternLines is EqualUnmodifiableListView) return _patternLines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_patternLines);
}

@override@JsonKey() final  String questionText;

/// Create a copy of DotCopyProblem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DotCopyProblemCopyWith<_DotCopyProblem> get copyWith => __$DotCopyProblemCopyWithImpl<_DotCopyProblem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DotCopyProblem&&(identical(other.gridSize, gridSize) || other.gridSize == gridSize)&&const DeepCollectionEquality().equals(other._patternLines, _patternLines)&&(identical(other.questionText, questionText) || other.questionText == questionText));
}


@override
int get hashCode => Object.hash(runtimeType,gridSize,const DeepCollectionEquality().hash(_patternLines),questionText);

@override
String toString() {
  return 'DotCopyProblem(gridSize: $gridSize, patternLines: $patternLines, questionText: $questionText)';
}


}

/// @nodoc
abstract mixin class _$DotCopyProblemCopyWith<$Res> implements $DotCopyProblemCopyWith<$Res> {
  factory _$DotCopyProblemCopyWith(_DotCopyProblem value, $Res Function(_DotCopyProblem) _then) = __$DotCopyProblemCopyWithImpl;
@override @useResult
$Res call({
 int gridSize, List<LineSegment> patternLines, String questionText
});




}
/// @nodoc
class __$DotCopyProblemCopyWithImpl<$Res>
    implements _$DotCopyProblemCopyWith<$Res> {
  __$DotCopyProblemCopyWithImpl(this._self, this._then);

  final _DotCopyProblem _self;
  final $Res Function(_DotCopyProblem) _then;

/// Create a copy of DotCopyProblem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gridSize = null,Object? patternLines = null,Object? questionText = null,}) {
  return _then(_DotCopyProblem(
gridSize: null == gridSize ? _self.gridSize : gridSize // ignore: cast_nullable_to_non_nullable
as int,patternLines: null == patternLines ? _self._patternLines : patternLines // ignore: cast_nullable_to_non_nullable
as List<LineSegment>,questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$DotCopySession {

 int get index; int get total; List<bool?> get results; DotCopyProblem? get currentProblem; List<LineSegment> get drawnLines; DotPosition? get selectedDot; Offset? get dragPosition; int get wrongAttempts;
/// Create a copy of DotCopySession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DotCopySessionCopyWith<DotCopySession> get copyWith => _$DotCopySessionCopyWithImpl<DotCopySession>(this as DotCopySession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DotCopySession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&const DeepCollectionEquality().equals(other.drawnLines, drawnLines)&&(identical(other.selectedDot, selectedDot) || other.selectedDot == selectedDot)&&(identical(other.dragPosition, dragPosition) || other.dragPosition == dragPosition)&&(identical(other.wrongAttempts, wrongAttempts) || other.wrongAttempts == wrongAttempts));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(results),currentProblem,const DeepCollectionEquality().hash(drawnLines),selectedDot,dragPosition,wrongAttempts);

@override
String toString() {
  return 'DotCopySession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, drawnLines: $drawnLines, selectedDot: $selectedDot, dragPosition: $dragPosition, wrongAttempts: $wrongAttempts)';
}


}

/// @nodoc
abstract mixin class $DotCopySessionCopyWith<$Res>  {
  factory $DotCopySessionCopyWith(DotCopySession value, $Res Function(DotCopySession) _then) = _$DotCopySessionCopyWithImpl;
@useResult
$Res call({
 int index, int total, List<bool?> results, DotCopyProblem? currentProblem, List<LineSegment> drawnLines, DotPosition? selectedDot, Offset? dragPosition, int wrongAttempts
});


$DotCopyProblemCopyWith<$Res>? get currentProblem;$DotPositionCopyWith<$Res>? get selectedDot;

}
/// @nodoc
class _$DotCopySessionCopyWithImpl<$Res>
    implements $DotCopySessionCopyWith<$Res> {
  _$DotCopySessionCopyWithImpl(this._self, this._then);

  final DotCopySession _self;
  final $Res Function(DotCopySession) _then;

/// Create a copy of DotCopySession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? drawnLines = null,Object? selectedDot = freezed,Object? dragPosition = freezed,Object? wrongAttempts = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as DotCopyProblem?,drawnLines: null == drawnLines ? _self.drawnLines : drawnLines // ignore: cast_nullable_to_non_nullable
as List<LineSegment>,selectedDot: freezed == selectedDot ? _self.selectedDot : selectedDot // ignore: cast_nullable_to_non_nullable
as DotPosition?,dragPosition: freezed == dragPosition ? _self.dragPosition : dragPosition // ignore: cast_nullable_to_non_nullable
as Offset?,wrongAttempts: null == wrongAttempts ? _self.wrongAttempts : wrongAttempts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of DotCopySession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DotCopyProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $DotCopyProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}/// Create a copy of DotCopySession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DotPositionCopyWith<$Res>? get selectedDot {
    if (_self.selectedDot == null) {
    return null;
  }

  return $DotPositionCopyWith<$Res>(_self.selectedDot!, (value) {
    return _then(_self.copyWith(selectedDot: value));
  });
}
}


/// Adds pattern-matching-related methods to [DotCopySession].
extension DotCopySessionPatterns on DotCopySession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DotCopySession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DotCopySession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DotCopySession value)  $default,){
final _that = this;
switch (_that) {
case _DotCopySession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DotCopySession value)?  $default,){
final _that = this;
switch (_that) {
case _DotCopySession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  DotCopyProblem? currentProblem,  List<LineSegment> drawnLines,  DotPosition? selectedDot,  Offset? dragPosition,  int wrongAttempts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DotCopySession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.drawnLines,_that.selectedDot,_that.dragPosition,_that.wrongAttempts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  DotCopyProblem? currentProblem,  List<LineSegment> drawnLines,  DotPosition? selectedDot,  Offset? dragPosition,  int wrongAttempts)  $default,) {final _that = this;
switch (_that) {
case _DotCopySession():
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.drawnLines,_that.selectedDot,_that.dragPosition,_that.wrongAttempts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  int total,  List<bool?> results,  DotCopyProblem? currentProblem,  List<LineSegment> drawnLines,  DotPosition? selectedDot,  Offset? dragPosition,  int wrongAttempts)?  $default,) {final _that = this;
switch (_that) {
case _DotCopySession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.drawnLines,_that.selectedDot,_that.dragPosition,_that.wrongAttempts);case _:
  return null;

}
}

}

/// @nodoc


class _DotCopySession extends DotCopySession {
  const _DotCopySession({required this.index, required this.total, required final  List<bool?> results, this.currentProblem, final  List<LineSegment> drawnLines = const [], this.selectedDot, this.dragPosition, this.wrongAttempts = 0}): _results = results,_drawnLines = drawnLines,super._();
  

@override final  int index;
@override final  int total;
 final  List<bool?> _results;
@override List<bool?> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override final  DotCopyProblem? currentProblem;
 final  List<LineSegment> _drawnLines;
@override@JsonKey() List<LineSegment> get drawnLines {
  if (_drawnLines is EqualUnmodifiableListView) return _drawnLines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_drawnLines);
}

@override final  DotPosition? selectedDot;
@override final  Offset? dragPosition;
@override@JsonKey() final  int wrongAttempts;

/// Create a copy of DotCopySession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DotCopySessionCopyWith<_DotCopySession> get copyWith => __$DotCopySessionCopyWithImpl<_DotCopySession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DotCopySession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&const DeepCollectionEquality().equals(other._drawnLines, _drawnLines)&&(identical(other.selectedDot, selectedDot) || other.selectedDot == selectedDot)&&(identical(other.dragPosition, dragPosition) || other.dragPosition == dragPosition)&&(identical(other.wrongAttempts, wrongAttempts) || other.wrongAttempts == wrongAttempts));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(_results),currentProblem,const DeepCollectionEquality().hash(_drawnLines),selectedDot,dragPosition,wrongAttempts);

@override
String toString() {
  return 'DotCopySession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, drawnLines: $drawnLines, selectedDot: $selectedDot, dragPosition: $dragPosition, wrongAttempts: $wrongAttempts)';
}


}

/// @nodoc
abstract mixin class _$DotCopySessionCopyWith<$Res> implements $DotCopySessionCopyWith<$Res> {
  factory _$DotCopySessionCopyWith(_DotCopySession value, $Res Function(_DotCopySession) _then) = __$DotCopySessionCopyWithImpl;
@override @useResult
$Res call({
 int index, int total, List<bool?> results, DotCopyProblem? currentProblem, List<LineSegment> drawnLines, DotPosition? selectedDot, Offset? dragPosition, int wrongAttempts
});


@override $DotCopyProblemCopyWith<$Res>? get currentProblem;@override $DotPositionCopyWith<$Res>? get selectedDot;

}
/// @nodoc
class __$DotCopySessionCopyWithImpl<$Res>
    implements _$DotCopySessionCopyWith<$Res> {
  __$DotCopySessionCopyWithImpl(this._self, this._then);

  final _DotCopySession _self;
  final $Res Function(_DotCopySession) _then;

/// Create a copy of DotCopySession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? drawnLines = null,Object? selectedDot = freezed,Object? dragPosition = freezed,Object? wrongAttempts = null,}) {
  return _then(_DotCopySession(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as DotCopyProblem?,drawnLines: null == drawnLines ? _self._drawnLines : drawnLines // ignore: cast_nullable_to_non_nullable
as List<LineSegment>,selectedDot: freezed == selectedDot ? _self.selectedDot : selectedDot // ignore: cast_nullable_to_non_nullable
as DotPosition?,dragPosition: freezed == dragPosition ? _self.dragPosition : dragPosition // ignore: cast_nullable_to_non_nullable
as Offset?,wrongAttempts: null == wrongAttempts ? _self.wrongAttempts : wrongAttempts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of DotCopySession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DotCopyProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $DotCopyProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}/// Create a copy of DotCopySession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DotPositionCopyWith<$Res>? get selectedDot {
    if (_self.selectedDot == null) {
    return null;
  }

  return $DotPositionCopyWith<$Res>(_self.selectedDot!, (value) {
    return _then(_self.copyWith(selectedDot: value));
  });
}
}

/// @nodoc
mixin _$DotCopyState {

 CommonGamePhase get phase; DotCopySettings? get settings; DotCopySession? get session; int get epoch;
/// Create a copy of DotCopyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DotCopyStateCopyWith<DotCopyState> get copyWith => _$DotCopyStateCopyWithImpl<DotCopyState>(this as DotCopyState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DotCopyState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,epoch);

@override
String toString() {
  return 'DotCopyState(phase: $phase, settings: $settings, session: $session, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class $DotCopyStateCopyWith<$Res>  {
  factory $DotCopyStateCopyWith(DotCopyState value, $Res Function(DotCopyState) _then) = _$DotCopyStateCopyWithImpl;
@useResult
$Res call({
 CommonGamePhase phase, DotCopySettings? settings, DotCopySession? session, int epoch
});


$DotCopySettingsCopyWith<$Res>? get settings;$DotCopySessionCopyWith<$Res>? get session;

}
/// @nodoc
class _$DotCopyStateCopyWithImpl<$Res>
    implements $DotCopyStateCopyWith<$Res> {
  _$DotCopyStateCopyWithImpl(this._self, this._then);

  final DotCopyState _self;
  final $Res Function(DotCopyState) _then;

/// Create a copy of DotCopyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? epoch = null,}) {
  return _then(_self.copyWith(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as DotCopySettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as DotCopySession?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of DotCopyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DotCopySettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $DotCopySettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of DotCopyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DotCopySessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $DotCopySessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}


/// Adds pattern-matching-related methods to [DotCopyState].
extension DotCopyStatePatterns on DotCopyState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DotCopyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DotCopyState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DotCopyState value)  $default,){
final _that = this;
switch (_that) {
case _DotCopyState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DotCopyState value)?  $default,){
final _that = this;
switch (_that) {
case _DotCopyState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CommonGamePhase phase,  DotCopySettings? settings,  DotCopySession? session,  int epoch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DotCopyState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CommonGamePhase phase,  DotCopySettings? settings,  DotCopySession? session,  int epoch)  $default,) {final _that = this;
switch (_that) {
case _DotCopyState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CommonGamePhase phase,  DotCopySettings? settings,  DotCopySession? session,  int epoch)?  $default,) {final _that = this;
switch (_that) {
case _DotCopyState() when $default != null:
return $default(_that.phase,_that.settings,_that.session,_that.epoch);case _:
  return null;

}
}

}

/// @nodoc


class _DotCopyState extends DotCopyState {
  const _DotCopyState({this.phase = CommonGamePhase.ready, this.settings, this.session, this.epoch = 0}): super._();
  

@override@JsonKey() final  CommonGamePhase phase;
@override final  DotCopySettings? settings;
@override final  DotCopySession? session;
@override@JsonKey() final  int epoch;

/// Create a copy of DotCopyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DotCopyStateCopyWith<_DotCopyState> get copyWith => __$DotCopyStateCopyWithImpl<_DotCopyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DotCopyState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,epoch);

@override
String toString() {
  return 'DotCopyState(phase: $phase, settings: $settings, session: $session, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class _$DotCopyStateCopyWith<$Res> implements $DotCopyStateCopyWith<$Res> {
  factory _$DotCopyStateCopyWith(_DotCopyState value, $Res Function(_DotCopyState) _then) = __$DotCopyStateCopyWithImpl;
@override @useResult
$Res call({
 CommonGamePhase phase, DotCopySettings? settings, DotCopySession? session, int epoch
});


@override $DotCopySettingsCopyWith<$Res>? get settings;@override $DotCopySessionCopyWith<$Res>? get session;

}
/// @nodoc
class __$DotCopyStateCopyWithImpl<$Res>
    implements _$DotCopyStateCopyWith<$Res> {
  __$DotCopyStateCopyWithImpl(this._self, this._then);

  final _DotCopyState _self;
  final $Res Function(_DotCopyState) _then;

/// Create a copy of DotCopyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? epoch = null,}) {
  return _then(_DotCopyState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as DotCopySettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as DotCopySession?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of DotCopyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DotCopySettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $DotCopySettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of DotCopyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DotCopySessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $DotCopySessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

// dart format on
