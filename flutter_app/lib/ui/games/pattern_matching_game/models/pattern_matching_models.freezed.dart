// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pattern_matching_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PatternSpec {

 PatternShape get shape; PatternColor get color; PatternFillType get fillType;
/// Create a copy of PatternSpec
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatternSpecCopyWith<PatternSpec> get copyWith => _$PatternSpecCopyWithImpl<PatternSpec>(this as PatternSpec, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatternSpec&&(identical(other.shape, shape) || other.shape == shape)&&(identical(other.color, color) || other.color == color)&&(identical(other.fillType, fillType) || other.fillType == fillType));
}


@override
int get hashCode => Object.hash(runtimeType,shape,color,fillType);

@override
String toString() {
  return 'PatternSpec(shape: $shape, color: $color, fillType: $fillType)';
}


}

/// @nodoc
abstract mixin class $PatternSpecCopyWith<$Res>  {
  factory $PatternSpecCopyWith(PatternSpec value, $Res Function(PatternSpec) _then) = _$PatternSpecCopyWithImpl;
@useResult
$Res call({
 PatternShape shape, PatternColor color, PatternFillType fillType
});




}
/// @nodoc
class _$PatternSpecCopyWithImpl<$Res>
    implements $PatternSpecCopyWith<$Res> {
  _$PatternSpecCopyWithImpl(this._self, this._then);

  final PatternSpec _self;
  final $Res Function(PatternSpec) _then;

/// Create a copy of PatternSpec
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shape = null,Object? color = null,Object? fillType = null,}) {
  return _then(_self.copyWith(
shape: null == shape ? _self.shape : shape // ignore: cast_nullable_to_non_nullable
as PatternShape,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as PatternColor,fillType: null == fillType ? _self.fillType : fillType // ignore: cast_nullable_to_non_nullable
as PatternFillType,
  ));
}

}


/// Adds pattern-matching-related methods to [PatternSpec].
extension PatternSpecPatterns on PatternSpec {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PatternSpec value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatternSpec() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PatternSpec value)  $default,){
final _that = this;
switch (_that) {
case _PatternSpec():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PatternSpec value)?  $default,){
final _that = this;
switch (_that) {
case _PatternSpec() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PatternShape shape,  PatternColor color,  PatternFillType fillType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatternSpec() when $default != null:
return $default(_that.shape,_that.color,_that.fillType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PatternShape shape,  PatternColor color,  PatternFillType fillType)  $default,) {final _that = this;
switch (_that) {
case _PatternSpec():
return $default(_that.shape,_that.color,_that.fillType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PatternShape shape,  PatternColor color,  PatternFillType fillType)?  $default,) {final _that = this;
switch (_that) {
case _PatternSpec() when $default != null:
return $default(_that.shape,_that.color,_that.fillType);case _:
  return null;

}
}

}

/// @nodoc


class _PatternSpec extends PatternSpec {
  const _PatternSpec({required this.shape, required this.color, this.fillType = PatternFillType.filled}): super._();
  

@override final  PatternShape shape;
@override final  PatternColor color;
@override@JsonKey() final  PatternFillType fillType;

/// Create a copy of PatternSpec
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatternSpecCopyWith<_PatternSpec> get copyWith => __$PatternSpecCopyWithImpl<_PatternSpec>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatternSpec&&(identical(other.shape, shape) || other.shape == shape)&&(identical(other.color, color) || other.color == color)&&(identical(other.fillType, fillType) || other.fillType == fillType));
}


@override
int get hashCode => Object.hash(runtimeType,shape,color,fillType);

@override
String toString() {
  return 'PatternSpec(shape: $shape, color: $color, fillType: $fillType)';
}


}

/// @nodoc
abstract mixin class _$PatternSpecCopyWith<$Res> implements $PatternSpecCopyWith<$Res> {
  factory _$PatternSpecCopyWith(_PatternSpec value, $Res Function(_PatternSpec) _then) = __$PatternSpecCopyWithImpl;
@override @useResult
$Res call({
 PatternShape shape, PatternColor color, PatternFillType fillType
});




}
/// @nodoc
class __$PatternSpecCopyWithImpl<$Res>
    implements _$PatternSpecCopyWith<$Res> {
  __$PatternSpecCopyWithImpl(this._self, this._then);

  final _PatternSpec _self;
  final $Res Function(_PatternSpec) _then;

/// Create a copy of PatternSpec
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shape = null,Object? color = null,Object? fillType = null,}) {
  return _then(_PatternSpec(
shape: null == shape ? _self.shape : shape // ignore: cast_nullable_to_non_nullable
as PatternShape,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as PatternColor,fillType: null == fillType ? _self.fillType : fillType // ignore: cast_nullable_to_non_nullable
as PatternFillType,
  ));
}


}

