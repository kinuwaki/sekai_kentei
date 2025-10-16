// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word_fill_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WordFillSettings {

 int get questionCount;
/// Create a copy of WordFillSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordFillSettingsCopyWith<WordFillSettings> get copyWith => _$WordFillSettingsCopyWithImpl<WordFillSettings>(this as WordFillSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordFillSettings&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount));
}


@override
int get hashCode => Object.hash(runtimeType,questionCount);

@override
String toString() {
  return 'WordFillSettings(questionCount: $questionCount)';
}


}

/// @nodoc
abstract mixin class $WordFillSettingsCopyWith<$Res>  {
  factory $WordFillSettingsCopyWith(WordFillSettings value, $Res Function(WordFillSettings) _then) = _$WordFillSettingsCopyWithImpl;
@useResult
$Res call({
 int questionCount
});




}
/// @nodoc
class _$WordFillSettingsCopyWithImpl<$Res>
    implements $WordFillSettingsCopyWith<$Res> {
  _$WordFillSettingsCopyWithImpl(this._self, this._then);

  final WordFillSettings _self;
  final $Res Function(WordFillSettings) _then;

/// Create a copy of WordFillSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionCount = null,}) {
  return _then(_self.copyWith(
questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WordFillSettings].
extension WordFillSettingsPatterns on WordFillSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordFillSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordFillSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordFillSettings value)  $default,){
final _that = this;
switch (_that) {
case _WordFillSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordFillSettings value)?  $default,){
final _that = this;
switch (_that) {
case _WordFillSettings() when $default != null:
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
case _WordFillSettings() when $default != null:
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
case _WordFillSettings():
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
case _WordFillSettings() when $default != null:
return $default(_that.questionCount);case _:
  return null;

}
}

}

/// @nodoc


class _WordFillSettings extends WordFillSettings {
  const _WordFillSettings({this.questionCount = 5}): super._();
  

@override@JsonKey() final  int questionCount;

/// Create a copy of WordFillSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordFillSettingsCopyWith<_WordFillSettings> get copyWith => __$WordFillSettingsCopyWithImpl<_WordFillSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordFillSettings&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount));
}


@override
int get hashCode => Object.hash(runtimeType,questionCount);

@override
String toString() {
  return 'WordFillSettings(questionCount: $questionCount)';
}


}

