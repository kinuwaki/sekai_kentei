// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsumiki_counting_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
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
mixin _$TsumikiCountingSettings {

 TsumikiCountingRange get range; TsumikiCountingMode get mode; int get questionCount;
/// Create a copy of TsumikiCountingSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsumikiCountingSettingsCopyWith<TsumikiCountingSettings> get copyWith => _$TsumikiCountingSettingsCopyWithImpl<TsumikiCountingSettings>(this as TsumikiCountingSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsumikiCountingSettings&&(identical(other.range, range) || other.range == range)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount));
}


@override
int get hashCode => Object.hash(runtimeType,range,mode,questionCount);

@override
String toString() {
  return 'TsumikiCountingSettings(range: $range, mode: $mode, questionCount: $questionCount)';
}


}

/// @nodoc
abstract mixin class $TsumikiCountingSettingsCopyWith<$Res>  {
  factory $TsumikiCountingSettingsCopyWith(TsumikiCountingSettings value, $Res Function(TsumikiCountingSettings) _then) = _$TsumikiCountingSettingsCopyWithImpl;
@useResult
$Res call({
 TsumikiCountingRange range, TsumikiCountingMode mode, int questionCount
});




}
/// @nodoc
class _$TsumikiCountingSettingsCopyWithImpl<$Res>
    implements $TsumikiCountingSettingsCopyWith<$Res> {
  _$TsumikiCountingSettingsCopyWithImpl(this._self, this._then);

  final TsumikiCountingSettings _self;
  final $Res Function(TsumikiCountingSettings) _then;

/// Create a copy of TsumikiCountingSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? range = null,Object? mode = null,Object? questionCount = null,}) {
  return _then(_self.copyWith(
range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as TsumikiCountingRange,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as TsumikiCountingMode,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TsumikiCountingSettings].
extension TsumikiCountingSettingsPatterns on TsumikiCountingSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsumikiCountingSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsumikiCountingSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsumikiCountingSettings value)  $default,){
final _that = this;
switch (_that) {
case _TsumikiCountingSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsumikiCountingSettings value)?  $default,){
final _that = this;
switch (_that) {
case _TsumikiCountingSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TsumikiCountingRange range,  TsumikiCountingMode mode,  int questionCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsumikiCountingSettings() when $default != null:
return $default(_that.range,_that.mode,_that.questionCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TsumikiCountingRange range,  TsumikiCountingMode mode,  int questionCount)  $default,) {final _that = this;
switch (_that) {
case _TsumikiCountingSettings():
return $default(_that.range,_that.mode,_that.questionCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TsumikiCountingRange range,  TsumikiCountingMode mode,  int questionCount)?  $default,) {final _that = this;
switch (_that) {
case _TsumikiCountingSettings() when $default != null:
return $default(_that.range,_that.mode,_that.questionCount);case _:
  return null;

}
}

}

/// @nodoc


class _TsumikiCountingSettings extends TsumikiCountingSettings {
  const _TsumikiCountingSettings({this.range = TsumikiCountingRange.oneToThree, this.mode = TsumikiCountingMode.imageToNumber, this.questionCount = 5}): super._();
  

@override@JsonKey() final  TsumikiCountingRange range;
@override@JsonKey() final  TsumikiCountingMode mode;
@override@JsonKey() final  int questionCount;

/// Create a copy of TsumikiCountingSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsumikiCountingSettingsCopyWith<_TsumikiCountingSettings> get copyWith => __$TsumikiCountingSettingsCopyWithImpl<_TsumikiCountingSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsumikiCountingSettings&&(identical(other.range, range) || other.range == range)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount));
}


@override
int get hashCode => Object.hash(runtimeType,range,mode,questionCount);

@override
String toString() {
  return 'TsumikiCountingSettings(range: $range, mode: $mode, questionCount: $questionCount)';
}


}

