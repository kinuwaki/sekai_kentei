// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'odd_even_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OddEvenSettings {

 OddEvenType get targetType; OddEvenRange get range; OddEvenGridSize get gridSize; bool get randomTargetType; int get questionCount;
/// Create a copy of OddEvenSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OddEvenSettingsCopyWith<OddEvenSettings> get copyWith => _$OddEvenSettingsCopyWithImpl<OddEvenSettings>(this as OddEvenSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OddEvenSettings&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.range, range) || other.range == range)&&(identical(other.gridSize, gridSize) || other.gridSize == gridSize)&&(identical(other.randomTargetType, randomTargetType) || other.randomTargetType == randomTargetType)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount));
}


@override
int get hashCode => Object.hash(runtimeType,targetType,range,gridSize,randomTargetType,questionCount);

@override
String toString() {
  return 'OddEvenSettings(targetType: $targetType, range: $range, gridSize: $gridSize, randomTargetType: $randomTargetType, questionCount: $questionCount)';
}


}

/// @nodoc
abstract mixin class $OddEvenSettingsCopyWith<$Res>  {
  factory $OddEvenSettingsCopyWith(OddEvenSettings value, $Res Function(OddEvenSettings) _then) = _$OddEvenSettingsCopyWithImpl;
@useResult
$Res call({
 OddEvenType targetType, OddEvenRange range, OddEvenGridSize gridSize, bool randomTargetType, int questionCount
});




}
/// @nodoc
class _$OddEvenSettingsCopyWithImpl<$Res>
    implements $OddEvenSettingsCopyWith<$Res> {
  _$OddEvenSettingsCopyWithImpl(this._self, this._then);

  final OddEvenSettings _self;
  final $Res Function(OddEvenSettings) _then;

/// Create a copy of OddEvenSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? targetType = null,Object? range = null,Object? gridSize = null,Object? randomTargetType = null,Object? questionCount = null,}) {
  return _then(_self.copyWith(
targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as OddEvenType,range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as OddEvenRange,gridSize: null == gridSize ? _self.gridSize : gridSize // ignore: cast_nullable_to_non_nullable
as OddEvenGridSize,randomTargetType: null == randomTargetType ? _self.randomTargetType : randomTargetType // ignore: cast_nullable_to_non_nullable
as bool,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OddEvenSettings].
extension OddEvenSettingsPatterns on OddEvenSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OddEvenSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OddEvenSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OddEvenSettings value)  $default,){
final _that = this;
switch (_that) {
case _OddEvenSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OddEvenSettings value)?  $default,){
final _that = this;
switch (_that) {
case _OddEvenSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OddEvenType targetType,  OddEvenRange range,  OddEvenGridSize gridSize,  bool randomTargetType,  int questionCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OddEvenSettings() when $default != null:
return $default(_that.targetType,_that.range,_that.gridSize,_that.randomTargetType,_that.questionCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OddEvenType targetType,  OddEvenRange range,  OddEvenGridSize gridSize,  bool randomTargetType,  int questionCount)  $default,) {final _that = this;
switch (_that) {
case _OddEvenSettings():
return $default(_that.targetType,_that.range,_that.gridSize,_that.randomTargetType,_that.questionCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OddEvenType targetType,  OddEvenRange range,  OddEvenGridSize gridSize,  bool randomTargetType,  int questionCount)?  $default,) {final _that = this;
switch (_that) {
case _OddEvenSettings() when $default != null:
return $default(_that.targetType,_that.range,_that.gridSize,_that.randomTargetType,_that.questionCount);case _:
  return null;

}
}

}

/// @nodoc


class _OddEvenSettings extends OddEvenSettings {
  const _OddEvenSettings({this.targetType = OddEvenType.odd, this.range = OddEvenRange.range0to9, this.gridSize = OddEvenGridSize.grid10, this.randomTargetType = false, this.questionCount = 3}): super._();
  

@override@JsonKey() final  OddEvenType targetType;
@override@JsonKey() final  OddEvenRange range;
@override@JsonKey() final  OddEvenGridSize gridSize;
@override@JsonKey() final  bool randomTargetType;
@override@JsonKey() final  int questionCount;

/// Create a copy of OddEvenSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OddEvenSettingsCopyWith<_OddEvenSettings> get copyWith => __$OddEvenSettingsCopyWithImpl<_OddEvenSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OddEvenSettings&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.range, range) || other.range == range)&&(identical(other.gridSize, gridSize) || other.gridSize == gridSize)&&(identical(other.randomTargetType, randomTargetType) || other.randomTargetType == randomTargetType)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount));
}


@override
int get hashCode => Object.hash(runtimeType,targetType,range,gridSize,randomTargetType,questionCount);

@override
String toString() {
  return 'OddEvenSettings(targetType: $targetType, range: $range, gridSize: $gridSize, randomTargetType: $randomTargetType, questionCount: $questionCount)';
}


}