/// @nodoc
mixin _$PatternMatchingSettings {

 int get questionCount; int get seed;
/// Create a copy of PatternMatchingSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatternMatchingSettingsCopyWith<PatternMatchingSettings> get copyWith => _$PatternMatchingSettingsCopyWithImpl<PatternMatchingSettings>(this as PatternMatchingSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatternMatchingSettings&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.seed, seed) || other.seed == seed));
}


@override
int get hashCode => Object.hash(runtimeType,questionCount,seed);

@override
String toString() {
  return 'PatternMatchingSettings(questionCount: $questionCount, seed: $seed)';
}


}

/// @nodoc
abstract mixin class $PatternMatchingSettingsCopyWith<$Res>  {
  factory $PatternMatchingSettingsCopyWith(PatternMatchingSettings value, $Res Function(PatternMatchingSettings) _then) = _$PatternMatchingSettingsCopyWithImpl;
@useResult
$Res call({
 int questionCount, int seed
});




}
/// @nodoc
class _$PatternMatchingSettingsCopyWithImpl<$Res>
    implements $PatternMatchingSettingsCopyWith<$Res> {
  _$PatternMatchingSettingsCopyWithImpl(this._self, this._then);

  final PatternMatchingSettings _self;
  final $Res Function(PatternMatchingSettings) _then;

/// Create a copy of PatternMatchingSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionCount = null,Object? seed = null,}) {
  return _then(_self.copyWith(
questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,seed: null == seed ? _self.seed : seed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PatternMatchingSettings].
extension PatternMatchingSettingsPatterns on PatternMatchingSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PatternMatchingSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatternMatchingSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PatternMatchingSettings value)  $default,){
final _that = this;
switch (_that) {
case _PatternMatchingSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PatternMatchingSettings value)?  $default,){
final _that = this;
switch (_that) {
case _PatternMatchingSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int questionCount,  int seed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatternMatchingSettings() when $default != null:
return $default(_that.questionCount,_that.seed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int questionCount,  int seed)  $default,) {final _that = this;
switch (_that) {
case _PatternMatchingSettings():
return $default(_that.questionCount,_that.seed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int questionCount,  int seed)?  $default,) {final _that = this;
switch (_that) {
case _PatternMatchingSettings() when $default != null:
return $default(_that.questionCount,_that.seed);case _:
  return null;

}
}

}

/// @nodoc


class _PatternMatchingSettings extends PatternMatchingSettings {
  const _PatternMatchingSettings({this.questionCount = 5, this.seed = 0}): super._();
  

@override@JsonKey() final  int questionCount;
@override@JsonKey() final  int seed;

/// Create a copy of PatternMatchingSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatternMatchingSettingsCopyWith<_PatternMatchingSettings> get copyWith => __$PatternMatchingSettingsCopyWithImpl<_PatternMatchingSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatternMatchingSettings&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.seed, seed) || other.seed == seed));
}


@override
int get hashCode => Object.hash(runtimeType,questionCount,seed);

@override
String toString() {
  return 'PatternMatchingSettings(questionCount: $questionCount, seed: $seed)';
}


}

