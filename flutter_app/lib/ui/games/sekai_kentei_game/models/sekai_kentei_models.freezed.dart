// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sekai_kentei_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SekaiKenteiSettings {

 QuizTheme get theme; int get questionCount;
/// Create a copy of SekaiKenteiSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SekaiKenteiSettingsCopyWith<SekaiKenteiSettings> get copyWith => _$SekaiKenteiSettingsCopyWithImpl<SekaiKenteiSettings>(this as SekaiKenteiSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SekaiKenteiSettings&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount));
}


@override
int get hashCode => Object.hash(runtimeType,theme,questionCount);

@override
String toString() {
  return 'SekaiKenteiSettings(theme: $theme, questionCount: $questionCount)';
}


}

/// @nodoc
abstract mixin class $SekaiKenteiSettingsCopyWith<$Res>  {
  factory $SekaiKenteiSettingsCopyWith(SekaiKenteiSettings value, $Res Function(SekaiKenteiSettings) _then) = _$SekaiKenteiSettingsCopyWithImpl;
@useResult
$Res call({
 QuizTheme theme, int questionCount
});




}
/// @nodoc
class _$SekaiKenteiSettingsCopyWithImpl<$Res>
    implements $SekaiKenteiSettingsCopyWith<$Res> {
  _$SekaiKenteiSettingsCopyWithImpl(this._self, this._then);

  final SekaiKenteiSettings _self;
  final $Res Function(SekaiKenteiSettings) _then;

/// Create a copy of SekaiKenteiSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? theme = null,Object? questionCount = null,}) {
  return _then(_self.copyWith(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as QuizTheme,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SekaiKenteiSettings].
extension SekaiKenteiSettingsPatterns on SekaiKenteiSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SekaiKenteiSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SekaiKenteiSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SekaiKenteiSettings value)  $default,){
final _that = this;
switch (_that) {
case _SekaiKenteiSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SekaiKenteiSettings value)?  $default,){
final _that = this;
switch (_that) {
case _SekaiKenteiSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( QuizTheme theme,  int questionCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SekaiKenteiSettings() when $default != null:
return $default(_that.theme,_that.questionCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( QuizTheme theme,  int questionCount)  $default,) {final _that = this;
switch (_that) {
case _SekaiKenteiSettings():
return $default(_that.theme,_that.questionCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( QuizTheme theme,  int questionCount)?  $default,) {final _that = this;
switch (_that) {
case _SekaiKenteiSettings() when $default != null:
return $default(_that.theme,_that.questionCount);case _:
  return null;

}
}

}

/// @nodoc


class _SekaiKenteiSettings extends SekaiKenteiSettings {
  const _SekaiKenteiSettings({this.theme = QuizTheme.basic, this.questionCount = 10}): super._();
  

@override@JsonKey() final  QuizTheme theme;
@override@JsonKey() final  int questionCount;

/// Create a copy of SekaiKenteiSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SekaiKenteiSettingsCopyWith<_SekaiKenteiSettings> get copyWith => __$SekaiKenteiSettingsCopyWithImpl<_SekaiKenteiSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SekaiKenteiSettings&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount));
}


@override
int get hashCode => Object.hash(runtimeType,theme,questionCount);

@override
String toString() {
  return 'SekaiKenteiSettings(theme: $theme, questionCount: $questionCount)';
}


}

/// @nodoc
abstract mixin class _$SekaiKenteiSettingsCopyWith<$Res> implements $SekaiKenteiSettingsCopyWith<$Res> {
  factory _$SekaiKenteiSettingsCopyWith(_SekaiKenteiSettings value, $Res Function(_SekaiKenteiSettings) _then) = __$SekaiKenteiSettingsCopyWithImpl;
@override @useResult
$Res call({
 QuizTheme theme, int questionCount
});




}
/// @nodoc
class __$SekaiKenteiSettingsCopyWithImpl<$Res>
    implements _$SekaiKenteiSettingsCopyWith<$Res> {
  __$SekaiKenteiSettingsCopyWithImpl(this._self, this._then);

  final _SekaiKenteiSettings _self;
  final $Res Function(_SekaiKenteiSettings) _then;

/// Create a copy of SekaiKenteiSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? theme = null,Object? questionCount = null,}) {
  return _then(_SekaiKenteiSettings(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as QuizTheme,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$SekaiKenteiProblem {

 String get id;// 問題ID（CSV/JSONのid）
 String get question;// 問題文
 List<String> get options;// 選択肢（4つ）
 int get correctIndex;// 正解のインデックス
 String get explanation;
/// Create a copy of SekaiKenteiProblem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SekaiKenteiProblemCopyWith<SekaiKenteiProblem> get copyWith => _$SekaiKenteiProblemCopyWithImpl<SekaiKenteiProblem>(this as SekaiKenteiProblem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SekaiKenteiProblem&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.correctIndex, correctIndex) || other.correctIndex == correctIndex)&&(identical(other.explanation, explanation) || other.explanation == explanation));
}


@override
int get hashCode => Object.hash(runtimeType,id,question,const DeepCollectionEquality().hash(options),correctIndex,explanation);

@override
String toString() {
  return 'SekaiKenteiProblem(id: $id, question: $question, options: $options, correctIndex: $correctIndex, explanation: $explanation)';
}


}

/// @nodoc
abstract mixin class $SekaiKenteiProblemCopyWith<$Res>  {
  factory $SekaiKenteiProblemCopyWith(SekaiKenteiProblem value, $Res Function(SekaiKenteiProblem) _then) = _$SekaiKenteiProblemCopyWithImpl;
@useResult
$Res call({
 String id, String question, List<String> options, int correctIndex, String explanation
});




}
/// @nodoc
class _$SekaiKenteiProblemCopyWithImpl<$Res>
    implements $SekaiKenteiProblemCopyWith<$Res> {
  _$SekaiKenteiProblemCopyWithImpl(this._self, this._then);

  final SekaiKenteiProblem _self;
  final $Res Function(SekaiKenteiProblem) _then;

/// Create a copy of SekaiKenteiProblem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? question = null,Object? options = null,Object? correctIndex = null,Object? explanation = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>,correctIndex: null == correctIndex ? _self.correctIndex : correctIndex // ignore: cast_nullable_to_non_nullable
as int,explanation: null == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SekaiKenteiProblem].
extension SekaiKenteiProblemPatterns on SekaiKenteiProblem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SekaiKenteiProblem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SekaiKenteiProblem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SekaiKenteiProblem value)  $default,){
final _that = this;
switch (_that) {
case _SekaiKenteiProblem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SekaiKenteiProblem value)?  $default,){
final _that = this;
switch (_that) {
case _SekaiKenteiProblem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String question,  List<String> options,  int correctIndex,  String explanation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SekaiKenteiProblem() when $default != null:
return $default(_that.id,_that.question,_that.options,_that.correctIndex,_that.explanation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String question,  List<String> options,  int correctIndex,  String explanation)  $default,) {final _that = this;
switch (_that) {
case _SekaiKenteiProblem():
return $default(_that.id,_that.question,_that.options,_that.correctIndex,_that.explanation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String question,  List<String> options,  int correctIndex,  String explanation)?  $default,) {final _that = this;
switch (_that) {
case _SekaiKenteiProblem() when $default != null:
return $default(_that.id,_that.question,_that.options,_that.correctIndex,_that.explanation);case _:
  return null;

}
}

}

/// @nodoc


class _SekaiKenteiProblem extends SekaiKenteiProblem {
  const _SekaiKenteiProblem({required this.id, required this.question, required final  List<String> options, required this.correctIndex, this.explanation = ''}): _options = options,super._();
  

@override final  String id;
// 問題ID（CSV/JSONのid）
@override final  String question;
// 問題文
 final  List<String> _options;
// 問題文
@override List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

// 選択肢（4つ）
@override final  int correctIndex;
// 正解のインデックス
@override@JsonKey() final  String explanation;

/// Create a copy of SekaiKenteiProblem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SekaiKenteiProblemCopyWith<_SekaiKenteiProblem> get copyWith => __$SekaiKenteiProblemCopyWithImpl<_SekaiKenteiProblem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SekaiKenteiProblem&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.correctIndex, correctIndex) || other.correctIndex == correctIndex)&&(identical(other.explanation, explanation) || other.explanation == explanation));
}


@override
int get hashCode => Object.hash(runtimeType,id,question,const DeepCollectionEquality().hash(_options),correctIndex,explanation);

@override
String toString() {
  return 'SekaiKenteiProblem(id: $id, question: $question, options: $options, correctIndex: $correctIndex, explanation: $explanation)';
}


}

/// @nodoc
abstract mixin class _$SekaiKenteiProblemCopyWith<$Res> implements $SekaiKenteiProblemCopyWith<$Res> {
  factory _$SekaiKenteiProblemCopyWith(_SekaiKenteiProblem value, $Res Function(_SekaiKenteiProblem) _then) = __$SekaiKenteiProblemCopyWithImpl;
@override @useResult
$Res call({
 String id, String question, List<String> options, int correctIndex, String explanation
});




}
/// @nodoc
class __$SekaiKenteiProblemCopyWithImpl<$Res>
    implements _$SekaiKenteiProblemCopyWith<$Res> {
  __$SekaiKenteiProblemCopyWithImpl(this._self, this._then);

  final _SekaiKenteiProblem _self;
  final $Res Function(_SekaiKenteiProblem) _then;

/// Create a copy of SekaiKenteiProblem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? question = null,Object? options = null,Object? correctIndex = null,Object? explanation = null,}) {
  return _then(_SekaiKenteiProblem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>,correctIndex: null == correctIndex ? _self.correctIndex : correctIndex // ignore: cast_nullable_to_non_nullable
as int,explanation: null == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SekaiKenteiSession {

 int get index;// 現在の問題番号
 int get total;// 総問題数
 List<bool?> get results;// 各問題の結果
 SekaiKenteiProblem? get currentProblem; List<int> get selectedIndices;// 選択された選択肢
 int get wrongAnswers;
/// Create a copy of SekaiKenteiSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SekaiKenteiSessionCopyWith<SekaiKenteiSession> get copyWith => _$SekaiKenteiSessionCopyWithImpl<SekaiKenteiSession>(this as SekaiKenteiSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SekaiKenteiSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&const DeepCollectionEquality().equals(other.selectedIndices, selectedIndices)&&(identical(other.wrongAnswers, wrongAnswers) || other.wrongAnswers == wrongAnswers));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(results),currentProblem,const DeepCollectionEquality().hash(selectedIndices),wrongAnswers);

@override
String toString() {
  return 'SekaiKenteiSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, selectedIndices: $selectedIndices, wrongAnswers: $wrongAnswers)';
}


}

/// @nodoc
abstract mixin class $SekaiKenteiSessionCopyWith<$Res>  {
  factory $SekaiKenteiSessionCopyWith(SekaiKenteiSession value, $Res Function(SekaiKenteiSession) _then) = _$SekaiKenteiSessionCopyWithImpl;
@useResult
$Res call({
 int index, int total, List<bool?> results, SekaiKenteiProblem? currentProblem, List<int> selectedIndices, int wrongAnswers
});


$SekaiKenteiProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class _$SekaiKenteiSessionCopyWithImpl<$Res>
    implements $SekaiKenteiSessionCopyWith<$Res> {
  _$SekaiKenteiSessionCopyWithImpl(this._self, this._then);

  final SekaiKenteiSession _self;
  final $Res Function(SekaiKenteiSession) _then;

/// Create a copy of SekaiKenteiSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? selectedIndices = null,Object? wrongAnswers = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as SekaiKenteiProblem?,selectedIndices: null == selectedIndices ? _self.selectedIndices : selectedIndices // ignore: cast_nullable_to_non_nullable
as List<int>,wrongAnswers: null == wrongAnswers ? _self.wrongAnswers : wrongAnswers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of SekaiKenteiSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SekaiKenteiProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $SekaiKenteiProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}


/// Adds pattern-matching-related methods to [SekaiKenteiSession].
extension SekaiKenteiSessionPatterns on SekaiKenteiSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SekaiKenteiSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SekaiKenteiSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SekaiKenteiSession value)  $default,){
final _that = this;
switch (_that) {
case _SekaiKenteiSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SekaiKenteiSession value)?  $default,){
final _that = this;
switch (_that) {
case _SekaiKenteiSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  SekaiKenteiProblem? currentProblem,  List<int> selectedIndices,  int wrongAnswers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SekaiKenteiSession() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  SekaiKenteiProblem? currentProblem,  List<int> selectedIndices,  int wrongAnswers)  $default,) {final _that = this;
switch (_that) {
case _SekaiKenteiSession():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  int total,  List<bool?> results,  SekaiKenteiProblem? currentProblem,  List<int> selectedIndices,  int wrongAnswers)?  $default,) {final _that = this;
switch (_that) {
case _SekaiKenteiSession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.selectedIndices,_that.wrongAnswers);case _:
  return null;

}
}

}

/// @nodoc


class _SekaiKenteiSession extends SekaiKenteiSession {
  const _SekaiKenteiSession({required this.index, required this.total, required final  List<bool?> results, this.currentProblem, final  List<int> selectedIndices = const [], this.wrongAnswers = 0}): _results = results,_selectedIndices = selectedIndices,super._();
  

@override final  int index;
// 現在の問題番号
@override final  int total;
// 総問題数
 final  List<bool?> _results;
// 総問題数
@override List<bool?> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

// 各問題の結果
@override final  SekaiKenteiProblem? currentProblem;
 final  List<int> _selectedIndices;
@override@JsonKey() List<int> get selectedIndices {
  if (_selectedIndices is EqualUnmodifiableListView) return _selectedIndices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedIndices);
}

// 選択された選択肢
@override@JsonKey() final  int wrongAnswers;

/// Create a copy of SekaiKenteiSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SekaiKenteiSessionCopyWith<_SekaiKenteiSession> get copyWith => __$SekaiKenteiSessionCopyWithImpl<_SekaiKenteiSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SekaiKenteiSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&const DeepCollectionEquality().equals(other._selectedIndices, _selectedIndices)&&(identical(other.wrongAnswers, wrongAnswers) || other.wrongAnswers == wrongAnswers));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(_results),currentProblem,const DeepCollectionEquality().hash(_selectedIndices),wrongAnswers);

@override
String toString() {
  return 'SekaiKenteiSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, selectedIndices: $selectedIndices, wrongAnswers: $wrongAnswers)';
}


}

/// @nodoc
abstract mixin class _$SekaiKenteiSessionCopyWith<$Res> implements $SekaiKenteiSessionCopyWith<$Res> {
  factory _$SekaiKenteiSessionCopyWith(_SekaiKenteiSession value, $Res Function(_SekaiKenteiSession) _then) = __$SekaiKenteiSessionCopyWithImpl;
@override @useResult
$Res call({
 int index, int total, List<bool?> results, SekaiKenteiProblem? currentProblem, List<int> selectedIndices, int wrongAnswers
});


@override $SekaiKenteiProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class __$SekaiKenteiSessionCopyWithImpl<$Res>
    implements _$SekaiKenteiSessionCopyWith<$Res> {
  __$SekaiKenteiSessionCopyWithImpl(this._self, this._then);

  final _SekaiKenteiSession _self;
  final $Res Function(_SekaiKenteiSession) _then;

/// Create a copy of SekaiKenteiSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? selectedIndices = null,Object? wrongAnswers = null,}) {
  return _then(_SekaiKenteiSession(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as SekaiKenteiProblem?,selectedIndices: null == selectedIndices ? _self._selectedIndices : selectedIndices // ignore: cast_nullable_to_non_nullable
as List<int>,wrongAnswers: null == wrongAnswers ? _self.wrongAnswers : wrongAnswers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of SekaiKenteiSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SekaiKenteiProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $SekaiKenteiProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}

/// @nodoc
mixin _$SekaiKenteiState {

 CommonGamePhase get phase; SekaiKenteiSettings? get settings; SekaiKenteiSession? get session; AnswerResult? get lastResult; int get epoch;
/// Create a copy of SekaiKenteiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SekaiKenteiStateCopyWith<SekaiKenteiState> get copyWith => _$SekaiKenteiStateCopyWithImpl<SekaiKenteiState>(this as SekaiKenteiState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SekaiKenteiState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.lastResult, lastResult) || other.lastResult == lastResult)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,lastResult,epoch);

@override
String toString() {
  return 'SekaiKenteiState(phase: $phase, settings: $settings, session: $session, lastResult: $lastResult, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class $SekaiKenteiStateCopyWith<$Res>  {
  factory $SekaiKenteiStateCopyWith(SekaiKenteiState value, $Res Function(SekaiKenteiState) _then) = _$SekaiKenteiStateCopyWithImpl;
@useResult
$Res call({
 CommonGamePhase phase, SekaiKenteiSettings? settings, SekaiKenteiSession? session, AnswerResult? lastResult, int epoch
});


$SekaiKenteiSettingsCopyWith<$Res>? get settings;$SekaiKenteiSessionCopyWith<$Res>? get session;$AnswerResultCopyWith<$Res>? get lastResult;

}
/// @nodoc
class _$SekaiKenteiStateCopyWithImpl<$Res>
    implements $SekaiKenteiStateCopyWith<$Res> {
  _$SekaiKenteiStateCopyWithImpl(this._self, this._then);

  final SekaiKenteiState _self;
  final $Res Function(SekaiKenteiState) _then;

/// Create a copy of SekaiKenteiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? lastResult = freezed,Object? epoch = null,}) {
  return _then(_self.copyWith(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as SekaiKenteiSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as SekaiKenteiSession?,lastResult: freezed == lastResult ? _self.lastResult : lastResult // ignore: cast_nullable_to_non_nullable
as AnswerResult?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of SekaiKenteiState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SekaiKenteiSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $SekaiKenteiSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of SekaiKenteiState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SekaiKenteiSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $SekaiKenteiSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of SekaiKenteiState
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


/// Adds pattern-matching-related methods to [SekaiKenteiState].
extension SekaiKenteiStatePatterns on SekaiKenteiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SekaiKenteiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SekaiKenteiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SekaiKenteiState value)  $default,){
final _that = this;
switch (_that) {
case _SekaiKenteiState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SekaiKenteiState value)?  $default,){
final _that = this;
switch (_that) {
case _SekaiKenteiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CommonGamePhase phase,  SekaiKenteiSettings? settings,  SekaiKenteiSession? session,  AnswerResult? lastResult,  int epoch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SekaiKenteiState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CommonGamePhase phase,  SekaiKenteiSettings? settings,  SekaiKenteiSession? session,  AnswerResult? lastResult,  int epoch)  $default,) {final _that = this;
switch (_that) {
case _SekaiKenteiState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CommonGamePhase phase,  SekaiKenteiSettings? settings,  SekaiKenteiSession? session,  AnswerResult? lastResult,  int epoch)?  $default,) {final _that = this;
switch (_that) {
case _SekaiKenteiState() when $default != null:
return $default(_that.phase,_that.settings,_that.session,_that.lastResult,_that.epoch);case _:
  return null;

}
}

}

/// @nodoc


class _SekaiKenteiState extends SekaiKenteiState {
  const _SekaiKenteiState({this.phase = CommonGamePhase.ready, this.settings, this.session, this.lastResult, this.epoch = 0}): super._();
  

@override@JsonKey() final  CommonGamePhase phase;
@override final  SekaiKenteiSettings? settings;
@override final  SekaiKenteiSession? session;
@override final  AnswerResult? lastResult;
@override@JsonKey() final  int epoch;

/// Create a copy of SekaiKenteiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SekaiKenteiStateCopyWith<_SekaiKenteiState> get copyWith => __$SekaiKenteiStateCopyWithImpl<_SekaiKenteiState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SekaiKenteiState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.lastResult, lastResult) || other.lastResult == lastResult)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,lastResult,epoch);

@override
String toString() {
  return 'SekaiKenteiState(phase: $phase, settings: $settings, session: $session, lastResult: $lastResult, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class _$SekaiKenteiStateCopyWith<$Res> implements $SekaiKenteiStateCopyWith<$Res> {
  factory _$SekaiKenteiStateCopyWith(_SekaiKenteiState value, $Res Function(_SekaiKenteiState) _then) = __$SekaiKenteiStateCopyWithImpl;
@override @useResult
$Res call({
 CommonGamePhase phase, SekaiKenteiSettings? settings, SekaiKenteiSession? session, AnswerResult? lastResult, int epoch
});


@override $SekaiKenteiSettingsCopyWith<$Res>? get settings;@override $SekaiKenteiSessionCopyWith<$Res>? get session;@override $AnswerResultCopyWith<$Res>? get lastResult;

}
/// @nodoc
class __$SekaiKenteiStateCopyWithImpl<$Res>
    implements _$SekaiKenteiStateCopyWith<$Res> {
  __$SekaiKenteiStateCopyWithImpl(this._self, this._then);

  final _SekaiKenteiState _self;
  final $Res Function(_SekaiKenteiState) _then;

/// Create a copy of SekaiKenteiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? lastResult = freezed,Object? epoch = null,}) {
  return _then(_SekaiKenteiState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as SekaiKenteiSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as SekaiKenteiSession?,lastResult: freezed == lastResult ? _self.lastResult : lastResult // ignore: cast_nullable_to_non_nullable
as AnswerResult?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of SekaiKenteiState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SekaiKenteiSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $SekaiKenteiSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of SekaiKenteiState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SekaiKenteiSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $SekaiKenteiSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of SekaiKenteiState
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