/// @nodoc
abstract mixin class _$OddEvenSettingsCopyWith<$Res> implements $OddEvenSettingsCopyWith<$Res> {
  factory _$OddEvenSettingsCopyWith(_OddEvenSettings value, $Res Function(_OddEvenSettings) _then) = __$OddEvenSettingsCopyWithImpl;
@override @useResult
$Res call({
 OddEvenType targetType, OddEvenRange range, OddEvenGridSize gridSize, bool randomTargetType, int questionCount
});




}
/// @nodoc
class __$OddEvenSettingsCopyWithImpl<$Res>
    implements _$OddEvenSettingsCopyWith<$Res> {
  __$OddEvenSettingsCopyWithImpl(this._self, this._then);

  final _OddEvenSettings _self;
  final $Res Function(_OddEvenSettings) _then;

/// Create a copy of OddEvenSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? targetType = null,Object? range = null,Object? gridSize = null,Object? randomTargetType = null,Object? questionCount = null,}) {
  return _then(_OddEvenSettings(
targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as OddEvenType,range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as OddEvenRange,gridSize: null == gridSize ? _self.gridSize : gridSize // ignore: cast_nullable_to_non_nullable
as OddEvenGridSize,randomTargetType: null == randomTargetType ? _self.randomTargetType : randomTargetType // ignore: cast_nullable_to_non_nullable
as bool,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$OddEvenProblem {

 OddEvenType get targetType; List<int> get numbers; Set<int> get correctIndices; String get questionText;
/// Create a copy of OddEvenProblem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OddEvenProblemCopyWith<OddEvenProblem> get copyWith => _$OddEvenProblemCopyWithImpl<OddEvenProblem>(this as OddEvenProblem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OddEvenProblem&&(identical(other.targetType, targetType) || other.targetType == targetType)&&const DeepCollectionEquality().equals(other.numbers, numbers)&&const DeepCollectionEquality().equals(other.correctIndices, correctIndices)&&(identical(other.questionText, questionText) || other.questionText == questionText));
}


@override
int get hashCode => Object.hash(runtimeType,targetType,const DeepCollectionEquality().hash(numbers),const DeepCollectionEquality().hash(correctIndices),questionText);

@override
String toString() {
  return 'OddEvenProblem(targetType: $targetType, numbers: $numbers, correctIndices: $correctIndices, questionText: $questionText)';
}


}

/// @nodoc
abstract mixin class $OddEvenProblemCopyWith<$Res>  {
  factory $OddEvenProblemCopyWith(OddEvenProblem value, $Res Function(OddEvenProblem) _then) = _$OddEvenProblemCopyWithImpl;
@useResult
$Res call({
 OddEvenType targetType, List<int> numbers, Set<int> correctIndices, String questionText
});




}
/// @nodoc
class _$OddEvenProblemCopyWithImpl<$Res>
    implements $OddEvenProblemCopyWith<$Res> {
  _$OddEvenProblemCopyWithImpl(this._self, this._then);

  final OddEvenProblem _self;
  final $Res Function(OddEvenProblem) _then;

/// Create a copy of OddEvenProblem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? targetType = null,Object? numbers = null,Object? correctIndices = null,Object? questionText = null,}) {
  return _then(_self.copyWith(
targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as OddEvenType,numbers: null == numbers ? _self.numbers : numbers // ignore: cast_nullable_to_non_nullable
as List<int>,correctIndices: null == correctIndices ? _self.correctIndices : correctIndices // ignore: cast_nullable_to_non_nullable
as Set<int>,questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OddEvenProblem].
extension OddEvenProblemPatterns on OddEvenProblem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OddEvenProblem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OddEvenProblem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OddEvenProblem value)  $default,){
final _that = this;
switch (_that) {
case _OddEvenProblem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OddEvenProblem value)?  $default,){
final _that = this;
switch (_that) {
case _OddEvenProblem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OddEvenType targetType,  List<int> numbers,  Set<int> correctIndices,  String questionText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OddEvenProblem() when $default != null:
return $default(_that.targetType,_that.numbers,_that.correctIndices,_that.questionText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OddEvenType targetType,  List<int> numbers,  Set<int> correctIndices,  String questionText)  $default,) {final _that = this;
switch (_that) {
case _OddEvenProblem():
return $default(_that.targetType,_that.numbers,_that.correctIndices,_that.questionText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OddEvenType targetType,  List<int> numbers,  Set<int> correctIndices,  String questionText)?  $default,) {final _that = this;
switch (_that) {
case _OddEvenProblem() when $default != null:
return $default(_that.targetType,_that.numbers,_that.correctIndices,_that.questionText);case _:
  return null;

}
}

}

/// @nodoc


class _OddEvenProblem extends OddEvenProblem {
  const _OddEvenProblem({required this.targetType, required final  List<int> numbers, required final  Set<int> correctIndices, required this.questionText}): _numbers = numbers,_correctIndices = correctIndices,super._();
  

@override final  OddEvenType targetType;
 final  List<int> _numbers;
@override List<int> get numbers {
  if (_numbers is EqualUnmodifiableListView) return _numbers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_numbers);
}

 final  Set<int> _correctIndices;
@override Set<int> get correctIndices {
  if (_correctIndices is EqualUnmodifiableSetView) return _correctIndices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_correctIndices);
}

@override final  String questionText;

/// Create a copy of OddEvenProblem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OddEvenProblemCopyWith<_OddEvenProblem> get copyWith => __$OddEvenProblemCopyWithImpl<_OddEvenProblem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OddEvenProblem&&(identical(other.targetType, targetType) || other.targetType == targetType)&&const DeepCollectionEquality().equals(other._numbers, _numbers)&&const DeepCollectionEquality().equals(other._correctIndices, _correctIndices)&&(identical(other.questionText, questionText) || other.questionText == questionText));
}


@override
int get hashCode => Object.hash(runtimeType,targetType,const DeepCollectionEquality().hash(_numbers),const DeepCollectionEquality().hash(_correctIndices),questionText);

@override
String toString() {
  return 'OddEvenProblem(targetType: $targetType, numbers: $numbers, correctIndices: $correctIndices, questionText: $questionText)';
}


}