/// @nodoc
abstract mixin class _$WordFillSettingsCopyWith<$Res> implements $WordFillSettingsCopyWith<$Res> {
  factory _$WordFillSettingsCopyWith(_WordFillSettings value, $Res Function(_WordFillSettings) _then) = __$WordFillSettingsCopyWithImpl;
@override @useResult
$Res call({
 int questionCount
});




}
/// @nodoc
class __$WordFillSettingsCopyWithImpl<$Res>
    implements _$WordFillSettingsCopyWith<$Res> {
  __$WordFillSettingsCopyWithImpl(this._self, this._then);

  final _WordFillSettings _self;
  final $Res Function(_WordFillSettings) _then;

/// Create a copy of WordFillSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionCount = null,}) {
  return _then(_WordFillSettings(
questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$WordFillProblem {

 String get word;// 正解の単語（例：てぶくろ）
 int get blankIndex;// 空欄のインデックス（0-based）
 String get imagePath;
/// Create a copy of WordFillProblem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordFillProblemCopyWith<WordFillProblem> get copyWith => _$WordFillProblemCopyWithImpl<WordFillProblem>(this as WordFillProblem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordFillProblem&&(identical(other.word, word) || other.word == word)&&(identical(other.blankIndex, blankIndex) || other.blankIndex == blankIndex)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath));
}


@override
int get hashCode => Object.hash(runtimeType,word,blankIndex,imagePath);

@override
String toString() {
  return 'WordFillProblem(word: $word, blankIndex: $blankIndex, imagePath: $imagePath)';
}


}

/// @nodoc
abstract mixin class $WordFillProblemCopyWith<$Res>  {
  factory $WordFillProblemCopyWith(WordFillProblem value, $Res Function(WordFillProblem) _then) = _$WordFillProblemCopyWithImpl;
@useResult
$Res call({
 String word, int blankIndex, String imagePath
});




}
/// @nodoc
class _$WordFillProblemCopyWithImpl<$Res>
    implements $WordFillProblemCopyWith<$Res> {
  _$WordFillProblemCopyWithImpl(this._self, this._then);

  final WordFillProblem _self;
  final $Res Function(WordFillProblem) _then;

/// Create a copy of WordFillProblem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? word = null,Object? blankIndex = null,Object? imagePath = null,}) {
  return _then(_self.copyWith(
word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,blankIndex: null == blankIndex ? _self.blankIndex : blankIndex // ignore: cast_nullable_to_non_nullable
as int,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WordFillProblem].
extension WordFillProblemPatterns on WordFillProblem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordFillProblem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordFillProblem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordFillProblem value)  $default,){
final _that = this;
switch (_that) {
case _WordFillProblem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordFillProblem value)?  $default,){
final _that = this;
switch (_that) {
case _WordFillProblem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String word,  int blankIndex,  String imagePath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordFillProblem() when $default != null:
return $default(_that.word,_that.blankIndex,_that.imagePath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String word,  int blankIndex,  String imagePath)  $default,) {final _that = this;
switch (_that) {
case _WordFillProblem():
return $default(_that.word,_that.blankIndex,_that.imagePath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String word,  int blankIndex,  String imagePath)?  $default,) {final _that = this;
switch (_that) {
case _WordFillProblem() when $default != null:
return $default(_that.word,_that.blankIndex,_that.imagePath);case _:
  return null;

}
}

}

/// @nodoc


class _WordFillProblem extends WordFillProblem {
  const _WordFillProblem({required this.word, required this.blankIndex, required this.imagePath}): super._();
  

@override final  String word;
// 正解の単語（例：てぶくろ）
@override final  int blankIndex;
// 空欄のインデックス（0-based）
@override final  String imagePath;

/// Create a copy of WordFillProblem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordFillProblemCopyWith<_WordFillProblem> get copyWith => __$WordFillProblemCopyWithImpl<_WordFillProblem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordFillProblem&&(identical(other.word, word) || other.word == word)&&(identical(other.blankIndex, blankIndex) || other.blankIndex == blankIndex)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath));
}


@override
int get hashCode => Object.hash(runtimeType,word,blankIndex,imagePath);

@override
String toString() {
  return 'WordFillProblem(word: $word, blankIndex: $blankIndex, imagePath: $imagePath)';
}


}

/// @nodoc
abstract mixin class _$WordFillProblemCopyWith<$Res> implements $WordFillProblemCopyWith<$Res> {
  factory _$WordFillProblemCopyWith(_WordFillProblem value, $Res Function(_WordFillProblem) _then) = __$WordFillProblemCopyWithImpl;
@override @useResult
$Res call({
 String word, int blankIndex, String imagePath
});




}
/// @nodoc
class __$WordFillProblemCopyWithImpl<$Res>
    implements _$WordFillProblemCopyWith<$Res> {
  __$WordFillProblemCopyWithImpl(this._self, this._then);

  final _WordFillProblem _self;
  final $Res Function(_WordFillProblem) _then;

/// Create a copy of WordFillProblem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? word = null,Object? blankIndex = null,Object? imagePath = null,}) {
  return _then(_WordFillProblem(
word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,blankIndex: null == blankIndex ? _self.blankIndex : blankIndex // ignore: cast_nullable_to_non_nullable
as int,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$WordFillSession {

 int get index; int get total; List<bool?> get results; WordFillProblem? get currentProblem; int get wrongAttempts; String get userInput;
/// Create a copy of WordFillSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordFillSessionCopyWith<WordFillSession> get copyWith => _$WordFillSessionCopyWithImpl<WordFillSession>(this as WordFillSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordFillSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&(identical(other.wrongAttempts, wrongAttempts) || other.wrongAttempts == wrongAttempts)&&(identical(other.userInput, userInput) || other.userInput == userInput));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(results),currentProblem,wrongAttempts,userInput);

@override
String toString() {
  return 'WordFillSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, wrongAttempts: $wrongAttempts, userInput: $userInput)';
}


}

/// @nodoc
abstract mixin class $WordFillSessionCopyWith<$Res>  {
  factory $WordFillSessionCopyWith(WordFillSession value, $Res Function(WordFillSession) _then) = _$WordFillSessionCopyWithImpl;
@useResult
$Res call({
 int index, int total, List<bool?> results, WordFillProblem? currentProblem, int wrongAttempts, String userInput
});


$WordFillProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class _$WordFillSessionCopyWithImpl<$Res>
    implements $WordFillSessionCopyWith<$Res> {
  _$WordFillSessionCopyWithImpl(this._self, this._then);

  final WordFillSession _self;
  final $Res Function(WordFillSession) _then;

/// Create a copy of WordFillSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? wrongAttempts = null,Object? userInput = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as WordFillProblem?,wrongAttempts: null == wrongAttempts ? _self.wrongAttempts : wrongAttempts // ignore: cast_nullable_to_non_nullable
as int,userInput: null == userInput ? _self.userInput : userInput // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of WordFillSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordFillProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $WordFillProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}


/// Adds pattern-matching-related methods to [WordFillSession].
extension WordFillSessionPatterns on WordFillSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordFillSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordFillSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordFillSession value)  $default,){
final _that = this;
switch (_that) {
case _WordFillSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordFillSession value)?  $default,){
final _that = this;
switch (_that) {
case _WordFillSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  WordFillProblem? currentProblem,  int wrongAttempts,  String userInput)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordFillSession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAttempts,_that.userInput);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  WordFillProblem? currentProblem,  int wrongAttempts,  String userInput)  $default,) {final _that = this;
switch (_that) {
case _WordFillSession():
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAttempts,_that.userInput);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  int total,  List<bool?> results,  WordFillProblem? currentProblem,  int wrongAttempts,  String userInput)?  $default,) {final _that = this;
switch (_that) {
case _WordFillSession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAttempts,_that.userInput);case _:
  return null;

}
}

}