/// @nodoc
abstract mixin class _$TsumikiCountingSettingsCopyWith<$Res> implements $TsumikiCountingSettingsCopyWith<$Res> {
  factory _$TsumikiCountingSettingsCopyWith(_TsumikiCountingSettings value, $Res Function(_TsumikiCountingSettings) _then) = __$TsumikiCountingSettingsCopyWithImpl;
@override @useResult
$Res call({
 TsumikiCountingRange range, TsumikiCountingMode mode, int questionCount
});




}
/// @nodoc
class __$TsumikiCountingSettingsCopyWithImpl<$Res>
    implements _$TsumikiCountingSettingsCopyWith<$Res> {
  __$TsumikiCountingSettingsCopyWithImpl(this._self, this._then);

  final _TsumikiCountingSettings _self;
  final $Res Function(_TsumikiCountingSettings) _then;

/// Create a copy of TsumikiCountingSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? range = null,Object? mode = null,Object? questionCount = null,}) {
  return _then(_TsumikiCountingSettings(
range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as TsumikiCountingRange,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as TsumikiCountingMode,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$TsumikiCountingProblem {

 String get questionText;// TTS用の質問文
 int get correctAnswerIndex;// 正解のインデックス
 List<String> get options;// 選択肢（画像パスまたは数字文字列）
 TsumikiCountingMode get mode;// 問題のモード
 int get blockCount;// 正しいブロック数
 String? get imagePath;
/// Create a copy of TsumikiCountingProblem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsumikiCountingProblemCopyWith<TsumikiCountingProblem> get copyWith => _$TsumikiCountingProblemCopyWithImpl<TsumikiCountingProblem>(this as TsumikiCountingProblem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsumikiCountingProblem&&(identical(other.questionText, questionText) || other.questionText == questionText)&&(identical(other.correctAnswerIndex, correctAnswerIndex) || other.correctAnswerIndex == correctAnswerIndex)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.blockCount, blockCount) || other.blockCount == blockCount)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath));
}


@override
int get hashCode => Object.hash(runtimeType,questionText,correctAnswerIndex,const DeepCollectionEquality().hash(options),mode,blockCount,imagePath);

@override
String toString() {
  return 'TsumikiCountingProblem(questionText: $questionText, correctAnswerIndex: $correctAnswerIndex, options: $options, mode: $mode, blockCount: $blockCount, imagePath: $imagePath)';
}


}

/// @nodoc
abstract mixin class $TsumikiCountingProblemCopyWith<$Res>  {
  factory $TsumikiCountingProblemCopyWith(TsumikiCountingProblem value, $Res Function(TsumikiCountingProblem) _then) = _$TsumikiCountingProblemCopyWithImpl;
@useResult
$Res call({
 String questionText, int correctAnswerIndex, List<String> options, TsumikiCountingMode mode, int blockCount, String? imagePath
});




}
/// @nodoc
class _$TsumikiCountingProblemCopyWithImpl<$Res>
    implements $TsumikiCountingProblemCopyWith<$Res> {
  _$TsumikiCountingProblemCopyWithImpl(this._self, this._then);

  final TsumikiCountingProblem _self;
  final $Res Function(TsumikiCountingProblem) _then;

/// Create a copy of TsumikiCountingProblem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionText = null,Object? correctAnswerIndex = null,Object? options = null,Object? mode = null,Object? blockCount = null,Object? imagePath = freezed,}) {
  return _then(_self.copyWith(
questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,correctAnswerIndex: null == correctAnswerIndex ? _self.correctAnswerIndex : correctAnswerIndex // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as TsumikiCountingMode,blockCount: null == blockCount ? _self.blockCount : blockCount // ignore: cast_nullable_to_non_nullable
as int,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TsumikiCountingProblem].
extension TsumikiCountingProblemPatterns on TsumikiCountingProblem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsumikiCountingProblem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsumikiCountingProblem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsumikiCountingProblem value)  $default,){
final _that = this;
switch (_that) {
case _TsumikiCountingProblem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsumikiCountingProblem value)?  $default,){
final _that = this;
switch (_that) {
case _TsumikiCountingProblem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String questionText,  int correctAnswerIndex,  List<String> options,  TsumikiCountingMode mode,  int blockCount,  String? imagePath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsumikiCountingProblem() when $default != null:
return $default(_that.questionText,_that.correctAnswerIndex,_that.options,_that.mode,_that.blockCount,_that.imagePath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String questionText,  int correctAnswerIndex,  List<String> options,  TsumikiCountingMode mode,  int blockCount,  String? imagePath)  $default,) {final _that = this;
switch (_that) {
case _TsumikiCountingProblem():
return $default(_that.questionText,_that.correctAnswerIndex,_that.options,_that.mode,_that.blockCount,_that.imagePath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String questionText,  int correctAnswerIndex,  List<String> options,  TsumikiCountingMode mode,  int blockCount,  String? imagePath)?  $default,) {final _that = this;
switch (_that) {
case _TsumikiCountingProblem() when $default != null:
return $default(_that.questionText,_that.correctAnswerIndex,_that.options,_that.mode,_that.blockCount,_that.imagePath);case _:
  return null;

}
}

}

/// @nodoc


class _TsumikiCountingProblem extends TsumikiCountingProblem {
  const _TsumikiCountingProblem({required this.questionText, required this.correctAnswerIndex, required final  List<String> options, required this.mode, required this.blockCount, this.imagePath}): _options = options,super._();
  

@override final  String questionText;
// TTS用の質問文
@override final  int correctAnswerIndex;
// 正解のインデックス
 final  List<String> _options;
// 正解のインデックス
@override List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

// 選択肢（画像パスまたは数字文字列）
@override final  TsumikiCountingMode mode;
// 問題のモード
@override final  int blockCount;
// 正しいブロック数
@override final  String? imagePath;

/// Create a copy of TsumikiCountingProblem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsumikiCountingProblemCopyWith<_TsumikiCountingProblem> get copyWith => __$TsumikiCountingProblemCopyWithImpl<_TsumikiCountingProblem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsumikiCountingProblem&&(identical(other.questionText, questionText) || other.questionText == questionText)&&(identical(other.correctAnswerIndex, correctAnswerIndex) || other.correctAnswerIndex == correctAnswerIndex)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.blockCount, blockCount) || other.blockCount == blockCount)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath));
}


@override
int get hashCode => Object.hash(runtimeType,questionText,correctAnswerIndex,const DeepCollectionEquality().hash(_options),mode,blockCount,imagePath);

@override
String toString() {
  return 'TsumikiCountingProblem(questionText: $questionText, correctAnswerIndex: $correctAnswerIndex, options: $options, mode: $mode, blockCount: $blockCount, imagePath: $imagePath)';
}


}

/// @nodoc
abstract mixin class _$TsumikiCountingProblemCopyWith<$Res> implements $TsumikiCountingProblemCopyWith<$Res> {
  factory _$TsumikiCountingProblemCopyWith(_TsumikiCountingProblem value, $Res Function(_TsumikiCountingProblem) _then) = __$TsumikiCountingProblemCopyWithImpl;
@override @useResult
$Res call({
 String questionText, int correctAnswerIndex, List<String> options, TsumikiCountingMode mode, int blockCount, String? imagePath
});




}
/// @nodoc
class __$TsumikiCountingProblemCopyWithImpl<$Res>
    implements _$TsumikiCountingProblemCopyWith<$Res> {
  __$TsumikiCountingProblemCopyWithImpl(this._self, this._then);

  final _TsumikiCountingProblem _self;
  final $Res Function(_TsumikiCountingProblem) _then;

/// Create a copy of TsumikiCountingProblem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionText = null,Object? correctAnswerIndex = null,Object? options = null,Object? mode = null,Object? blockCount = null,Object? imagePath = freezed,}) {
  return _then(_TsumikiCountingProblem(
questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,correctAnswerIndex: null == correctAnswerIndex ? _self.correctAnswerIndex : correctAnswerIndex // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as TsumikiCountingMode,blockCount: null == blockCount ? _self.blockCount : blockCount // ignore: cast_nullable_to_non_nullable
as int,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$TsumikiCountingSession {

 int get index;// 現在の問題番号 (0-based)
 int get total;// 総問題数
 List<bool?> get results;// 結果配列（null=未回答, bool=完璧/不完璧）
 TsumikiCountingProblem? get currentProblem; int get wrongAnswers;
/// Create a copy of TsumikiCountingSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsumikiCountingSessionCopyWith<TsumikiCountingSession> get copyWith => _$TsumikiCountingSessionCopyWithImpl<TsumikiCountingSession>(this as TsumikiCountingSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsumikiCountingSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&(identical(other.wrongAnswers, wrongAnswers) || other.wrongAnswers == wrongAnswers));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(results),currentProblem,wrongAnswers);

@override
String toString() {
  return 'TsumikiCountingSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, wrongAnswers: $wrongAnswers)';
}


}

/// @nodoc
abstract mixin class $TsumikiCountingSessionCopyWith<$Res>  {
  factory $TsumikiCountingSessionCopyWith(TsumikiCountingSession value, $Res Function(TsumikiCountingSession) _then) = _$TsumikiCountingSessionCopyWithImpl;
@useResult
$Res call({
 int index, int total, List<bool?> results, TsumikiCountingProblem? currentProblem, int wrongAnswers
});


$TsumikiCountingProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class _$TsumikiCountingSessionCopyWithImpl<$Res>
    implements $TsumikiCountingSessionCopyWith<$Res> {
  _$TsumikiCountingSessionCopyWithImpl(this._self, this._then);

  final TsumikiCountingSession _self;
  final $Res Function(TsumikiCountingSession) _then;

/// Create a copy of TsumikiCountingSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? wrongAnswers = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as TsumikiCountingProblem?,wrongAnswers: null == wrongAnswers ? _self.wrongAnswers : wrongAnswers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of TsumikiCountingSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsumikiCountingProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $TsumikiCountingProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsumikiCountingSession].
extension TsumikiCountingSessionPatterns on TsumikiCountingSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsumikiCountingSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsumikiCountingSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsumikiCountingSession value)  $default,){
final _that = this;
switch (_that) {
case _TsumikiCountingSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsumikiCountingSession value)?  $default,){
final _that = this;
switch (_that) {
case _TsumikiCountingSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  TsumikiCountingProblem? currentProblem,  int wrongAnswers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsumikiCountingSession() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  TsumikiCountingProblem? currentProblem,  int wrongAnswers)  $default,) {final _that = this;
switch (_that) {
case _TsumikiCountingSession():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  int total,  List<bool?> results,  TsumikiCountingProblem? currentProblem,  int wrongAnswers)?  $default,) {final _that = this;
switch (_that) {
case _TsumikiCountingSession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAnswers);case _:
  return null;

}
}

}

/// @nodoc


class _TsumikiCountingSession extends TsumikiCountingSession {
  const _TsumikiCountingSession({required this.index, required this.total, required final  List<bool?> results, this.currentProblem, this.wrongAnswers = 0}): _results = results,super._();
  

@override final  int index;
// 現在の問題番号 (0-based)
@override final  int total;
// 総問題数
 final  List<bool?> _results;
// 総問題数
@override List<bool?> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

// 結果配列（null=未回答, bool=完璧/不完璧）
@override final  TsumikiCountingProblem? currentProblem;
@override@JsonKey() final  int wrongAnswers;

/// Create a copy of TsumikiCountingSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsumikiCountingSessionCopyWith<_TsumikiCountingSession> get copyWith => __$TsumikiCountingSessionCopyWithImpl<_TsumikiCountingSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsumikiCountingSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&(identical(other.wrongAnswers, wrongAnswers) || other.wrongAnswers == wrongAnswers));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(_results),currentProblem,wrongAnswers);

@override
String toString() {
  return 'TsumikiCountingSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, wrongAnswers: $wrongAnswers)';
}


}

/// @nodoc
abstract mixin class _$TsumikiCountingSessionCopyWith<$Res> implements $TsumikiCountingSessionCopyWith<$Res> {
  factory _$TsumikiCountingSessionCopyWith(_TsumikiCountingSession value, $Res Function(_TsumikiCountingSession) _then) = __$TsumikiCountingSessionCopyWithImpl;
@override @useResult
$Res call({
 int index, int total, List<bool?> results, TsumikiCountingProblem? currentProblem, int wrongAnswers
});


@override $TsumikiCountingProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class __$TsumikiCountingSessionCopyWithImpl<$Res>
    implements _$TsumikiCountingSessionCopyWith<$Res> {
  __$TsumikiCountingSessionCopyWithImpl(this._self, this._then);

  final _TsumikiCountingSession _self;
  final $Res Function(_TsumikiCountingSession) _then;

/// Create a copy of TsumikiCountingSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? wrongAnswers = null,}) {
  return _then(_TsumikiCountingSession(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as TsumikiCountingProblem?,wrongAnswers: null == wrongAnswers ? _self.wrongAnswers : wrongAnswers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of TsumikiCountingSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsumikiCountingProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $TsumikiCountingProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}

/// @nodoc
mixin _$TsumikiCountingState {

 CommonGamePhase get phase; TsumikiCountingSettings? get settings; TsumikiCountingSession? get session; AnswerResult? get lastResult; int get epoch;
/// Create a copy of TsumikiCountingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsumikiCountingStateCopyWith<TsumikiCountingState> get copyWith => _$TsumikiCountingStateCopyWithImpl<TsumikiCountingState>(this as TsumikiCountingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsumikiCountingState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.lastResult, lastResult) || other.lastResult == lastResult)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,lastResult,epoch);

@override
String toString() {
  return 'TsumikiCountingState(phase: $phase, settings: $settings, session: $session, lastResult: $lastResult, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class $TsumikiCountingStateCopyWith<$Res>  {
  factory $TsumikiCountingStateCopyWith(TsumikiCountingState value, $Res Function(TsumikiCountingState) _then) = _$TsumikiCountingStateCopyWithImpl;
@useResult
$Res call({
 CommonGamePhase phase, TsumikiCountingSettings? settings, TsumikiCountingSession? session, AnswerResult? lastResult, int epoch
});


$TsumikiCountingSettingsCopyWith<$Res>? get settings;$TsumikiCountingSessionCopyWith<$Res>? get session;$AnswerResultCopyWith<$Res>? get lastResult;

}
/// @nodoc
class _$TsumikiCountingStateCopyWithImpl<$Res>
    implements $TsumikiCountingStateCopyWith<$Res> {
  _$TsumikiCountingStateCopyWithImpl(this._self, this._then);

  final TsumikiCountingState _self;
  final $Res Function(TsumikiCountingState) _then;

/// Create a copy of TsumikiCountingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? lastResult = freezed,Object? epoch = null,}) {
  return _then(_self.copyWith(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as TsumikiCountingSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as TsumikiCountingSession?,lastResult: freezed == lastResult ? _self.lastResult : lastResult // ignore: cast_nullable_to_non_nullable
as AnswerResult?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of TsumikiCountingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsumikiCountingSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $TsumikiCountingSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of TsumikiCountingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsumikiCountingSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $TsumikiCountingSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of TsumikiCountingState
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


/// Adds pattern-matching-related methods to [TsumikiCountingState].
extension TsumikiCountingStatePatterns on TsumikiCountingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsumikiCountingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsumikiCountingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsumikiCountingState value)  $default,){
final _that = this;
switch (_that) {
case _TsumikiCountingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsumikiCountingState value)?  $default,){
final _that = this;
switch (_that) {
case _TsumikiCountingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CommonGamePhase phase,  TsumikiCountingSettings? settings,  TsumikiCountingSession? session,  AnswerResult? lastResult,  int epoch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsumikiCountingState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CommonGamePhase phase,  TsumikiCountingSettings? settings,  TsumikiCountingSession? session,  AnswerResult? lastResult,  int epoch)  $default,) {final _that = this;
switch (_that) {
case _TsumikiCountingState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CommonGamePhase phase,  TsumikiCountingSettings? settings,  TsumikiCountingSession? session,  AnswerResult? lastResult,  int epoch)?  $default,) {final _that = this;
switch (_that) {
case _TsumikiCountingState() when $default != null:
return $default(_that.phase,_that.settings,_that.session,_that.lastResult,_that.epoch);case _:
  return null;

}
}

}

/// @nodoc


class _TsumikiCountingState extends TsumikiCountingState {
  const _TsumikiCountingState({this.phase = CommonGamePhase.ready, this.settings, this.session, this.lastResult, this.epoch = 0}): super._();
  

@override@JsonKey() final  CommonGamePhase phase;
@override final  TsumikiCountingSettings? settings;
@override final  TsumikiCountingSession? session;
@override final  AnswerResult? lastResult;
@override@JsonKey() final  int epoch;

/// Create a copy of TsumikiCountingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsumikiCountingStateCopyWith<_TsumikiCountingState> get copyWith => __$TsumikiCountingStateCopyWithImpl<_TsumikiCountingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsumikiCountingState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.lastResult, lastResult) || other.lastResult == lastResult)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,lastResult,epoch);

@override
String toString() {
  return 'TsumikiCountingState(phase: $phase, settings: $settings, session: $session, lastResult: $lastResult, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class _$TsumikiCountingStateCopyWith<$Res> implements $TsumikiCountingStateCopyWith<$Res> {
  factory _$TsumikiCountingStateCopyWith(_TsumikiCountingState value, $Res Function(_TsumikiCountingState) _then) = __$TsumikiCountingStateCopyWithImpl;
@override @useResult
$Res call({
 CommonGamePhase phase, TsumikiCountingSettings? settings, TsumikiCountingSession? session, AnswerResult? lastResult, int epoch
});


@override $TsumikiCountingSettingsCopyWith<$Res>? get settings;@override $TsumikiCountingSessionCopyWith<$Res>? get session;@override $AnswerResultCopyWith<$Res>? get lastResult;

}
/// @nodoc
class __$TsumikiCountingStateCopyWithImpl<$Res>
    implements _$TsumikiCountingStateCopyWith<$Res> {
  __$TsumikiCountingStateCopyWithImpl(this._self, this._then);

  final _TsumikiCountingState _self;
  final $Res Function(_TsumikiCountingState) _then;

/// Create a copy of TsumikiCountingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? lastResult = freezed,Object? epoch = null,}) {
  return _then(_TsumikiCountingState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as TsumikiCountingSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as TsumikiCountingSession?,lastResult: freezed == lastResult ? _self.lastResult : lastResult // ignore: cast_nullable_to_non_nullable
as AnswerResult?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of TsumikiCountingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsumikiCountingSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $TsumikiCountingSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of TsumikiCountingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsumikiCountingSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $TsumikiCountingSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of TsumikiCountingState
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