/// @nodoc
abstract mixin class _$OddEvenProblemCopyWith<$Res> implements $OddEvenProblemCopyWith<$Res> {
  factory _$OddEvenProblemCopyWith(_OddEvenProblem value, $Res Function(_OddEvenProblem) _then) = __$OddEvenProblemCopyWithImpl;
@override @useResult
$Res call({
 OddEvenType targetType, List<int> numbers, Set<int> correctIndices, String questionText
});




}
/// @nodoc
class __$OddEvenProblemCopyWithImpl<$Res>
    implements _$OddEvenProblemCopyWith<$Res> {
  __$OddEvenProblemCopyWithImpl(this._self, this._then);

  final _OddEvenProblem _self;
  final $Res Function(_OddEvenProblem) _then;

/// Create a copy of OddEvenProblem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? targetType = null,Object? numbers = null,Object? correctIndices = null,Object? questionText = null,}) {
  return _then(_OddEvenProblem(
targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as OddEvenType,numbers: null == numbers ? _self._numbers : numbers // ignore: cast_nullable_to_non_nullable
as List<int>,correctIndices: null == correctIndices ? _self._correctIndices : correctIndices // ignore: cast_nullable_to_non_nullable
as Set<int>,questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$OddEvenSession {

 int get index; int get total; List<bool?> get results; OddEvenProblem? get currentProblem; int get wrongAnswers; int get wrongAttempts; Set<int> get selectedIndices; Set<int> get correctlySelectedIndices;// 正解済みの選択
 DateTime? get startedAt; DateTime? get completedAt;
/// Create a copy of OddEvenSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OddEvenSessionCopyWith<OddEvenSession> get copyWith => _$OddEvenSessionCopyWithImpl<OddEvenSession>(this as OddEvenSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OddEvenSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&(identical(other.wrongAnswers, wrongAnswers) || other.wrongAnswers == wrongAnswers)&&(identical(other.wrongAttempts, wrongAttempts) || other.wrongAttempts == wrongAttempts)&&const DeepCollectionEquality().equals(other.selectedIndices, selectedIndices)&&const DeepCollectionEquality().equals(other.correctlySelectedIndices, correctlySelectedIndices)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(results),currentProblem,wrongAnswers,wrongAttempts,const DeepCollectionEquality().hash(selectedIndices),const DeepCollectionEquality().hash(correctlySelectedIndices),startedAt,completedAt);

@override
String toString() {
  return 'OddEvenSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, wrongAnswers: $wrongAnswers, wrongAttempts: $wrongAttempts, selectedIndices: $selectedIndices, correctlySelectedIndices: $correctlySelectedIndices, startedAt: $startedAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $OddEvenSessionCopyWith<$Res>  {
  factory $OddEvenSessionCopyWith(OddEvenSession value, $Res Function(OddEvenSession) _then) = _$OddEvenSessionCopyWithImpl;
@useResult
$Res call({
 int index, int total, List<bool?> results, OddEvenProblem? currentProblem, int wrongAnswers, int wrongAttempts, Set<int> selectedIndices, Set<int> correctlySelectedIndices, DateTime? startedAt, DateTime? completedAt
});


$OddEvenProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class _$OddEvenSessionCopyWithImpl<$Res>
    implements $OddEvenSessionCopyWith<$Res> {
  _$OddEvenSessionCopyWithImpl(this._self, this._then);

  final OddEvenSession _self;
  final $Res Function(OddEvenSession) _then;

/// Create a copy of OddEvenSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? wrongAnswers = null,Object? wrongAttempts = null,Object? selectedIndices = null,Object? correctlySelectedIndices = null,Object? startedAt = freezed,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as OddEvenProblem?,wrongAnswers: null == wrongAnswers ? _self.wrongAnswers : wrongAnswers // ignore: cast_nullable_to_non_nullable
as int,wrongAttempts: null == wrongAttempts ? _self.wrongAttempts : wrongAttempts // ignore: cast_nullable_to_non_nullable
as int,selectedIndices: null == selectedIndices ? _self.selectedIndices : selectedIndices // ignore: cast_nullable_to_non_nullable
as Set<int>,correctlySelectedIndices: null == correctlySelectedIndices ? _self.correctlySelectedIndices : correctlySelectedIndices // ignore: cast_nullable_to_non_nullable
as Set<int>,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of OddEvenSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OddEvenProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $OddEvenProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}


/// Adds pattern-matching-related methods to [OddEvenSession].
extension OddEvenSessionPatterns on OddEvenSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OddEvenSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OddEvenSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OddEvenSession value)  $default,){
final _that = this;
switch (_that) {
case _OddEvenSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OddEvenSession value)?  $default,){
final _that = this;
switch (_that) {
case _OddEvenSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  OddEvenProblem? currentProblem,  int wrongAnswers,  int wrongAttempts,  Set<int> selectedIndices,  Set<int> correctlySelectedIndices,  DateTime? startedAt,  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OddEvenSession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAnswers,_that.wrongAttempts,_that.selectedIndices,_that.correctlySelectedIndices,_that.startedAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  OddEvenProblem? currentProblem,  int wrongAnswers,  int wrongAttempts,  Set<int> selectedIndices,  Set<int> correctlySelectedIndices,  DateTime? startedAt,  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _OddEvenSession():
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAnswers,_that.wrongAttempts,_that.selectedIndices,_that.correctlySelectedIndices,_that.startedAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  int total,  List<bool?> results,  OddEvenProblem? currentProblem,  int wrongAnswers,  int wrongAttempts,  Set<int> selectedIndices,  Set<int> correctlySelectedIndices,  DateTime? startedAt,  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _OddEvenSession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAnswers,_that.wrongAttempts,_that.selectedIndices,_that.correctlySelectedIndices,_that.startedAt,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc


class _OddEvenSession extends OddEvenSession {
  const _OddEvenSession({required this.index, required this.total, required final  List<bool?> results, this.currentProblem, this.wrongAnswers = 0, this.wrongAttempts = 0, final  Set<int> selectedIndices = const {}, final  Set<int> correctlySelectedIndices = const {}, this.startedAt, this.completedAt}): _results = results,_selectedIndices = selectedIndices,_correctlySelectedIndices = correctlySelectedIndices,super._();
  

@override final  int index;
@override final  int total;
 final  List<bool?> _results;
@override List<bool?> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override final  OddEvenProblem? currentProblem;
@override@JsonKey() final  int wrongAnswers;
@override@JsonKey() final  int wrongAttempts;
 final  Set<int> _selectedIndices;
@override@JsonKey() Set<int> get selectedIndices {
  if (_selectedIndices is EqualUnmodifiableSetView) return _selectedIndices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedIndices);
}

 final  Set<int> _correctlySelectedIndices;
@override@JsonKey() Set<int> get correctlySelectedIndices {
  if (_correctlySelectedIndices is EqualUnmodifiableSetView) return _correctlySelectedIndices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_correctlySelectedIndices);
}

// 正解済みの選択
@override final  DateTime? startedAt;
@override final  DateTime? completedAt;

/// Create a copy of OddEvenSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OddEvenSessionCopyWith<_OddEvenSession> get copyWith => __$OddEvenSessionCopyWithImpl<_OddEvenSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OddEvenSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&(identical(other.wrongAnswers, wrongAnswers) || other.wrongAnswers == wrongAnswers)&&(identical(other.wrongAttempts, wrongAttempts) || other.wrongAttempts == wrongAttempts)&&const DeepCollectionEquality().equals(other._selectedIndices, _selectedIndices)&&const DeepCollectionEquality().equals(other._correctlySelectedIndices, _correctlySelectedIndices)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(_results),currentProblem,wrongAnswers,wrongAttempts,const DeepCollectionEquality().hash(_selectedIndices),const DeepCollectionEquality().hash(_correctlySelectedIndices),startedAt,completedAt);

@override
String toString() {
  return 'OddEvenSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, wrongAnswers: $wrongAnswers, wrongAttempts: $wrongAttempts, selectedIndices: $selectedIndices, correctlySelectedIndices: $correctlySelectedIndices, startedAt: $startedAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$OddEvenSessionCopyWith<$Res> implements $OddEvenSessionCopyWith<$Res> {
  factory _$OddEvenSessionCopyWith(_OddEvenSession value, $Res Function(_OddEvenSession) _then) = __$OddEvenSessionCopyWithImpl;
@override @useResult
$Res call({
 int index, int total, List<bool?> results, OddEvenProblem? currentProblem, int wrongAnswers, int wrongAttempts, Set<int> selectedIndices, Set<int> correctlySelectedIndices, DateTime? startedAt, DateTime? completedAt
});


@override $OddEvenProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class __$OddEvenSessionCopyWithImpl<$Res>
    implements _$OddEvenSessionCopyWith<$Res> {
  __$OddEvenSessionCopyWithImpl(this._self, this._then);

  final _OddEvenSession _self;
  final $Res Function(_OddEvenSession) _then;

/// Create a copy of OddEvenSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? wrongAnswers = null,Object? wrongAttempts = null,Object? selectedIndices = null,Object? correctlySelectedIndices = null,Object? startedAt = freezed,Object? completedAt = freezed,}) {
  return _then(_OddEvenSession(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as OddEvenProblem?,wrongAnswers: null == wrongAnswers ? _self.wrongAnswers : wrongAnswers // ignore: cast_nullable_to_non_nullable
as int,wrongAttempts: null == wrongAttempts ? _self.wrongAttempts : wrongAttempts // ignore: cast_nullable_to_non_nullable
as int,selectedIndices: null == selectedIndices ? _self._selectedIndices : selectedIndices // ignore: cast_nullable_to_non_nullable
as Set<int>,correctlySelectedIndices: null == correctlySelectedIndices ? _self._correctlySelectedIndices : correctlySelectedIndices // ignore: cast_nullable_to_non_nullable
as Set<int>,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of OddEvenSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OddEvenProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $OddEvenProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}

/// @nodoc
mixin _$AnswerResult {

 Set<int> get selectedIndices; Set<int> get correctIndices; bool get isCorrect; bool get isPerfect; int get correctSelections; int get missedSelections; int get wrongSelections;
/// Create a copy of AnswerResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnswerResultCopyWith<AnswerResult> get copyWith => _$AnswerResultCopyWithImpl<AnswerResult>(this as AnswerResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnswerResult&&const DeepCollectionEquality().equals(other.selectedIndices, selectedIndices)&&const DeepCollectionEquality().equals(other.correctIndices, correctIndices)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.isPerfect, isPerfect) || other.isPerfect == isPerfect)&&(identical(other.correctSelections, correctSelections) || other.correctSelections == correctSelections)&&(identical(other.missedSelections, missedSelections) || other.missedSelections == missedSelections)&&(identical(other.wrongSelections, wrongSelections) || other.wrongSelections == wrongSelections));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(selectedIndices),const DeepCollectionEquality().hash(correctIndices),isCorrect,isPerfect,correctSelections,missedSelections,wrongSelections);

@override
String toString() {
  return 'AnswerResult(selectedIndices: $selectedIndices, correctIndices: $correctIndices, isCorrect: $isCorrect, isPerfect: $isPerfect, correctSelections: $correctSelections, missedSelections: $missedSelections, wrongSelections: $wrongSelections)';
}


}

/// @nodoc
abstract mixin class $AnswerResultCopyWith<$Res>  {
  factory $AnswerResultCopyWith(AnswerResult value, $Res Function(AnswerResult) _then) = _$AnswerResultCopyWithImpl;
@useResult
$Res call({
 Set<int> selectedIndices, Set<int> correctIndices, bool isCorrect, bool isPerfect, int correctSelections, int missedSelections, int wrongSelections
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
@pragma('vm:prefer-inline') @override $Res call({Object? selectedIndices = null,Object? correctIndices = null,Object? isCorrect = null,Object? isPerfect = null,Object? correctSelections = null,Object? missedSelections = null,Object? wrongSelections = null,}) {
  return _then(_self.copyWith(
selectedIndices: null == selectedIndices ? _self.selectedIndices : selectedIndices // ignore: cast_nullable_to_non_nullable
as Set<int>,correctIndices: null == correctIndices ? _self.correctIndices : correctIndices // ignore: cast_nullable_to_non_nullable
as Set<int>,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,isPerfect: null == isPerfect ? _self.isPerfect : isPerfect // ignore: cast_nullable_to_non_nullable
as bool,correctSelections: null == correctSelections ? _self.correctSelections : correctSelections // ignore: cast_nullable_to_non_nullable
as int,missedSelections: null == missedSelections ? _self.missedSelections : missedSelections // ignore: cast_nullable_to_non_nullable
as int,wrongSelections: null == wrongSelections ? _self.wrongSelections : wrongSelections // ignore: cast_nullable_to_non_nullable
as int,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Set<int> selectedIndices,  Set<int> correctIndices,  bool isCorrect,  bool isPerfect,  int correctSelections,  int missedSelections,  int wrongSelections)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnswerResult() when $default != null:
return $default(_that.selectedIndices,_that.correctIndices,_that.isCorrect,_that.isPerfect,_that.correctSelections,_that.missedSelections,_that.wrongSelections);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Set<int> selectedIndices,  Set<int> correctIndices,  bool isCorrect,  bool isPerfect,  int correctSelections,  int missedSelections,  int wrongSelections)  $default,) {final _that = this;
switch (_that) {
case _AnswerResult():
return $default(_that.selectedIndices,_that.correctIndices,_that.isCorrect,_that.isPerfect,_that.correctSelections,_that.missedSelections,_that.wrongSelections);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Set<int> selectedIndices,  Set<int> correctIndices,  bool isCorrect,  bool isPerfect,  int correctSelections,  int missedSelections,  int wrongSelections)?  $default,) {final _that = this;
switch (_that) {
case _AnswerResult() when $default != null:
return $default(_that.selectedIndices,_that.correctIndices,_that.isCorrect,_that.isPerfect,_that.correctSelections,_that.missedSelections,_that.wrongSelections);case _:
  return null;

}
}

}

/// @nodoc


class _AnswerResult extends AnswerResult {
  const _AnswerResult({required final  Set<int> selectedIndices, required final  Set<int> correctIndices, required this.isCorrect, required this.isPerfect, required this.correctSelections, required this.missedSelections, required this.wrongSelections}): _selectedIndices = selectedIndices,_correctIndices = correctIndices,super._();
  

 final  Set<int> _selectedIndices;
@override Set<int> get selectedIndices {
  if (_selectedIndices is EqualUnmodifiableSetView) return _selectedIndices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedIndices);
}

 final  Set<int> _correctIndices;
@override Set<int> get correctIndices {
  if (_correctIndices is EqualUnmodifiableSetView) return _correctIndices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_correctIndices);
}

@override final  bool isCorrect;
@override final  bool isPerfect;
@override final  int correctSelections;
@override final  int missedSelections;
@override final  int wrongSelections;

/// Create a copy of AnswerResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnswerResultCopyWith<_AnswerResult> get copyWith => __$AnswerResultCopyWithImpl<_AnswerResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnswerResult&&const DeepCollectionEquality().equals(other._selectedIndices, _selectedIndices)&&const DeepCollectionEquality().equals(other._correctIndices, _correctIndices)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.isPerfect, isPerfect) || other.isPerfect == isPerfect)&&(identical(other.correctSelections, correctSelections) || other.correctSelections == correctSelections)&&(identical(other.missedSelections, missedSelections) || other.missedSelections == missedSelections)&&(identical(other.wrongSelections, wrongSelections) || other.wrongSelections == wrongSelections));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_selectedIndices),const DeepCollectionEquality().hash(_correctIndices),isCorrect,isPerfect,correctSelections,missedSelections,wrongSelections);

@override
String toString() {
  return 'AnswerResult(selectedIndices: $selectedIndices, correctIndices: $correctIndices, isCorrect: $isCorrect, isPerfect: $isPerfect, correctSelections: $correctSelections, missedSelections: $missedSelections, wrongSelections: $wrongSelections)';
}


}

/// @nodoc
abstract mixin class _$AnswerResultCopyWith<$Res> implements $AnswerResultCopyWith<$Res> {
  factory _$AnswerResultCopyWith(_AnswerResult value, $Res Function(_AnswerResult) _then) = __$AnswerResultCopyWithImpl;
@override @useResult
$Res call({
 Set<int> selectedIndices, Set<int> correctIndices, bool isCorrect, bool isPerfect, int correctSelections, int missedSelections, int wrongSelections
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
@override @pragma('vm:prefer-inline') $Res call({Object? selectedIndices = null,Object? correctIndices = null,Object? isCorrect = null,Object? isPerfect = null,Object? correctSelections = null,Object? missedSelections = null,Object? wrongSelections = null,}) {
  return _then(_AnswerResult(
selectedIndices: null == selectedIndices ? _self._selectedIndices : selectedIndices // ignore: cast_nullable_to_non_nullable
as Set<int>,correctIndices: null == correctIndices ? _self._correctIndices : correctIndices // ignore: cast_nullable_to_non_nullable
as Set<int>,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,isPerfect: null == isPerfect ? _self.isPerfect : isPerfect // ignore: cast_nullable_to_non_nullable
as bool,correctSelections: null == correctSelections ? _self.correctSelections : correctSelections // ignore: cast_nullable_to_non_nullable
as int,missedSelections: null == missedSelections ? _self.missedSelections : missedSelections // ignore: cast_nullable_to_non_nullable
as int,wrongSelections: null == wrongSelections ? _self.wrongSelections : wrongSelections // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$OddEvenState {

 CommonGamePhase get phase; OddEvenSettings? get settings; OddEvenSession? get session; AnswerResult? get lastResult; int get epoch;
/// Create a copy of OddEvenState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OddEvenStateCopyWith<OddEvenState> get copyWith => _$OddEvenStateCopyWithImpl<OddEvenState>(this as OddEvenState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OddEvenState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.lastResult, lastResult) || other.lastResult == lastResult)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,lastResult,epoch);

@override
String toString() {
  return 'OddEvenState(phase: $phase, settings: $settings, session: $session, lastResult: $lastResult, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class $OddEvenStateCopyWith<$Res>  {
  factory $OddEvenStateCopyWith(OddEvenState value, $Res Function(OddEvenState) _then) = _$OddEvenStateCopyWithImpl;
@useResult
$Res call({
 CommonGamePhase phase, OddEvenSettings? settings, OddEvenSession? session, AnswerResult? lastResult, int epoch
});


$OddEvenSettingsCopyWith<$Res>? get settings;$OddEvenSessionCopyWith<$Res>? get session;$AnswerResultCopyWith<$Res>? get lastResult;

}
/// @nodoc
class _$OddEvenStateCopyWithImpl<$Res>
    implements $OddEvenStateCopyWith<$Res> {
  _$OddEvenStateCopyWithImpl(this._self, this._then);

  final OddEvenState _self;
  final $Res Function(OddEvenState) _then;

/// Create a copy of OddEvenState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? lastResult = freezed,Object? epoch = null,}) {
  return _then(_self.copyWith(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as OddEvenSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as OddEvenSession?,lastResult: freezed == lastResult ? _self.lastResult : lastResult // ignore: cast_nullable_to_non_nullable
as AnswerResult?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of OddEvenState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OddEvenSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $OddEvenSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of OddEvenState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OddEvenSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $OddEvenSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of OddEvenState
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


/// Adds pattern-matching-related methods to [OddEvenState].
extension OddEvenStatePatterns on OddEvenState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OddEvenState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OddEvenState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OddEvenState value)  $default,){
final _that = this;
switch (_that) {
case _OddEvenState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OddEvenState value)?  $default,){
final _that = this;
switch (_that) {
case _OddEvenState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CommonGamePhase phase,  OddEvenSettings? settings,  OddEvenSession? session,  AnswerResult? lastResult,  int epoch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OddEvenState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CommonGamePhase phase,  OddEvenSettings? settings,  OddEvenSession? session,  AnswerResult? lastResult,  int epoch)  $default,) {final _that = this;
switch (_that) {
case _OddEvenState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CommonGamePhase phase,  OddEvenSettings? settings,  OddEvenSession? session,  AnswerResult? lastResult,  int epoch)?  $default,) {final _that = this;
switch (_that) {
case _OddEvenState() when $default != null:
return $default(_that.phase,_that.settings,_that.session,_that.lastResult,_that.epoch);case _:
  return null;

}
}

}

/// @nodoc


class _OddEvenState extends OddEvenState {
  const _OddEvenState({this.phase = CommonGamePhase.ready, this.settings, this.session, this.lastResult, this.epoch = 0}): super._();
  

@override@JsonKey() final  CommonGamePhase phase;
@override final  OddEvenSettings? settings;
@override final  OddEvenSession? session;
@override final  AnswerResult? lastResult;
@override@JsonKey() final  int epoch;

/// Create a copy of OddEvenState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OddEvenStateCopyWith<_OddEvenState> get copyWith => __$OddEvenStateCopyWithImpl<_OddEvenState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OddEvenState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.lastResult, lastResult) || other.lastResult == lastResult)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,lastResult,epoch);

@override
String toString() {
  return 'OddEvenState(phase: $phase, settings: $settings, session: $session, lastResult: $lastResult, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class _$OddEvenStateCopyWith<$Res> implements $OddEvenStateCopyWith<$Res> {
  factory _$OddEvenStateCopyWith(_OddEvenState value, $Res Function(_OddEvenState) _then) = __$OddEvenStateCopyWithImpl;
@override @useResult
$Res call({
 CommonGamePhase phase, OddEvenSettings? settings, OddEvenSession? session, AnswerResult? lastResult, int epoch
});


@override $OddEvenSettingsCopyWith<$Res>? get settings;@override $OddEvenSessionCopyWith<$Res>? get session;@override $AnswerResultCopyWith<$Res>? get lastResult;

}
/// @nodoc
class __$OddEvenStateCopyWithImpl<$Res>
    implements _$OddEvenStateCopyWith<$Res> {
  __$OddEvenStateCopyWithImpl(this._self, this._then);

  final _OddEvenState _self;
  final $Res Function(_OddEvenState) _then;

/// Create a copy of OddEvenState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? lastResult = freezed,Object? epoch = null,}) {
  return _then(_OddEvenState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as OddEvenSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as OddEvenSession?,lastResult: freezed == lastResult ? _self.lastResult : lastResult // ignore: cast_nullable_to_non_nullable
as AnswerResult?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of OddEvenState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OddEvenSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $OddEvenSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of OddEvenState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OddEvenSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $OddEvenSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of OddEvenState
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