/// @nodoc


class _WordFillSession extends WordFillSession {
  const _WordFillSession({required this.index, required this.total, required final  List<bool?> results, this.currentProblem, this.wrongAttempts = 0, this.userInput = ''}): _results = results,super._();
  

@override final  int index;
@override final  int total;
 final  List<bool?> _results;
@override List<bool?> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override final  WordFillProblem? currentProblem;
@override@JsonKey() final  int wrongAttempts;
@override@JsonKey() final  String userInput;

/// Create a copy of WordFillSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordFillSessionCopyWith<_WordFillSession> get copyWith => __$WordFillSessionCopyWithImpl<_WordFillSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordFillSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&(identical(other.wrongAttempts, wrongAttempts) || other.wrongAttempts == wrongAttempts)&&(identical(other.userInput, userInput) || other.userInput == userInput));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(_results),currentProblem,wrongAttempts,userInput);

@override
String toString() {
  return 'WordFillSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, wrongAttempts: $wrongAttempts, userInput: $userInput)';
}


}

/// @nodoc
abstract mixin class _$WordFillSessionCopyWith<$Res> implements $WordFillSessionCopyWith<$Res> {
  factory _$WordFillSessionCopyWith(_WordFillSession value, $Res Function(_WordFillSession) _then) = __$WordFillSessionCopyWithImpl;
@override @useResult
$Res call({
 int index, int total, List<bool?> results, WordFillProblem? currentProblem, int wrongAttempts, String userInput
});


@override $WordFillProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class __$WordFillSessionCopyWithImpl<$Res>
    implements _$WordFillSessionCopyWith<$Res> {
  __$WordFillSessionCopyWithImpl(this._self, this._then);

  final _WordFillSession _self;
  final $Res Function(_WordFillSession) _then;

/// Create a copy of WordFillSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? wrongAttempts = null,Object? userInput = null,}) {
  return _then(_WordFillSession(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as WordFillProblem?,wrongAttempts: null == wrongAttempts ? _self.wrongAttempts : wrongAttempts // ignore: cast_nullable_to_non_nullable
as int,userInput: null == userInput ? _self.userInput : userInput // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of WordFillSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordFillProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $WordFillProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}

/// @nodoc
mixin _$WordFillState {

 CommonGamePhase get phase; WordFillSettings? get settings; WordFillSession? get session; int get epoch;
/// Create a copy of WordFillState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordFillStateCopyWith<WordFillState> get copyWith => _$WordFillStateCopyWithImpl<WordFillState>(this as WordFillState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordFillState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,epoch);

@override
String toString() {
  return 'WordFillState(phase: $phase, settings: $settings, session: $session, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class $WordFillStateCopyWith<$Res>  {
  factory $WordFillStateCopyWith(WordFillState value, $Res Function(WordFillState) _then) = _$WordFillStateCopyWithImpl;
@useResult
$Res call({
 CommonGamePhase phase, WordFillSettings? settings, WordFillSession? session, int epoch
});


$WordFillSettingsCopyWith<$Res>? get settings;$WordFillSessionCopyWith<$Res>? get session;

}
/// @nodoc
class _$WordFillStateCopyWithImpl<$Res>
    implements $WordFillStateCopyWith<$Res> {
  _$WordFillStateCopyWithImpl(this._self, this._then);

  final WordFillState _self;
  final $Res Function(WordFillState) _then;

/// Create a copy of WordFillState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? epoch = null,}) {
  return _then(_self.copyWith(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as WordFillSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as WordFillSession?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of WordFillState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordFillSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $WordFillSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of WordFillState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordFillSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $WordFillSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}


/// Adds pattern-matching-related methods to [WordFillState].
extension WordFillStatePatterns on WordFillState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordFillState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordFillState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordFillState value)  $default,){
final _that = this;
switch (_that) {
case _WordFillState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordFillState value)?  $default,){
final _that = this;
switch (_that) {
case _WordFillState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CommonGamePhase phase,  WordFillSettings? settings,  WordFillSession? session,  int epoch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordFillState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CommonGamePhase phase,  WordFillSettings? settings,  WordFillSession? session,  int epoch)  $default,) {final _that = this;
switch (_that) {
case _WordFillState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CommonGamePhase phase,  WordFillSettings? settings,  WordFillSession? session,  int epoch)?  $default,) {final _that = this;
switch (_that) {
case _WordFillState() when $default != null:
return $default(_that.phase,_that.settings,_that.session,_that.epoch);case _:
  return null;

}
}

}

/// @nodoc


class _WordFillState extends WordFillState {
  const _WordFillState({this.phase = CommonGamePhase.ready, this.settings, this.session, this.epoch = 0}): super._();
  

@override@JsonKey() final  CommonGamePhase phase;
@override final  WordFillSettings? settings;
@override final  WordFillSession? session;
@override@JsonKey() final  int epoch;

/// Create a copy of WordFillState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordFillStateCopyWith<_WordFillState> get copyWith => __$WordFillStateCopyWithImpl<_WordFillState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordFillState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,epoch);

@override
String toString() {
  return 'WordFillState(phase: $phase, settings: $settings, session: $session, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class _$WordFillStateCopyWith<$Res> implements $WordFillStateCopyWith<$Res> {
  factory _$WordFillStateCopyWith(_WordFillState value, $Res Function(_WordFillState) _then) = __$WordFillStateCopyWithImpl;
@override @useResult
$Res call({
 CommonGamePhase phase, WordFillSettings? settings, WordFillSession? session, int epoch
});


@override $WordFillSettingsCopyWith<$Res>? get settings;@override $WordFillSessionCopyWith<$Res>? get session;

}
/// @nodoc
class __$WordFillStateCopyWithImpl<$Res>
    implements _$WordFillStateCopyWith<$Res> {
  __$WordFillStateCopyWithImpl(this._self, this._then);

  final _WordFillState _self;
  final $Res Function(_WordFillState) _then;

/// Create a copy of WordFillState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? epoch = null,}) {
  return _then(_WordFillState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as WordFillSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as WordFillSession?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of WordFillState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordFillSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $WordFillSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of WordFillState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordFillSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $WordFillSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

// dart format on
