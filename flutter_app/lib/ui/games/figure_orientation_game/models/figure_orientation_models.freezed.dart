// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'figure_orientation_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FigureOrientationSettings {

 FigureOrientationRange get range; int get questionCount;
/// Create a copy of FigureOrientationSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FigureOrientationSettingsCopyWith<FigureOrientationSettings> get copyWith => _$FigureOrientationSettingsCopyWithImpl<FigureOrientationSettings>(this as FigureOrientationSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FigureOrientationSettings&&(identical(other.range, range) || other.range == range)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount));
}


@override
int get hashCode => Object.hash(runtimeType,range,questionCount);

@override
String toString() {
  return 'FigureOrientationSettings(range: $range, questionCount: $questionCount)';
}


}

/// @nodoc
abstract mixin class $FigureOrientationSettingsCopyWith<$Res>  {
  factory $FigureOrientationSettingsCopyWith(FigureOrientationSettings value, $Res Function(FigureOrientationSettings) _then) = _$FigureOrientationSettingsCopyWithImpl;
@useResult
$Res call({
 FigureOrientationRange range, int questionCount
});




}
/// @nodoc
class _$FigureOrientationSettingsCopyWithImpl<$Res>
    implements $FigureOrientationSettingsCopyWith<$Res> {
  _$FigureOrientationSettingsCopyWithImpl(this._self, this._then);

  final FigureOrientationSettings _self;
  final $Res Function(FigureOrientationSettings) _then;

/// Create a copy of FigureOrientationSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? range = null,Object? questionCount = null,}) {
  return _then(_self.copyWith(
range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as FigureOrientationRange,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FigureOrientationSettings].
extension FigureOrientationSettingsPatterns on FigureOrientationSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FigureOrientationSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FigureOrientationSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FigureOrientationSettings value)  $default,){
final _that = this;
switch (_that) {
case _FigureOrientationSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FigureOrientationSettings value)?  $default,){
final _that = this;
switch (_that) {
case _FigureOrientationSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FigureOrientationRange range,  int questionCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FigureOrientationSettings() when $default != null:
return $default(_that.range,_that.questionCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FigureOrientationRange range,  int questionCount)  $default,) {final _that = this;
switch (_that) {
case _FigureOrientationSettings():
return $default(_that.range,_that.questionCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FigureOrientationRange range,  int questionCount)?  $default,) {final _that = this;
switch (_that) {
case _FigureOrientationSettings() when $default != null:
return $default(_that.range,_that.questionCount);case _:
  return null;

}
}

}

/// @nodoc


class _FigureOrientationSettings extends FigureOrientationSettings {
  const _FigureOrientationSettings({this.range = FigureOrientationRange.medium, this.questionCount = 5}): super._();
  

@override@JsonKey() final  FigureOrientationRange range;
@override@JsonKey() final  int questionCount;

/// Create a copy of FigureOrientationSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FigureOrientationSettingsCopyWith<_FigureOrientationSettings> get copyWith => __$FigureOrientationSettingsCopyWithImpl<_FigureOrientationSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FigureOrientationSettings&&(identical(other.range, range) || other.range == range)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount));
}


@override
int get hashCode => Object.hash(runtimeType,range,questionCount);

@override
String toString() {
  return 'FigureOrientationSettings(range: $range, questionCount: $questionCount)';
}


}