/// @nodoc
abstract mixin class _$PatternMatchingSettingsCopyWith<$Res> implements $PatternMatchingSettingsCopyWith<$Res> {
  factory _$PatternMatchingSettingsCopyWith(_PatternMatchingSettings value, $Res Function(_PatternMatchingSettings) _then) = __$PatternMatchingSettingsCopyWithImpl;
@override @useResult
$Res call({
 int questionCount, int seed
});




}
/// @nodoc
class __$PatternMatchingSettingsCopyWithImpl<$Res>
    implements _$PatternMatchingSettingsCopyWith<$Res> {
  __$PatternMatchingSettingsCopyWithImpl(this._self, this._then);

  final _PatternMatchingSettings _self;
  final $Res Function(_PatternMatchingSettings) _then;

/// Create a copy of PatternMatchingSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionCount = null,Object? seed = null,}) {
  return _then(_PatternMatchingSettings(
questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,seed: null == seed ? _self.seed : seed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$PatternMatchingProblem {

 List<PatternSpec?> get sequence;// 9個の図形（?の位置はnull）
 int get questionMarkIndex;// ?の位置
 List<PatternSpec> get choices;// 選択肢3個
 int get correctAnswerIndex;// 正解のインデックス（0-2）
 String get questionText;
/// Create a copy of PatternMatchingProblem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatternMatchingProblemCopyWith<PatternMatchingProblem> get copyWith => _$PatternMatchingProblemCopyWithImpl<PatternMatchingProblem>(this as PatternMatchingProblem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatternMatchingProblem&&const DeepCollectionEquality().equals(other.sequence, sequence)&&(identical(other.questionMarkIndex, questionMarkIndex) || other.questionMarkIndex == questionMarkIndex)&&const DeepCollectionEquality().equals(other.choices, choices)&&(identical(other.correctAnswerIndex, correctAnswerIndex) || other.correctAnswerIndex == correctAnswerIndex)&&(identical(other.questionText, questionText) || other.questionText == questionText));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sequence),questionMarkIndex,const DeepCollectionEquality().hash(choices),correctAnswerIndex,questionText);

@override
String toString() {
  return 'PatternMatchingProblem(sequence: $sequence, questionMarkIndex: $questionMarkIndex, choices: $choices, correctAnswerIndex: $correctAnswerIndex, questionText: $questionText)';
}


}

/// @nodoc
abstract mixin class $PatternMatchingProblemCopyWith<$Res>  {
  factory $PatternMatchingProblemCopyWith(PatternMatchingProblem value, $Res Function(PatternMatchingProblem) _then) = _$PatternMatchingProblemCopyWithImpl;
@useResult
$Res call({
 List<PatternSpec?> sequence, int questionMarkIndex, List<PatternSpec> choices, int correctAnswerIndex, String questionText
});




}
/// @nodoc
class _$PatternMatchingProblemCopyWithImpl<$Res>
    implements $PatternMatchingProblemCopyWith<$Res> {
  _$PatternMatchingProblemCopyWithImpl(this._self, this._then);

  final PatternMatchingProblem _self;
  final $Res Function(PatternMatchingProblem) _then;

/// Create a copy of PatternMatchingProblem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sequence = null,Object? questionMarkIndex = null,Object? choices = null,Object? correctAnswerIndex = null,Object? questionText = null,}) {
  return _then(_self.copyWith(
sequence: null == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as List<PatternSpec?>,questionMarkIndex: null == questionMarkIndex ? _self.questionMarkIndex : questionMarkIndex // ignore: cast_nullable_to_non_nullable
as int,choices: null == choices ? _self.choices : choices // ignore: cast_nullable_to_non_nullable
as List<PatternSpec>,correctAnswerIndex: null == correctAnswerIndex ? _self.correctAnswerIndex : correctAnswerIndex // ignore: cast_nullable_to_non_nullable
as int,questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PatternMatchingProblem].
extension PatternMatchingProblemPatterns on PatternMatchingProblem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PatternMatchingProblem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatternMatchingProblem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PatternMatchingProblem value)  $default,){
final _that = this;
switch (_that) {
case _PatternMatchingProblem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PatternMatchingProblem value)?  $default,){
final _that = this;
switch (_that) {
case _PatternMatchingProblem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PatternSpec?> sequence,  int questionMarkIndex,  List<PatternSpec> choices,  int correctAnswerIndex,  String questionText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatternMatchingProblem() when $default != null:
return $default(_that.sequence,_that.questionMarkIndex,_that.choices,_that.correctAnswerIndex,_that.questionText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PatternSpec?> sequence,  int questionMarkIndex,  List<PatternSpec> choices,  int correctAnswerIndex,  String questionText)  $default,) {final _that = this;
switch (_that) {
case _PatternMatchingProblem():
return $default(_that.sequence,_that.questionMarkIndex,_that.choices,_that.correctAnswerIndex,_that.questionText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PatternSpec?> sequence,  int questionMarkIndex,  List<PatternSpec> choices,  int correctAnswerIndex,  String questionText)?  $default,) {final _that = this;
switch (_that) {
case _PatternMatchingProblem() when $default != null:
return $default(_that.sequence,_that.questionMarkIndex,_that.choices,_that.correctAnswerIndex,_that.questionText);case _:
  return null;

}
}

}

/// @nodoc


class _PatternMatchingProblem extends PatternMatchingProblem {
  const _PatternMatchingProblem({required final  List<PatternSpec?> sequence, required this.questionMarkIndex, required final  List<PatternSpec> choices, required this.correctAnswerIndex, required this.questionText}): _sequence = sequence,_choices = choices,super._();
  

 final  List<PatternSpec?> _sequence;
@override List<PatternSpec?> get sequence {
  if (_sequence is EqualUnmodifiableListView) return _sequence;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sequence);
}

// 9個の図形（?の位置はnull）
@override final  int questionMarkIndex;
// ?の位置
 final  List<PatternSpec> _choices;
// ?の位置
@override List<PatternSpec> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}

// 選択肢3個
@override final  int correctAnswerIndex;
// 正解のインデックス（0-2）
@override final  String questionText;

/// Create a copy of PatternMatchingProblem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatternMatchingProblemCopyWith<_PatternMatchingProblem> get copyWith => __$PatternMatchingProblemCopyWithImpl<_PatternMatchingProblem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatternMatchingProblem&&const DeepCollectionEquality().equals(other._sequence, _sequence)&&(identical(other.questionMarkIndex, questionMarkIndex) || other.questionMarkIndex == questionMarkIndex)&&const DeepCollectionEquality().equals(other._choices, _choices)&&(identical(other.correctAnswerIndex, correctAnswerIndex) || other.correctAnswerIndex == correctAnswerIndex)&&(identical(other.questionText, questionText) || other.questionText == questionText));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sequence),questionMarkIndex,const DeepCollectionEquality().hash(_choices),correctAnswerIndex,questionText);

@override
String toString() {
  return 'PatternMatchingProblem(sequence: $sequence, questionMarkIndex: $questionMarkIndex, choices: $choices, correctAnswerIndex: $correctAnswerIndex, questionText: $questionText)';
}


}

/// @nodoc
abstract mixin class _$PatternMatchingProblemCopyWith<$Res> implements $PatternMatchingProblemCopyWith<$Res> {
  factory _$PatternMatchingProblemCopyWith(_PatternMatchingProblem value, $Res Function(_PatternMatchingProblem) _then) = __$PatternMatchingProblemCopyWithImpl;
@override @useResult
$Res call({
 List<PatternSpec?> sequence, int questionMarkIndex, List<PatternSpec> choices, int correctAnswerIndex, String questionText
});




}
/// @nodoc
class __$PatternMatchingProblemCopyWithImpl<$Res>
    implements _$PatternMatchingProblemCopyWith<$Res> {
  __$PatternMatchingProblemCopyWithImpl(this._self, this._then);

  final _PatternMatchingProblem _self;
  final $Res Function(_PatternMatchingProblem) _then;

/// Create a copy of PatternMatchingProblem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sequence = null,Object? questionMarkIndex = null,Object? choices = null,Object? correctAnswerIndex = null,Object? questionText = null,}) {
  return _then(_PatternMatchingProblem(
sequence: null == sequence ? _self._sequence : sequence // ignore: cast_nullable_to_non_nullable
as List<PatternSpec?>,questionMarkIndex: null == questionMarkIndex ? _self.questionMarkIndex : questionMarkIndex // ignore: cast_nullable_to_non_nullable
as int,choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<PatternSpec>,correctAnswerIndex: null == correctAnswerIndex ? _self.correctAnswerIndex : correctAnswerIndex // ignore: cast_nullable_to_non_nullable
as int,questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$PatternMatchingSession {

 int get index;// 現在の問題番号（0-based）
 int get total;// 総問題数
 List<bool?> get results;// 結果配列（null=未回答, true=完璧, false=不完璧）
 PatternMatchingProblem? get currentProblem; int get wrongAttempts;
/// Create a copy of PatternMatchingSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatternMatchingSessionCopyWith<PatternMatchingSession> get copyWith => _$PatternMatchingSessionCopyWithImpl<PatternMatchingSession>(this as PatternMatchingSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatternMatchingSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&(identical(other.wrongAttempts, wrongAttempts) || other.wrongAttempts == wrongAttempts));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(results),currentProblem,wrongAttempts);

@override
String toString() {
  return 'PatternMatchingSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, wrongAttempts: $wrongAttempts)';
}


}

/// @nodoc
abstract mixin class $PatternMatchingSessionCopyWith<$Res>  {
  factory $PatternMatchingSessionCopyWith(PatternMatchingSession value, $Res Function(PatternMatchingSession) _then) = _$PatternMatchingSessionCopyWithImpl;
@useResult
$Res call({
 int index, int total, List<bool?> results, PatternMatchingProblem? currentProblem, int wrongAttempts
});


$PatternMatchingProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class _$PatternMatchingSessionCopyWithImpl<$Res>
    implements $PatternMatchingSessionCopyWith<$Res> {
  _$PatternMatchingSessionCopyWithImpl(this._self, this._then);

  final PatternMatchingSession _self;
  final $Res Function(PatternMatchingSession) _then;

/// Create a copy of PatternMatchingSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? wrongAttempts = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as PatternMatchingProblem?,wrongAttempts: null == wrongAttempts ? _self.wrongAttempts : wrongAttempts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of PatternMatchingSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PatternMatchingProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $PatternMatchingProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}


/// Adds pattern-matching-related methods to [PatternMatchingSession].
extension PatternMatchingSessionPatterns on PatternMatchingSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PatternMatchingSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatternMatchingSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PatternMatchingSession value)  $default,){
final _that = this;
switch (_that) {
case _PatternMatchingSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PatternMatchingSession value)?  $default,){
final _that = this;
switch (_that) {
case _PatternMatchingSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  PatternMatchingProblem? currentProblem,  int wrongAttempts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatternMatchingSession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAttempts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  PatternMatchingProblem? currentProblem,  int wrongAttempts)  $default,) {final _that = this;
switch (_that) {
case _PatternMatchingSession():
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAttempts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  int total,  List<bool?> results,  PatternMatchingProblem? currentProblem,  int wrongAttempts)?  $default,) {final _that = this;
switch (_that) {
case _PatternMatchingSession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAttempts);case _:
  return null;

}
}

}

/// @nodoc


class _PatternMatchingSession extends PatternMatchingSession {
  const _PatternMatchingSession({required this.index, required this.total, required final  List<bool?> results, this.currentProblem, this.wrongAttempts = 0}): _results = results,super._();
  

@override final  int index;
// 現在の問題番号（0-based）
@override final  int total;
// 総問題数
 final  List<bool?> _results;
// 総問題数
@override List<bool?> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

// 結果配列（null=未回答, true=完璧, false=不完璧）
@override final  PatternMatchingProblem? currentProblem;
@override@JsonKey() final  int wrongAttempts;

/// Create a copy of PatternMatchingSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatternMatchingSessionCopyWith<_PatternMatchingSession> get copyWith => __$PatternMatchingSessionCopyWithImpl<_PatternMatchingSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatternMatchingSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&(identical(other.wrongAttempts, wrongAttempts) || other.wrongAttempts == wrongAttempts));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(_results),currentProblem,wrongAttempts);

@override
String toString() {
  return 'PatternMatchingSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, wrongAttempts: $wrongAttempts)';
}


}

/// @nodoc
abstract mixin class _$PatternMatchingSessionCopyWith<$Res> implements $PatternMatchingSessionCopyWith<$Res> {
  factory _$PatternMatchingSessionCopyWith(_PatternMatchingSession value, $Res Function(_PatternMatchingSession) _then) = __$PatternMatchingSessionCopyWithImpl;
@override @useResult
$Res call({
 int index, int total, List<bool?> results, PatternMatchingProblem? currentProblem, int wrongAttempts
});


@override $PatternMatchingProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class __$PatternMatchingSessionCopyWithImpl<$Res>
    implements _$PatternMatchingSessionCopyWith<$Res> {
  __$PatternMatchingSessionCopyWithImpl(this._self, this._then);

  final _PatternMatchingSession _self;
  final $Res Function(_PatternMatchingSession) _then;

/// Create a copy of PatternMatchingSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? wrongAttempts = null,}) {
  return _then(_PatternMatchingSession(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as PatternMatchingProblem?,wrongAttempts: null == wrongAttempts ? _self.wrongAttempts : wrongAttempts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of PatternMatchingSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PatternMatchingProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $PatternMatchingProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}

/// @nodoc
mixin _$PatternMatchingState {

 CommonGamePhase get phase; PatternMatchingSettings? get settings; PatternMatchingSession? get session; int get epoch;
/// Create a copy of PatternMatchingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatternMatchingStateCopyWith<PatternMatchingState> get copyWith => _$PatternMatchingStateCopyWithImpl<PatternMatchingState>(this as PatternMatchingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatternMatchingState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,epoch);

@override
String toString() {
  return 'PatternMatchingState(phase: $phase, settings: $settings, session: $session, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class $PatternMatchingStateCopyWith<$Res>  {
  factory $PatternMatchingStateCopyWith(PatternMatchingState value, $Res Function(PatternMatchingState) _then) = _$PatternMatchingStateCopyWithImpl;
@useResult
$Res call({
 CommonGamePhase phase, PatternMatchingSettings? settings, PatternMatchingSession? session, int epoch
});


$PatternMatchingSettingsCopyWith<$Res>? get settings;$PatternMatchingSessionCopyWith<$Res>? get session;

}
/// @nodoc
class _$PatternMatchingStateCopyWithImpl<$Res>
    implements $PatternMatchingStateCopyWith<$Res> {
  _$PatternMatchingStateCopyWithImpl(this._self, this._then);

  final PatternMatchingState _self;
  final $Res Function(PatternMatchingState) _then;

/// Create a copy of PatternMatchingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? epoch = null,}) {
  return _then(_self.copyWith(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as PatternMatchingSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as PatternMatchingSession?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of PatternMatchingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PatternMatchingSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $PatternMatchingSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of PatternMatchingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PatternMatchingSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $PatternMatchingSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}


/// Adds pattern-matching-related methods to [PatternMatchingState].
extension PatternMatchingStatePatterns on PatternMatchingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PatternMatchingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatternMatchingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PatternMatchingState value)  $default,){
final _that = this;
switch (_that) {
case _PatternMatchingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PatternMatchingState value)?  $default,){
final _that = this;
switch (_that) {
case _PatternMatchingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CommonGamePhase phase,  PatternMatchingSettings? settings,  PatternMatchingSession? session,  int epoch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatternMatchingState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CommonGamePhase phase,  PatternMatchingSettings? settings,  PatternMatchingSession? session,  int epoch)  $default,) {final _that = this;
switch (_that) {
case _PatternMatchingState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CommonGamePhase phase,  PatternMatchingSettings? settings,  PatternMatchingSession? session,  int epoch)?  $default,) {final _that = this;
switch (_that) {
case _PatternMatchingState() when $default != null:
return $default(_that.phase,_that.settings,_that.session,_that.epoch);case _:
  return null;

}
}

}

/// @nodoc


class _PatternMatchingState extends PatternMatchingState {
  const _PatternMatchingState({this.phase = CommonGamePhase.ready, this.settings, this.session, this.epoch = 0}): super._();
  

@override@JsonKey() final  CommonGamePhase phase;
@override final  PatternMatchingSettings? settings;
@override final  PatternMatchingSession? session;
@override@JsonKey() final  int epoch;

/// Create a copy of PatternMatchingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatternMatchingStateCopyWith<_PatternMatchingState> get copyWith => __$PatternMatchingStateCopyWithImpl<_PatternMatchingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatternMatchingState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,epoch);

@override
String toString() {
  return 'PatternMatchingState(phase: $phase, settings: $settings, session: $session, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class _$PatternMatchingStateCopyWith<$Res> implements $PatternMatchingStateCopyWith<$Res> {
  factory _$PatternMatchingStateCopyWith(_PatternMatchingState value, $Res Function(_PatternMatchingState) _then) = __$PatternMatchingStateCopyWithImpl;
@override @useResult
$Res call({
 CommonGamePhase phase, PatternMatchingSettings? settings, PatternMatchingSession? session, int epoch
});


@override $PatternMatchingSettingsCopyWith<$Res>? get settings;@override $PatternMatchingSessionCopyWith<$Res>? get session;

}
/// @nodoc
class __$PatternMatchingStateCopyWithImpl<$Res>
    implements _$PatternMatchingStateCopyWith<$Res> {
  __$PatternMatchingStateCopyWithImpl(this._self, this._then);

  final _PatternMatchingState _self;
  final $Res Function(_PatternMatchingState) _then;

/// Create a copy of PatternMatchingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? epoch = null,}) {
  return _then(_PatternMatchingState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as PatternMatchingSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as PatternMatchingSession?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of PatternMatchingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PatternMatchingSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $PatternMatchingSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of PatternMatchingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PatternMatchingSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $PatternMatchingSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

// dart format on
