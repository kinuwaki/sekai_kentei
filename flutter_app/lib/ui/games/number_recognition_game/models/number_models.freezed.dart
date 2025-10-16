// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'number_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NumberProblem {

 int get correct; String get prompt;
/// Create a copy of NumberProblem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NumberProblemCopyWith<NumberProblem> get copyWith => _$NumberProblemCopyWithImpl<NumberProblem>(this as NumberProblem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NumberProblem&&(identical(other.correct, correct) || other.correct == correct)&&(identical(other.prompt, prompt) || other.prompt == prompt));
}


@override
int get hashCode => Object.hash(runtimeType,correct,prompt);

@override
String toString() {
  return 'NumberProblem(correct: $correct, prompt: $prompt)';
}


}

/// @nodoc
abstract mixin class $NumberProblemCopyWith<$Res>  {
  factory $NumberProblemCopyWith(NumberProblem value, $Res Function(NumberProblem) _then) = _$NumberProblemCopyWithImpl;
@useResult
$Res call({
 int correct, String prompt
});




}
/// @nodoc
class _$NumberProblemCopyWithImpl<$Res>
    implements $NumberProblemCopyWith<$Res> {
  _$NumberProblemCopyWithImpl(this._self, this._then);

  final NumberProblem _self;
  final $Res Function(NumberProblem) _then;

/// Create a copy of NumberProblem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? correct = null,Object? prompt = null,}) {
  return _then(_self.copyWith(
correct: null == correct ? _self.correct : correct // ignore: cast_nullable_to_non_nullable
as int,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NumberProblem].
extension NumberProblemPatterns on NumberProblem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NumberProblem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NumberProblem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NumberProblem value)  $default,){
final _that = this;
switch (_that) {
case _NumberProblem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NumberProblem value)?  $default,){
final _that = this;
switch (_that) {
case _NumberProblem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int correct,  String prompt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NumberProblem() when $default != null:
return $default(_that.correct,_that.prompt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int correct,  String prompt)  $default,) {final _that = this;
switch (_that) {
case _NumberProblem():
return $default(_that.correct,_that.prompt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int correct,  String prompt)?  $default,) {final _that = this;
switch (_that) {
case _NumberProblem() when $default != null:
return $default(_that.correct,_that.prompt);case _:
  return null;

}
}

}

/// @nodoc


class _NumberProblem implements NumberProblem {
  const _NumberProblem({required this.correct, required this.prompt});
  

@override final  int correct;
@override final  String prompt;

/// Create a copy of NumberProblem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NumberProblemCopyWith<_NumberProblem> get copyWith => __$NumberProblemCopyWithImpl<_NumberProblem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NumberProblem&&(identical(other.correct, correct) || other.correct == correct)&&(identical(other.prompt, prompt) || other.prompt == prompt));
}


@override
int get hashCode => Object.hash(runtimeType,correct,prompt);

@override
String toString() {
  return 'NumberProblem(correct: $correct, prompt: $prompt)';
}


}

/// @nodoc
abstract mixin class _$NumberProblemCopyWith<$Res> implements $NumberProblemCopyWith<$Res> {
  factory _$NumberProblemCopyWith(_NumberProblem value, $Res Function(_NumberProblem) _then) = __$NumberProblemCopyWithImpl;
@override @useResult
$Res call({
 int correct, String prompt
});




}
/// @nodoc
class __$NumberProblemCopyWithImpl<$Res>
    implements _$NumberProblemCopyWith<$Res> {
  __$NumberProblemCopyWithImpl(this._self, this._then);

  final _NumberProblem _self;
  final $Res Function(_NumberProblem) _then;

/// Create a copy of NumberProblem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? correct = null,Object? prompt = null,}) {
  return _then(_NumberProblem(
correct: null == correct ? _self.correct : correct // ignore: cast_nullable_to_non_nullable
as int,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$NumberSession {

 int get index;// 0-based
 int get total; NumberProblem get current;
/// Create a copy of NumberSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NumberSessionCopyWith<NumberSession> get copyWith => _$NumberSessionCopyWithImpl<NumberSession>(this as NumberSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NumberSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&(identical(other.current, current) || other.current == current));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,current);

@override
String toString() {
  return 'NumberSession(index: $index, total: $total, current: $current)';
}


}

/// @nodoc
abstract mixin class $NumberSessionCopyWith<$Res>  {
  factory $NumberSessionCopyWith(NumberSession value, $Res Function(NumberSession) _then) = _$NumberSessionCopyWithImpl;
@useResult
$Res call({
 int index, int total, NumberProblem current
});


$NumberProblemCopyWith<$Res> get current;

}
/// @nodoc
class _$NumberSessionCopyWithImpl<$Res>
    implements $NumberSessionCopyWith<$Res> {
  _$NumberSessionCopyWithImpl(this._self, this._then);

  final NumberSession _self;
  final $Res Function(NumberSession) _then;

/// Create a copy of NumberSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? total = null,Object? current = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as NumberProblem,
  ));
}
/// Create a copy of NumberSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NumberProblemCopyWith<$Res> get current {
  
  return $NumberProblemCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}
}