/// @nodoc
abstract mixin class _$FigureOrientationSettingsCopyWith<$Res> implements $FigureOrientationSettingsCopyWith<$Res> {
  factory _$FigureOrientationSettingsCopyWith(_FigureOrientationSettings value, $Res Function(_FigureOrientationSettings) _then) = __$FigureOrientationSettingsCopyWithImpl;
@override @useResult
$Res call({
 FigureOrientationRange range, int questionCount
});




}
/// @nodoc
class __$FigureOrientationSettingsCopyWithImpl<$Res>
    implements _$FigureOrientationSettingsCopyWith<$Res> {
  __$FigureOrientationSettingsCopyWithImpl(this._self, this._then);

  final _FigureOrientationSettings _self;
  final $Res Function(_FigureOrientationSettings) _then;

/// Create a copy of FigureOrientationSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? range = null,Object? questionCount = null,}) {
  return _then(_FigureOrientationSettings(
range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as FigureOrientationRange,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
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

/// @nodoc
mixin _$FigureOrientationProblem {

 String get questionText; int get correctAnswerIndex; List<FigureOrientationOption> get options; String get imagePath;
/// Create a copy of FigureOrientationProblem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FigureOrientationProblemCopyWith<FigureOrientationProblem> get copyWith => _$FigureOrientationProblemCopyWithImpl<FigureOrientationProblem>(this as FigureOrientationProblem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FigureOrientationProblem&&(identical(other.questionText, questionText) || other.questionText == questionText)&&(identical(other.correctAnswerIndex, correctAnswerIndex) || other.correctAnswerIndex == correctAnswerIndex)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath));
}


@override
int get hashCode => Object.hash(runtimeType,questionText,correctAnswerIndex,const DeepCollectionEquality().hash(options),imagePath);

@override
String toString() {
  return 'FigureOrientationProblem(questionText: $questionText, correctAnswerIndex: $correctAnswerIndex, options: $options, imagePath: $imagePath)';
}


}

/// @nodoc
abstract mixin class $FigureOrientationProblemCopyWith<$Res>  {
  factory $FigureOrientationProblemCopyWith(FigureOrientationProblem value, $Res Function(FigureOrientationProblem) _then) = _$FigureOrientationProblemCopyWithImpl;
@useResult
$Res call({
 String questionText, int correctAnswerIndex, List<FigureOrientationOption> options, String imagePath
});




}
/// @nodoc
class _$FigureOrientationProblemCopyWithImpl<$Res>
    implements $FigureOrientationProblemCopyWith<$Res> {
  _$FigureOrientationProblemCopyWithImpl(this._self, this._then);

  final FigureOrientationProblem _self;
  final $Res Function(FigureOrientationProblem) _then;

/// Create a copy of FigureOrientationProblem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionText = null,Object? correctAnswerIndex = null,Object? options = null,Object? imagePath = null,}) {
  return _then(_self.copyWith(
questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,correctAnswerIndex: null == correctAnswerIndex ? _self.correctAnswerIndex : correctAnswerIndex // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<FigureOrientationOption>,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FigureOrientationProblem].
extension FigureOrientationProblemPatterns on FigureOrientationProblem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FigureOrientationProblem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FigureOrientationProblem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FigureOrientationProblem value)  $default,){
final _that = this;
switch (_that) {
case _FigureOrientationProblem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FigureOrientationProblem value)?  $default,){
final _that = this;
switch (_that) {
case _FigureOrientationProblem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String questionText,  int correctAnswerIndex,  List<FigureOrientationOption> options,  String imagePath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FigureOrientationProblem() when $default != null:
return $default(_that.questionText,_that.correctAnswerIndex,_that.options,_that.imagePath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String questionText,  int correctAnswerIndex,  List<FigureOrientationOption> options,  String imagePath)  $default,) {final _that = this;
switch (_that) {
case _FigureOrientationProblem():
return $default(_that.questionText,_that.correctAnswerIndex,_that.options,_that.imagePath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String questionText,  int correctAnswerIndex,  List<FigureOrientationOption> options,  String imagePath)?  $default,) {final _that = this;
switch (_that) {
case _FigureOrientationProblem() when $default != null:
return $default(_that.questionText,_that.correctAnswerIndex,_that.options,_that.imagePath);case _:
  return null;

}
}

}

/// @nodoc


class _FigureOrientationProblem implements FigureOrientationProblem {
  const _FigureOrientationProblem({required this.questionText, required this.correctAnswerIndex, required final  List<FigureOrientationOption> options, required this.imagePath}): _options = options;
  

@override final  String questionText;
@override final  int correctAnswerIndex;
 final  List<FigureOrientationOption> _options;
@override List<FigureOrientationOption> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override final  String imagePath;

/// Create a copy of FigureOrientationProblem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FigureOrientationProblemCopyWith<_FigureOrientationProblem> get copyWith => __$FigureOrientationProblemCopyWithImpl<_FigureOrientationProblem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FigureOrientationProblem&&(identical(other.questionText, questionText) || other.questionText == questionText)&&(identical(other.correctAnswerIndex, correctAnswerIndex) || other.correctAnswerIndex == correctAnswerIndex)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath));
}


@override
int get hashCode => Object.hash(runtimeType,questionText,correctAnswerIndex,const DeepCollectionEquality().hash(_options),imagePath);

@override
String toString() {
  return 'FigureOrientationProblem(questionText: $questionText, correctAnswerIndex: $correctAnswerIndex, options: $options, imagePath: $imagePath)';
}


}

/// @nodoc
abstract mixin class _$FigureOrientationProblemCopyWith<$Res> implements $FigureOrientationProblemCopyWith<$Res> {
  factory _$FigureOrientationProblemCopyWith(_FigureOrientationProblem value, $Res Function(_FigureOrientationProblem) _then) = __$FigureOrientationProblemCopyWithImpl;
@override @useResult
$Res call({
 String questionText, int correctAnswerIndex, List<FigureOrientationOption> options, String imagePath
});




}
/// @nodoc
class __$FigureOrientationProblemCopyWithImpl<$Res>
    implements _$FigureOrientationProblemCopyWith<$Res> {
  __$FigureOrientationProblemCopyWithImpl(this._self, this._then);

  final _FigureOrientationProblem _self;
  final $Res Function(_FigureOrientationProblem) _then;

/// Create a copy of FigureOrientationProblem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionText = null,Object? correctAnswerIndex = null,Object? options = null,Object? imagePath = null,}) {
  return _then(_FigureOrientationProblem(
questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,correctAnswerIndex: null == correctAnswerIndex ? _self.correctAnswerIndex : correctAnswerIndex // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<FigureOrientationOption>,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$FigureOrientationOption {

 String get imagePath; FigureTransform get transform; bool get isCorrect;
/// Create a copy of FigureOrientationOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FigureOrientationOptionCopyWith<FigureOrientationOption> get copyWith => _$FigureOrientationOptionCopyWithImpl<FigureOrientationOption>(this as FigureOrientationOption, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FigureOrientationOption&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.transform, transform) || other.transform == transform)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect));
}


@override
int get hashCode => Object.hash(runtimeType,imagePath,transform,isCorrect);

@override
String toString() {
  return 'FigureOrientationOption(imagePath: $imagePath, transform: $transform, isCorrect: $isCorrect)';
}


}

/// @nodoc
abstract mixin class $FigureOrientationOptionCopyWith<$Res>  {
  factory $FigureOrientationOptionCopyWith(FigureOrientationOption value, $Res Function(FigureOrientationOption) _then) = _$FigureOrientationOptionCopyWithImpl;
@useResult
$Res call({
 String imagePath, FigureTransform transform, bool isCorrect
});




}
/// @nodoc
class _$FigureOrientationOptionCopyWithImpl<$Res>
    implements $FigureOrientationOptionCopyWith<$Res> {
  _$FigureOrientationOptionCopyWithImpl(this._self, this._then);

  final FigureOrientationOption _self;
  final $Res Function(FigureOrientationOption) _then;

/// Create a copy of FigureOrientationOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imagePath = null,Object? transform = null,Object? isCorrect = null,}) {
  return _then(_self.copyWith(
imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,transform: null == transform ? _self.transform : transform // ignore: cast_nullable_to_non_nullable
as FigureTransform,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FigureOrientationOption].
extension FigureOrientationOptionPatterns on FigureOrientationOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FigureOrientationOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FigureOrientationOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FigureOrientationOption value)  $default,){
final _that = this;
switch (_that) {
case _FigureOrientationOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FigureOrientationOption value)?  $default,){
final _that = this;
switch (_that) {
case _FigureOrientationOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String imagePath,  FigureTransform transform,  bool isCorrect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FigureOrientationOption() when $default != null:
return $default(_that.imagePath,_that.transform,_that.isCorrect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String imagePath,  FigureTransform transform,  bool isCorrect)  $default,) {final _that = this;
switch (_that) {
case _FigureOrientationOption():
return $default(_that.imagePath,_that.transform,_that.isCorrect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String imagePath,  FigureTransform transform,  bool isCorrect)?  $default,) {final _that = this;
switch (_that) {
case _FigureOrientationOption() when $default != null:
return $default(_that.imagePath,_that.transform,_that.isCorrect);case _:
  return null;

}
}

}

/// @nodoc


class _FigureOrientationOption implements FigureOrientationOption {
  const _FigureOrientationOption({required this.imagePath, required this.transform, required this.isCorrect});
  

@override final  String imagePath;
@override final  FigureTransform transform;
@override final  bool isCorrect;

/// Create a copy of FigureOrientationOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FigureOrientationOptionCopyWith<_FigureOrientationOption> get copyWith => __$FigureOrientationOptionCopyWithImpl<_FigureOrientationOption>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FigureOrientationOption&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.transform, transform) || other.transform == transform)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect));
}


@override
int get hashCode => Object.hash(runtimeType,imagePath,transform,isCorrect);

@override
String toString() {
  return 'FigureOrientationOption(imagePath: $imagePath, transform: $transform, isCorrect: $isCorrect)';
}


}

/// @nodoc
abstract mixin class _$FigureOrientationOptionCopyWith<$Res> implements $FigureOrientationOptionCopyWith<$Res> {
  factory _$FigureOrientationOptionCopyWith(_FigureOrientationOption value, $Res Function(_FigureOrientationOption) _then) = __$FigureOrientationOptionCopyWithImpl;
@override @useResult
$Res call({
 String imagePath, FigureTransform transform, bool isCorrect
});




}
/// @nodoc
class __$FigureOrientationOptionCopyWithImpl<$Res>
    implements _$FigureOrientationOptionCopyWith<$Res> {
  __$FigureOrientationOptionCopyWithImpl(this._self, this._then);

  final _FigureOrientationOption _self;
  final $Res Function(_FigureOrientationOption) _then;

/// Create a copy of FigureOrientationOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imagePath = null,Object? transform = null,Object? isCorrect = null,}) {
  return _then(_FigureOrientationOption(
imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,transform: null == transform ? _self.transform : transform // ignore: cast_nullable_to_non_nullable
as FigureTransform,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$FigureOrientationSession {

 int get index; int get total; List<bool?> get results; FigureOrientationProblem? get currentProblem; int get wrongAnswers;
/// Create a copy of FigureOrientationSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FigureOrientationSessionCopyWith<FigureOrientationSession> get copyWith => _$FigureOrientationSessionCopyWithImpl<FigureOrientationSession>(this as FigureOrientationSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FigureOrientationSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&(identical(other.wrongAnswers, wrongAnswers) || other.wrongAnswers == wrongAnswers));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(results),currentProblem,wrongAnswers);

@override
String toString() {
  return 'FigureOrientationSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, wrongAnswers: $wrongAnswers)';
}


}

/// @nodoc
abstract mixin class $FigureOrientationSessionCopyWith<$Res>  {
  factory $FigureOrientationSessionCopyWith(FigureOrientationSession value, $Res Function(FigureOrientationSession) _then) = _$FigureOrientationSessionCopyWithImpl;
@useResult
$Res call({
 int index, int total, List<bool?> results, FigureOrientationProblem? currentProblem, int wrongAnswers
});


$FigureOrientationProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class _$FigureOrientationSessionCopyWithImpl<$Res>
    implements $FigureOrientationSessionCopyWith<$Res> {
  _$FigureOrientationSessionCopyWithImpl(this._self, this._then);

  final FigureOrientationSession _self;
  final $Res Function(FigureOrientationSession) _then;

/// Create a copy of FigureOrientationSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? wrongAnswers = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as FigureOrientationProblem?,wrongAnswers: null == wrongAnswers ? _self.wrongAnswers : wrongAnswers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of FigureOrientationSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FigureOrientationProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $FigureOrientationProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}


/// Adds pattern-matching-related methods to [FigureOrientationSession].
extension FigureOrientationSessionPatterns on FigureOrientationSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FigureOrientationSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FigureOrientationSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FigureOrientationSession value)  $default,){
final _that = this;
switch (_that) {
case _FigureOrientationSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FigureOrientationSession value)?  $default,){
final _that = this;
switch (_that) {
case _FigureOrientationSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  FigureOrientationProblem? currentProblem,  int wrongAnswers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FigureOrientationSession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAnswers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  FigureOrientationProblem? currentProblem,  int wrongAnswers)  $default,) {final _that = this;
switch (_that) {
case _FigureOrientationSession():
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAnswers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  int total,  List<bool?> results,  FigureOrientationProblem? currentProblem,  int wrongAnswers)?  $default,) {final _that = this;
switch (_that) {
case _FigureOrientationSession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAnswers);case _:
  return null;

}
}

}

/// @nodoc


class _FigureOrientationSession extends FigureOrientationSession {
  const _FigureOrientationSession({required this.index, required this.total, required final  List<bool?> results, this.currentProblem, this.wrongAnswers = 0}): _results = results,super._();
  

@override final  int index;
@override final  int total;
 final  List<bool?> _results;
@override List<bool?> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override final  FigureOrientationProblem? currentProblem;
@override@JsonKey() final  int wrongAnswers;

/// Create a copy of FigureOrientationSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FigureOrientationSessionCopyWith<_FigureOrientationSession> get copyWith => __$FigureOrientationSessionCopyWithImpl<_FigureOrientationSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FigureOrientationSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&(identical(other.wrongAnswers, wrongAnswers) || other.wrongAnswers == wrongAnswers));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(_results),currentProblem,wrongAnswers);

@override
String toString() {
  return 'FigureOrientationSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, wrongAnswers: $wrongAnswers)';
}


}

/// @nodoc
abstract mixin class _$FigureOrientationSessionCopyWith<$Res> implements $FigureOrientationSessionCopyWith<$Res> {
  factory _$FigureOrientationSessionCopyWith(_FigureOrientationSession value, $Res Function(_FigureOrientationSession) _then) = __$FigureOrientationSessionCopyWithImpl;
@override @useResult
$Res call({
 int index, int total, List<bool?> results, FigureOrientationProblem? currentProblem, int wrongAnswers
});


@override $FigureOrientationProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class __$FigureOrientationSessionCopyWithImpl<$Res>
    implements _$FigureOrientationSessionCopyWith<$Res> {
  __$FigureOrientationSessionCopyWithImpl(this._self, this._then);

  final _FigureOrientationSession _self;
  final $Res Function(_FigureOrientationSession) _then;

/// Create a copy of FigureOrientationSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? wrongAnswers = null,}) {
  return _then(_FigureOrientationSession(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as FigureOrientationProblem?,wrongAnswers: null == wrongAnswers ? _self.wrongAnswers : wrongAnswers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of FigureOrientationSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FigureOrientationProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $FigureOrientationProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}

/// @nodoc
mixin _$FigureOrientationState {

 CommonGamePhase get phase; FigureOrientationSettings? get settings; FigureOrientationSession? get session; AnswerResult? get lastResult; int get epoch;
/// Create a copy of FigureOrientationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FigureOrientationStateCopyWith<FigureOrientationState> get copyWith => _$FigureOrientationStateCopyWithImpl<FigureOrientationState>(this as FigureOrientationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FigureOrientationState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.lastResult, lastResult) || other.lastResult == lastResult)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,lastResult,epoch);

@override
String toString() {
  return 'FigureOrientationState(phase: $phase, settings: $settings, session: $session, lastResult: $lastResult, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class $FigureOrientationStateCopyWith<$Res>  {
  factory $FigureOrientationStateCopyWith(FigureOrientationState value, $Res Function(FigureOrientationState) _then) = _$FigureOrientationStateCopyWithImpl;
@useResult
$Res call({
 CommonGamePhase phase, FigureOrientationSettings? settings, FigureOrientationSession? session, AnswerResult? lastResult, int epoch
});


$FigureOrientationSettingsCopyWith<$Res>? get settings;$FigureOrientationSessionCopyWith<$Res>? get session;$AnswerResultCopyWith<$Res>? get lastResult;

}
/// @nodoc
class _$FigureOrientationStateCopyWithImpl<$Res>
    implements $FigureOrientationStateCopyWith<$Res> {
  _$FigureOrientationStateCopyWithImpl(this._self, this._then);

  final FigureOrientationState _self;
  final $Res Function(FigureOrientationState) _then;

/// Create a copy of FigureOrientationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? lastResult = freezed,Object? epoch = null,}) {
  return _then(_self.copyWith(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as FigureOrientationSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as FigureOrientationSession?,lastResult: freezed == lastResult ? _self.lastResult : lastResult // ignore: cast_nullable_to_non_nullable
as AnswerResult?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of FigureOrientationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FigureOrientationSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $FigureOrientationSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of FigureOrientationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FigureOrientationSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $FigureOrientationSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of FigureOrientationState
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


/// Adds pattern-matching-related methods to [FigureOrientationState].
extension FigureOrientationStatePatterns on FigureOrientationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FigureOrientationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FigureOrientationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FigureOrientationState value)  $default,){
final _that = this;
switch (_that) {
case _FigureOrientationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FigureOrientationState value)?  $default,){
final _that = this;
switch (_that) {
case _FigureOrientationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CommonGamePhase phase,  FigureOrientationSettings? settings,  FigureOrientationSession? session,  AnswerResult? lastResult,  int epoch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FigureOrientationState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CommonGamePhase phase,  FigureOrientationSettings? settings,  FigureOrientationSession? session,  AnswerResult? lastResult,  int epoch)  $default,) {final _that = this;
switch (_that) {
case _FigureOrientationState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CommonGamePhase phase,  FigureOrientationSettings? settings,  FigureOrientationSession? session,  AnswerResult? lastResult,  int epoch)?  $default,) {final _that = this;
switch (_that) {
case _FigureOrientationState() when $default != null:
return $default(_that.phase,_that.settings,_that.session,_that.lastResult,_that.epoch);case _:
  return null;

}
}

}

/// @nodoc


class _FigureOrientationState extends FigureOrientationState {
  const _FigureOrientationState({this.phase = CommonGamePhase.ready, this.settings, this.session, this.lastResult, this.epoch = 0}): super._();
  

@override@JsonKey() final  CommonGamePhase phase;
@override final  FigureOrientationSettings? settings;
@override final  FigureOrientationSession? session;
@override final  AnswerResult? lastResult;
@override@JsonKey() final  int epoch;

/// Create a copy of FigureOrientationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FigureOrientationStateCopyWith<_FigureOrientationState> get copyWith => __$FigureOrientationStateCopyWithImpl<_FigureOrientationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FigureOrientationState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.lastResult, lastResult) || other.lastResult == lastResult)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,lastResult,epoch);

@override
String toString() {
  return 'FigureOrientationState(phase: $phase, settings: $settings, session: $session, lastResult: $lastResult, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class _$FigureOrientationStateCopyWith<$Res> implements $FigureOrientationStateCopyWith<$Res> {
  factory _$FigureOrientationStateCopyWith(_FigureOrientationState value, $Res Function(_FigureOrientationState) _then) = __$FigureOrientationStateCopyWithImpl;
@override @useResult
$Res call({
 CommonGamePhase phase, FigureOrientationSettings? settings, FigureOrientationSession? session, AnswerResult? lastResult, int epoch
});


@override $FigureOrientationSettingsCopyWith<$Res>? get settings;@override $FigureOrientationSessionCopyWith<$Res>? get session;@override $AnswerResultCopyWith<$Res>? get lastResult;

}
/// @nodoc
class __$FigureOrientationStateCopyWithImpl<$Res>
    implements _$FigureOrientationStateCopyWith<$Res> {
  __$FigureOrientationStateCopyWithImpl(this._self, this._then);

  final _FigureOrientationState _self;
  final $Res Function(_FigureOrientationState) _then;

/// Create a copy of FigureOrientationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? lastResult = freezed,Object? epoch = null,}) {
  return _then(_FigureOrientationState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as FigureOrientationSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as FigureOrientationSession?,lastResult: freezed == lastResult ? _self.lastResult : lastResult // ignore: cast_nullable_to_non_nullable
as AnswerResult?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of FigureOrientationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FigureOrientationSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $FigureOrientationSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of FigureOrientationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FigureOrientationSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $FigureOrientationSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of FigureOrientationState
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

// dart format on