/// Adds pattern-matching-related methods to [NumberSession].
extension NumberSessionPatterns on NumberSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NumberSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NumberSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NumberSession value)  $default,){
final _that = this;
switch (_that) {
case _NumberSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NumberSession value)?  $default,){
final _that = this;
switch (_that) {
case _NumberSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  int total,  NumberProblem current)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NumberSession() when $default != null:
return $default(_that.index,_that.total,_that.current);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  int total,  NumberProblem current)  $default,) {final _that = this;
switch (_that) {
case _NumberSession():
return $default(_that.index,_that.total,_that.current);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  int total,  NumberProblem current)?  $default,) {final _that = this;
switch (_that) {
case _NumberSession() when $default != null:
return $default(_that.index,_that.total,_that.current);case _:
  return null;

}
}

}

/// @nodoc


class _NumberSession extends NumberSession {
  const _NumberSession({required this.index, required this.total, required this.current}): super._();
  

@override final  int index;
// 0-based
@override final  int total;
@override final  NumberProblem current;

/// Create a copy of NumberSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NumberSessionCopyWith<_NumberSession> get copyWith => __$NumberSessionCopyWithImpl<_NumberSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NumberSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&(identical(other.current, current) || other.current == current));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,current);

@override
String toString() {
  return 'NumberSession(index: $index, total: $total, current: $current)';
}


}

/// @nodoc
abstract mixin class _$NumberSessionCopyWith<$Res> implements $NumberSessionCopyWith<$Res> {
  factory _$NumberSessionCopyWith(_NumberSession value, $Res Function(_NumberSession) _then) = __$NumberSessionCopyWithImpl;
@override @useResult
$Res call({
 int index, int total, NumberProblem current
});


@override $NumberProblemCopyWith<$Res> get current;

}
/// @nodoc
class __$NumberSessionCopyWithImpl<$Res>
    implements _$NumberSessionCopyWith<$Res> {
  __$NumberSessionCopyWithImpl(this._self, this._then);

  final _NumberSession _self;
  final $Res Function(_NumberSession) _then;

/// Create a copy of NumberSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? total = null,Object? current = null,}) {
  return _then(_NumberSession(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as NumberProblem,
  ));
}

/// Create a copy of NumberSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NumberProblemCopyWith<$Res> get current {
  
  return $NumberProblemCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}
}

/// @nodoc
mixin _$AnswerResult {

 int get recognizedNumber; bool get isCorrect; int get correctAnswer;
/// Create a copy of AnswerResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnswerResultCopyWith<AnswerResult> get copyWith => _$AnswerResultCopyWithImpl<AnswerResult>(this as AnswerResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnswerResult&&(identical(other.recognizedNumber, recognizedNumber) || other.recognizedNumber == recognizedNumber)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.correctAnswer, correctAnswer) || other.correctAnswer == correctAnswer));
}


@override
int get hashCode => Object.hash(runtimeType,recognizedNumber,isCorrect,correctAnswer);

@override
String toString() {
  return 'AnswerResult(recognizedNumber: $recognizedNumber, isCorrect: $isCorrect, correctAnswer: $correctAnswer)';
}


}

/// @nodoc
abstract mixin class $AnswerResultCopyWith<$Res>  {
  factory $AnswerResultCopyWith(AnswerResult value, $Res Function(AnswerResult) _then) = _$AnswerResultCopyWithImpl;
@useResult
$Res call({
 int recognizedNumber, bool isCorrect, int correctAnswer
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
@pragma('vm:prefer-inline') @override $Res call({Object? recognizedNumber = null,Object? isCorrect = null,Object? correctAnswer = null,}) {
  return _then(_self.copyWith(
recognizedNumber: null == recognizedNumber ? _self.recognizedNumber : recognizedNumber // ignore: cast_nullable_to_non_nullable
as int,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,correctAnswer: null == correctAnswer ? _self.correctAnswer : correctAnswer // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int recognizedNumber,  bool isCorrect,  int correctAnswer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnswerResult() when $default != null:
return $default(_that.recognizedNumber,_that.isCorrect,_that.correctAnswer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int recognizedNumber,  bool isCorrect,  int correctAnswer)  $default,) {final _that = this;
switch (_that) {
case _AnswerResult():
return $default(_that.recognizedNumber,_that.isCorrect,_that.correctAnswer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int recognizedNumber,  bool isCorrect,  int correctAnswer)?  $default,) {final _that = this;
switch (_that) {
case _AnswerResult() when $default != null:
return $default(_that.recognizedNumber,_that.isCorrect,_that.correctAnswer);case _:
  return null;

}
}

}

/// @nodoc


class _AnswerResult implements AnswerResult {
  const _AnswerResult({required this.recognizedNumber, required this.isCorrect, required this.correctAnswer});
  

@override final  int recognizedNumber;
@override final  bool isCorrect;
@override final  int correctAnswer;

/// Create a copy of AnswerResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnswerResultCopyWith<_AnswerResult> get copyWith => __$AnswerResultCopyWithImpl<_AnswerResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnswerResult&&(identical(other.recognizedNumber, recognizedNumber) || other.recognizedNumber == recognizedNumber)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.correctAnswer, correctAnswer) || other.correctAnswer == correctAnswer));
}


@override
int get hashCode => Object.hash(runtimeType,recognizedNumber,isCorrect,correctAnswer);

@override
String toString() {
  return 'AnswerResult(recognizedNumber: $recognizedNumber, isCorrect: $isCorrect, correctAnswer: $correctAnswer)';
}


}

/// @nodoc
abstract mixin class _$AnswerResultCopyWith<$Res> implements $AnswerResultCopyWith<$Res> {
  factory _$AnswerResultCopyWith(_AnswerResult value, $Res Function(_AnswerResult) _then) = __$AnswerResultCopyWithImpl;
@override @useResult
$Res call({
 int recognizedNumber, bool isCorrect, int correctAnswer
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
@override @pragma('vm:prefer-inline') $Res call({Object? recognizedNumber = null,Object? isCorrect = null,Object? correctAnswer = null,}) {
  return _then(_AnswerResult(
recognizedNumber: null == recognizedNumber ? _self.recognizedNumber : recognizedNumber // ignore: cast_nullable_to_non_nullable
as int,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,correctAnswer: null == correctAnswer ? _self.correctAnswer : correctAnswer // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$NumberState {

 CommonGamePhase get phase; NumberSession get session; DrawingData get drawing; AnswerResult? get lastResult; String? get lastError; int get epoch;
/// Create a copy of NumberState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NumberStateCopyWith<NumberState> get copyWith => _$NumberStateCopyWithImpl<NumberState>(this as NumberState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NumberState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.session, session) || other.session == session)&&(identical(other.drawing, drawing) || other.drawing == drawing)&&(identical(other.lastResult, lastResult) || other.lastResult == lastResult)&&(identical(other.lastError, lastError) || other.lastError == lastError)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,session,drawing,lastResult,lastError,epoch);

@override
String toString() {
  return 'NumberState(phase: $phase, session: $session, drawing: $drawing, lastResult: $lastResult, lastError: $lastError, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class $NumberStateCopyWith<$Res>  {
  factory $NumberStateCopyWith(NumberState value, $Res Function(NumberState) _then) = _$NumberStateCopyWithImpl;
@useResult
$Res call({
 CommonGamePhase phase, NumberSession session, DrawingData drawing, AnswerResult? lastResult, String? lastError, int epoch
});


$NumberSessionCopyWith<$Res> get session;$AnswerResultCopyWith<$Res>? get lastResult;

}
/// @nodoc
class _$NumberStateCopyWithImpl<$Res>
    implements $NumberStateCopyWith<$Res> {
  _$NumberStateCopyWithImpl(this._self, this._then);

  final NumberState _self;
  final $Res Function(NumberState) _then;

/// Create a copy of NumberState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? session = null,Object? drawing = null,Object? lastResult = freezed,Object? lastError = freezed,Object? epoch = null,}) {
  return _then(_self.copyWith(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as NumberSession,drawing: null == drawing ? _self.drawing : drawing // ignore: cast_nullable_to_non_nullable
as DrawingData,lastResult: freezed == lastResult ? _self.lastResult : lastResult // ignore: cast_nullable_to_non_nullable
as AnswerResult?,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of NumberState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NumberSessionCopyWith<$Res> get session {
  
  return $NumberSessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of NumberState
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


/// Adds pattern-matching-related methods to [NumberState].
extension NumberStatePatterns on NumberState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NumberState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NumberState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NumberState value)  $default,){
final _that = this;
switch (_that) {
case _NumberState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NumberState value)?  $default,){
final _that = this;
switch (_that) {
case _NumberState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CommonGamePhase phase,  NumberSession session,  DrawingData drawing,  AnswerResult? lastResult,  String? lastError,  int epoch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NumberState() when $default != null:
return $default(_that.phase,_that.session,_that.drawing,_that.lastResult,_that.lastError,_that.epoch);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CommonGamePhase phase,  NumberSession session,  DrawingData drawing,  AnswerResult? lastResult,  String? lastError,  int epoch)  $default,) {final _that = this;
switch (_that) {
case _NumberState():
return $default(_that.phase,_that.session,_that.drawing,_that.lastResult,_that.lastError,_that.epoch);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CommonGamePhase phase,  NumberSession session,  DrawingData drawing,  AnswerResult? lastResult,  String? lastError,  int epoch)?  $default,) {final _that = this;
switch (_that) {
case _NumberState() when $default != null:
return $default(_that.phase,_that.session,_that.drawing,_that.lastResult,_that.lastError,_that.epoch);case _:
  return null;

}
}

}

/// @nodoc


class _NumberState implements NumberState {
  const _NumberState({required this.phase, required this.session, required this.drawing, this.lastResult, this.lastError, this.epoch = 0});
  

@override final  CommonGamePhase phase;
@override final  NumberSession session;
@override final  DrawingData drawing;
@override final  AnswerResult? lastResult;
@override final  String? lastError;
@override@JsonKey() final  int epoch;

/// Create a copy of NumberState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NumberStateCopyWith<_NumberState> get copyWith => __$NumberStateCopyWithImpl<_NumberState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NumberState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.session, session) || other.session == session)&&(identical(other.drawing, drawing) || other.drawing == drawing)&&(identical(other.lastResult, lastResult) || other.lastResult == lastResult)&&(identical(other.lastError, lastError) || other.lastError == lastError)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,session,drawing,lastResult,lastError,epoch);

@override
String toString() {
  return 'NumberState(phase: $phase, session: $session, drawing: $drawing, lastResult: $lastResult, lastError: $lastError, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class _$NumberStateCopyWith<$Res> implements $NumberStateCopyWith<$Res> {
  factory _$NumberStateCopyWith(_NumberState value, $Res Function(_NumberState) _then) = __$NumberStateCopyWithImpl;
@override @useResult
$Res call({
 CommonGamePhase phase, NumberSession session, DrawingData drawing, AnswerResult? lastResult, String? lastError, int epoch
});


@override $NumberSessionCopyWith<$Res> get session;@override $AnswerResultCopyWith<$Res>? get lastResult;

}
/// @nodoc
class __$NumberStateCopyWithImpl<$Res>
    implements _$NumberStateCopyWith<$Res> {
  __$NumberStateCopyWithImpl(this._self, this._then);

  final _NumberState _self;
  final $Res Function(_NumberState) _then;

/// Create a copy of NumberState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? session = null,Object? drawing = null,Object? lastResult = freezed,Object? lastError = freezed,Object? epoch = null,}) {
  return _then(_NumberState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as NumberSession,drawing: null == drawing ? _self.drawing : drawing // ignore: cast_nullable_to_non_nullable
as DrawingData,lastResult: freezed == lastResult ? _self.lastResult : lastResult // ignore: cast_nullable_to_non_nullable
as AnswerResult?,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of NumberState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NumberSessionCopyWith<$Res> get session {
  
  return $NumberSessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of NumberState
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
