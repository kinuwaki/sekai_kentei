// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shiritori_maze_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShiritoriRoute {

 List<String> get correctPath;// しりとりの正解ルート（例: ['けむし', 'しか', 'かめ', ...]）
 List<String> get decoyWords;
/// Create a copy of ShiritoriRoute
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShiritoriRouteCopyWith<ShiritoriRoute> get copyWith => _$ShiritoriRouteCopyWithImpl<ShiritoriRoute>(this as ShiritoriRoute, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShiritoriRoute&&const DeepCollectionEquality().equals(other.correctPath, correctPath)&&const DeepCollectionEquality().equals(other.decoyWords, decoyWords));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(correctPath),const DeepCollectionEquality().hash(decoyWords));

@override
String toString() {
  return 'ShiritoriRoute(correctPath: $correctPath, decoyWords: $decoyWords)';
}


}

/// @nodoc
abstract mixin class $ShiritoriRouteCopyWith<$Res>  {
  factory $ShiritoriRouteCopyWith(ShiritoriRoute value, $Res Function(ShiritoriRoute) _then) = _$ShiritoriRouteCopyWithImpl;
@useResult
$Res call({
 List<String> correctPath, List<String> decoyWords
});




}
/// @nodoc
class _$ShiritoriRouteCopyWithImpl<$Res>
    implements $ShiritoriRouteCopyWith<$Res> {
  _$ShiritoriRouteCopyWithImpl(this._self, this._then);

  final ShiritoriRoute _self;
  final $Res Function(ShiritoriRoute) _then;

/// Create a copy of ShiritoriRoute
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? correctPath = null,Object? decoyWords = null,}) {
  return _then(_self.copyWith(
correctPath: null == correctPath ? _self.correctPath : correctPath // ignore: cast_nullable_to_non_nullable
as List<String>,decoyWords: null == decoyWords ? _self.decoyWords : decoyWords // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ShiritoriRoute].
extension ShiritoriRoutePatterns on ShiritoriRoute {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShiritoriRoute value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShiritoriRoute() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShiritoriRoute value)  $default,){
final _that = this;
switch (_that) {
case _ShiritoriRoute():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShiritoriRoute value)?  $default,){
final _that = this;
switch (_that) {
case _ShiritoriRoute() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> correctPath,  List<String> decoyWords)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShiritoriRoute() when $default != null:
return $default(_that.correctPath,_that.decoyWords);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> correctPath,  List<String> decoyWords)  $default,) {final _that = this;
switch (_that) {
case _ShiritoriRoute():
return $default(_that.correctPath,_that.decoyWords);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> correctPath,  List<String> decoyWords)?  $default,) {final _that = this;
switch (_that) {
case _ShiritoriRoute() when $default != null:
return $default(_that.correctPath,_that.decoyWords);case _:
  return null;

}
}

}

/// @nodoc


class _ShiritoriRoute extends ShiritoriRoute {
  const _ShiritoriRoute({required final  List<String> correctPath, required final  List<String> decoyWords}): _correctPath = correctPath,_decoyWords = decoyWords,super._();
  

 final  List<String> _correctPath;
@override List<String> get correctPath {
  if (_correctPath is EqualUnmodifiableListView) return _correctPath;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_correctPath);
}

// しりとりの正解ルート（例: ['けむし', 'しか', 'かめ', ...]）
 final  List<String> _decoyWords;
// しりとりの正解ルート（例: ['けむし', 'しか', 'かめ', ...]）
@override List<String> get decoyWords {
  if (_decoyWords is EqualUnmodifiableListView) return _decoyWords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_decoyWords);
}


/// Create a copy of ShiritoriRoute
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShiritoriRouteCopyWith<_ShiritoriRoute> get copyWith => __$ShiritoriRouteCopyWithImpl<_ShiritoriRoute>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShiritoriRoute&&const DeepCollectionEquality().equals(other._correctPath, _correctPath)&&const DeepCollectionEquality().equals(other._decoyWords, _decoyWords));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_correctPath),const DeepCollectionEquality().hash(_decoyWords));

@override
String toString() {
  return 'ShiritoriRoute(correctPath: $correctPath, decoyWords: $decoyWords)';
}


}

/// @nodoc
abstract mixin class _$ShiritoriRouteCopyWith<$Res> implements $ShiritoriRouteCopyWith<$Res> {
  factory _$ShiritoriRouteCopyWith(_ShiritoriRoute value, $Res Function(_ShiritoriRoute) _then) = __$ShiritoriRouteCopyWithImpl;
@override @useResult
$Res call({
 List<String> correctPath, List<String> decoyWords
});




}
/// @nodoc
class __$ShiritoriRouteCopyWithImpl<$Res>
    implements _$ShiritoriRouteCopyWith<$Res> {
  __$ShiritoriRouteCopyWithImpl(this._self, this._then);

  final _ShiritoriRoute _self;
  final $Res Function(_ShiritoriRoute) _then;

/// Create a copy of ShiritoriRoute
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? correctPath = null,Object? decoyWords = null,}) {
  return _then(_ShiritoriRoute(
correctPath: null == correctPath ? _self._correctPath : correctPath // ignore: cast_nullable_to_non_nullable
as List<String>,decoyWords: null == decoyWords ? _self._decoyWords : decoyWords // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$ShiritoriMazeSettings {

 int get questionCount;// 問題数
 int get rows;// グリッドの行数（4x3固定）
 int get cols;
/// Create a copy of ShiritoriMazeSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShiritoriMazeSettingsCopyWith<ShiritoriMazeSettings> get copyWith => _$ShiritoriMazeSettingsCopyWithImpl<ShiritoriMazeSettings>(this as ShiritoriMazeSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShiritoriMazeSettings&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.rows, rows) || other.rows == rows)&&(identical(other.cols, cols) || other.cols == cols));
}


@override
int get hashCode => Object.hash(runtimeType,questionCount,rows,cols);

@override
String toString() {
  return 'ShiritoriMazeSettings(questionCount: $questionCount, rows: $rows, cols: $cols)';
}


}

/// @nodoc
abstract mixin class $ShiritoriMazeSettingsCopyWith<$Res>  {
  factory $ShiritoriMazeSettingsCopyWith(ShiritoriMazeSettings value, $Res Function(ShiritoriMazeSettings) _then) = _$ShiritoriMazeSettingsCopyWithImpl;
@useResult
$Res call({
 int questionCount, int rows, int cols
});




}
/// @nodoc
class _$ShiritoriMazeSettingsCopyWithImpl<$Res>
    implements $ShiritoriMazeSettingsCopyWith<$Res> {
  _$ShiritoriMazeSettingsCopyWithImpl(this._self, this._then);

  final ShiritoriMazeSettings _self;
  final $Res Function(ShiritoriMazeSettings) _then;

/// Create a copy of ShiritoriMazeSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionCount = null,Object? rows = null,Object? cols = null,}) {
  return _then(_self.copyWith(
questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as int,cols: null == cols ? _self.cols : cols // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ShiritoriMazeSettings].
extension ShiritoriMazeSettingsPatterns on ShiritoriMazeSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShiritoriMazeSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShiritoriMazeSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShiritoriMazeSettings value)  $default,){
final _that = this;
switch (_that) {
case _ShiritoriMazeSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShiritoriMazeSettings value)?  $default,){
final _that = this;
switch (_that) {
case _ShiritoriMazeSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int questionCount,  int rows,  int cols)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShiritoriMazeSettings() when $default != null:
return $default(_that.questionCount,_that.rows,_that.cols);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int questionCount,  int rows,  int cols)  $default,) {final _that = this;
switch (_that) {
case _ShiritoriMazeSettings():
return $default(_that.questionCount,_that.rows,_that.cols);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int questionCount,  int rows,  int cols)?  $default,) {final _that = this;
switch (_that) {
case _ShiritoriMazeSettings() when $default != null:
return $default(_that.questionCount,_that.rows,_that.cols);case _:
  return null;

}
}

}

/// @nodoc


class _ShiritoriMazeSettings extends ShiritoriMazeSettings {
  const _ShiritoriMazeSettings({this.questionCount = 3, this.rows = 3, this.cols = 4}): super._();
  

@override@JsonKey() final  int questionCount;
// 問題数
@override@JsonKey() final  int rows;
// グリッドの行数（4x3固定）
@override@JsonKey() final  int cols;

/// Create a copy of ShiritoriMazeSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShiritoriMazeSettingsCopyWith<_ShiritoriMazeSettings> get copyWith => __$ShiritoriMazeSettingsCopyWithImpl<_ShiritoriMazeSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShiritoriMazeSettings&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.rows, rows) || other.rows == rows)&&(identical(other.cols, cols) || other.cols == cols));
}


@override
int get hashCode => Object.hash(runtimeType,questionCount,rows,cols);

@override
String toString() {
  return 'ShiritoriMazeSettings(questionCount: $questionCount, rows: $rows, cols: $cols)';
}


}

/// @nodoc
abstract mixin class _$ShiritoriMazeSettingsCopyWith<$Res> implements $ShiritoriMazeSettingsCopyWith<$Res> {
  factory _$ShiritoriMazeSettingsCopyWith(_ShiritoriMazeSettings value, $Res Function(_ShiritoriMazeSettings) _then) = __$ShiritoriMazeSettingsCopyWithImpl;
@override @useResult
$Res call({
 int questionCount, int rows, int cols
});




}
/// @nodoc
class __$ShiritoriMazeSettingsCopyWithImpl<$Res>
    implements _$ShiritoriMazeSettingsCopyWith<$Res> {
  __$ShiritoriMazeSettingsCopyWithImpl(this._self, this._then);

  final _ShiritoriMazeSettings _self;
  final $Res Function(_ShiritoriMazeSettings) _then;

/// Create a copy of ShiritoriMazeSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionCount = null,Object? rows = null,Object? cols = null,}) {
  return _then(_ShiritoriMazeSettings(
questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as int,cols: null == cols ? _self.cols : cols // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ShiritoriMazeProblem {

 ShiritoriRoute get route;// しりとりルート
 Map<int, String> get gridMap;// グリッド位置→単語のマッピング
 List<int> get correctPath;
/// Create a copy of ShiritoriMazeProblem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShiritoriMazeProblemCopyWith<ShiritoriMazeProblem> get copyWith => _$ShiritoriMazeProblemCopyWithImpl<ShiritoriMazeProblem>(this as ShiritoriMazeProblem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShiritoriMazeProblem&&(identical(other.route, route) || other.route == route)&&const DeepCollectionEquality().equals(other.gridMap, gridMap)&&const DeepCollectionEquality().equals(other.correctPath, correctPath));
}


@override
int get hashCode => Object.hash(runtimeType,route,const DeepCollectionEquality().hash(gridMap),const DeepCollectionEquality().hash(correctPath));

@override
String toString() {
  return 'ShiritoriMazeProblem(route: $route, gridMap: $gridMap, correctPath: $correctPath)';
}


}

/// @nodoc
abstract mixin class $ShiritoriMazeProblemCopyWith<$Res>  {
  factory $ShiritoriMazeProblemCopyWith(ShiritoriMazeProblem value, $Res Function(ShiritoriMazeProblem) _then) = _$ShiritoriMazeProblemCopyWithImpl;
@useResult
$Res call({
 ShiritoriRoute route, Map<int, String> gridMap, List<int> correctPath
});


$ShiritoriRouteCopyWith<$Res> get route;

}
/// @nodoc
class _$ShiritoriMazeProblemCopyWithImpl<$Res>
    implements $ShiritoriMazeProblemCopyWith<$Res> {
  _$ShiritoriMazeProblemCopyWithImpl(this._self, this._then);

  final ShiritoriMazeProblem _self;
  final $Res Function(ShiritoriMazeProblem) _then;

/// Create a copy of ShiritoriMazeProblem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? route = null,Object? gridMap = null,Object? correctPath = null,}) {
  return _then(_self.copyWith(
route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as ShiritoriRoute,gridMap: null == gridMap ? _self.gridMap : gridMap // ignore: cast_nullable_to_non_nullable
as Map<int, String>,correctPath: null == correctPath ? _self.correctPath : correctPath // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}
/// Create a copy of ShiritoriMazeProblem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShiritoriRouteCopyWith<$Res> get route {
  
  return $ShiritoriRouteCopyWith<$Res>(_self.route, (value) {
    return _then(_self.copyWith(route: value));
  });
}
}


/// Adds pattern-matching-related methods to [ShiritoriMazeProblem].
extension ShiritoriMazeProblemPatterns on ShiritoriMazeProblem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShiritoriMazeProblem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShiritoriMazeProblem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShiritoriMazeProblem value)  $default,){
final _that = this;
switch (_that) {
case _ShiritoriMazeProblem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShiritoriMazeProblem value)?  $default,){
final _that = this;
switch (_that) {
case _ShiritoriMazeProblem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ShiritoriRoute route,  Map<int, String> gridMap,  List<int> correctPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShiritoriMazeProblem() when $default != null:
return $default(_that.route,_that.gridMap,_that.correctPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ShiritoriRoute route,  Map<int, String> gridMap,  List<int> correctPath)  $default,) {final _that = this;
switch (_that) {
case _ShiritoriMazeProblem():
return $default(_that.route,_that.gridMap,_that.correctPath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ShiritoriRoute route,  Map<int, String> gridMap,  List<int> correctPath)?  $default,) {final _that = this;
switch (_that) {
case _ShiritoriMazeProblem() when $default != null:
return $default(_that.route,_that.gridMap,_that.correctPath);case _:
  return null;

}
}

}

/// @nodoc


class _ShiritoriMazeProblem extends ShiritoriMazeProblem {
  const _ShiritoriMazeProblem({required this.route, required final  Map<int, String> gridMap, required final  List<int> correctPath}): _gridMap = gridMap,_correctPath = correctPath,super._();
  

@override final  ShiritoriRoute route;
// しりとりルート
 final  Map<int, String> _gridMap;
// しりとりルート
@override Map<int, String> get gridMap {
  if (_gridMap is EqualUnmodifiableMapView) return _gridMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_gridMap);
}

// グリッド位置→単語のマッピング
 final  List<int> _correctPath;
// グリッド位置→単語のマッピング
@override List<int> get correctPath {
  if (_correctPath is EqualUnmodifiableListView) return _correctPath;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_correctPath);
}


/// Create a copy of ShiritoriMazeProblem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShiritoriMazeProblemCopyWith<_ShiritoriMazeProblem> get copyWith => __$ShiritoriMazeProblemCopyWithImpl<_ShiritoriMazeProblem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShiritoriMazeProblem&&(identical(other.route, route) || other.route == route)&&const DeepCollectionEquality().equals(other._gridMap, _gridMap)&&const DeepCollectionEquality().equals(other._correctPath, _correctPath));
}


@override
int get hashCode => Object.hash(runtimeType,route,const DeepCollectionEquality().hash(_gridMap),const DeepCollectionEquality().hash(_correctPath));

@override
String toString() {
  return 'ShiritoriMazeProblem(route: $route, gridMap: $gridMap, correctPath: $correctPath)';
}


}

/// @nodoc
abstract mixin class _$ShiritoriMazeProblemCopyWith<$Res> implements $ShiritoriMazeProblemCopyWith<$Res> {
  factory _$ShiritoriMazeProblemCopyWith(_ShiritoriMazeProblem value, $Res Function(_ShiritoriMazeProblem) _then) = __$ShiritoriMazeProblemCopyWithImpl;
@override @useResult
$Res call({
 ShiritoriRoute route, Map<int, String> gridMap, List<int> correctPath
});


@override $ShiritoriRouteCopyWith<$Res> get route;

}
/// @nodoc
class __$ShiritoriMazeProblemCopyWithImpl<$Res>
    implements _$ShiritoriMazeProblemCopyWith<$Res> {
  __$ShiritoriMazeProblemCopyWithImpl(this._self, this._then);

  final _ShiritoriMazeProblem _self;
  final $Res Function(_ShiritoriMazeProblem) _then;

/// Create a copy of ShiritoriMazeProblem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? route = null,Object? gridMap = null,Object? correctPath = null,}) {
  return _then(_ShiritoriMazeProblem(
route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as ShiritoriRoute,gridMap: null == gridMap ? _self._gridMap : gridMap // ignore: cast_nullable_to_non_nullable
as Map<int, String>,correctPath: null == correctPath ? _self._correctPath : correctPath // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

/// Create a copy of ShiritoriMazeProblem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShiritoriRouteCopyWith<$Res> get route {
  
  return $ShiritoriRouteCopyWith<$Res>(_self.route, (value) {
    return _then(_self.copyWith(route: value));
  });
}
}

/// @nodoc
mixin _$ShiritoriMazeSession {

 int get index;// 現在の問題番号
 int get total;// 総問題数
 List<bool?> get results;// 結果配列
 ShiritoriMazeProblem? get currentProblem; List<int> get selectedPath;// 選択した経路
 int get wrongAttempts;
/// Create a copy of ShiritoriMazeSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShiritoriMazeSessionCopyWith<ShiritoriMazeSession> get copyWith => _$ShiritoriMazeSessionCopyWithImpl<ShiritoriMazeSession>(this as ShiritoriMazeSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShiritoriMazeSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&const DeepCollectionEquality().equals(other.selectedPath, selectedPath)&&(identical(other.wrongAttempts, wrongAttempts) || other.wrongAttempts == wrongAttempts));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(results),currentProblem,const DeepCollectionEquality().hash(selectedPath),wrongAttempts);

@override
String toString() {
  return 'ShiritoriMazeSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, selectedPath: $selectedPath, wrongAttempts: $wrongAttempts)';
}


}

/// @nodoc
abstract mixin class $ShiritoriMazeSessionCopyWith<$Res>  {
  factory $ShiritoriMazeSessionCopyWith(ShiritoriMazeSession value, $Res Function(ShiritoriMazeSession) _then) = _$ShiritoriMazeSessionCopyWithImpl;
@useResult
$Res call({
 int index, int total, List<bool?> results, ShiritoriMazeProblem? currentProblem, List<int> selectedPath, int wrongAttempts
});


$ShiritoriMazeProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class _$ShiritoriMazeSessionCopyWithImpl<$Res>
    implements $ShiritoriMazeSessionCopyWith<$Res> {
  _$ShiritoriMazeSessionCopyWithImpl(this._self, this._then);

  final ShiritoriMazeSession _self;
  final $Res Function(ShiritoriMazeSession) _then;

/// Create a copy of ShiritoriMazeSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? selectedPath = null,Object? wrongAttempts = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as ShiritoriMazeProblem?,selectedPath: null == selectedPath ? _self.selectedPath : selectedPath // ignore: cast_nullable_to_non_nullable
as List<int>,wrongAttempts: null == wrongAttempts ? _self.wrongAttempts : wrongAttempts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of ShiritoriMazeSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShiritoriMazeProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $ShiritoriMazeProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}


/// Adds pattern-matching-related methods to [ShiritoriMazeSession].
extension ShiritoriMazeSessionPatterns on ShiritoriMazeSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShiritoriMazeSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShiritoriMazeSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShiritoriMazeSession value)  $default,){
final _that = this;
switch (_that) {
case _ShiritoriMazeSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShiritoriMazeSession value)?  $default,){
final _that = this;
switch (_that) {
case _ShiritoriMazeSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  ShiritoriMazeProblem? currentProblem,  List<int> selectedPath,  int wrongAttempts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShiritoriMazeSession() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  ShiritoriMazeProblem? currentProblem,  List<int> selectedPath,  int wrongAttempts)  $default,) {final _that = this;
switch (_that) {
case _ShiritoriMazeSession():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  int total,  List<bool?> results,  ShiritoriMazeProblem? currentProblem,  List<int> selectedPath,  int wrongAttempts)?  $default,) {final _that = this;
switch (_that) {
case _ShiritoriMazeSession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.selectedPath,_that.wrongAttempts);case _:
  return null;

}
}

}

/// @nodoc


class _ShiritoriMazeSession extends ShiritoriMazeSession {
  const _ShiritoriMazeSession({required this.index, required this.total, required final  List<bool?> results, this.currentProblem, final  List<int> selectedPath = const [], this.wrongAttempts = 0}): _results = results,_selectedPath = selectedPath,super._();
  

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

// 結果配列
@override final  ShiritoriMazeProblem? currentProblem;
 final  List<int> _selectedPath;
@override@JsonKey() List<int> get selectedPath {
  if (_selectedPath is EqualUnmodifiableListView) return _selectedPath;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedPath);
}

// 選択した経路
@override@JsonKey() final  int wrongAttempts;

/// Create a copy of ShiritoriMazeSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShiritoriMazeSessionCopyWith<_ShiritoriMazeSession> get copyWith => __$ShiritoriMazeSessionCopyWithImpl<_ShiritoriMazeSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShiritoriMazeSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&const DeepCollectionEquality().equals(other._selectedPath, _selectedPath)&&(identical(other.wrongAttempts, wrongAttempts) || other.wrongAttempts == wrongAttempts));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(_results),currentProblem,const DeepCollectionEquality().hash(_selectedPath),wrongAttempts);

@override
String toString() {
  return 'ShiritoriMazeSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, selectedPath: $selectedPath, wrongAttempts: $wrongAttempts)';
}


}

/// @nodoc
abstract mixin class _$ShiritoriMazeSessionCopyWith<$Res> implements $ShiritoriMazeSessionCopyWith<$Res> {
  factory _$ShiritoriMazeSessionCopyWith(_ShiritoriMazeSession value, $Res Function(_ShiritoriMazeSession) _then) = __$ShiritoriMazeSessionCopyWithImpl;
@override @useResult
$Res call({
 int index, int total, List<bool?> results, ShiritoriMazeProblem? currentProblem, List<int> selectedPath, int wrongAttempts
});


@override $ShiritoriMazeProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class __$ShiritoriMazeSessionCopyWithImpl<$Res>
    implements _$ShiritoriMazeSessionCopyWith<$Res> {
  __$ShiritoriMazeSessionCopyWithImpl(this._self, this._then);

  final _ShiritoriMazeSession _self;
  final $Res Function(_ShiritoriMazeSession) _then;

/// Create a copy of ShiritoriMazeSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? selectedPath = null,Object? wrongAttempts = null,}) {
  return _then(_ShiritoriMazeSession(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as ShiritoriMazeProblem?,selectedPath: null == selectedPath ? _self._selectedPath : selectedPath // ignore: cast_nullable_to_non_nullable
as List<int>,wrongAttempts: null == wrongAttempts ? _self.wrongAttempts : wrongAttempts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of ShiritoriMazeSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShiritoriMazeProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $ShiritoriMazeProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}

/// @nodoc
mixin _$ShiritoriMazeState {

 CommonGamePhase get phase; ShiritoriMazeSettings? get settings; ShiritoriMazeSession? get session; int get epoch;
/// Create a copy of ShiritoriMazeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShiritoriMazeStateCopyWith<ShiritoriMazeState> get copyWith => _$ShiritoriMazeStateCopyWithImpl<ShiritoriMazeState>(this as ShiritoriMazeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShiritoriMazeState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,epoch);

@override
String toString() {
  return 'ShiritoriMazeState(phase: $phase, settings: $settings, session: $session, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class $ShiritoriMazeStateCopyWith<$Res>  {
  factory $ShiritoriMazeStateCopyWith(ShiritoriMazeState value, $Res Function(ShiritoriMazeState) _then) = _$ShiritoriMazeStateCopyWithImpl;
@useResult
$Res call({
 CommonGamePhase phase, ShiritoriMazeSettings? settings, ShiritoriMazeSession? session, int epoch
});


$ShiritoriMazeSettingsCopyWith<$Res>? get settings;$ShiritoriMazeSessionCopyWith<$Res>? get session;

}
/// @nodoc
class _$ShiritoriMazeStateCopyWithImpl<$Res>
    implements $ShiritoriMazeStateCopyWith<$Res> {
  _$ShiritoriMazeStateCopyWithImpl(this._self, this._then);

  final ShiritoriMazeState _self;
  final $Res Function(ShiritoriMazeState) _then;

/// Create a copy of ShiritoriMazeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? epoch = null,}) {
  return _then(_self.copyWith(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as ShiritoriMazeSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as ShiritoriMazeSession?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of ShiritoriMazeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShiritoriMazeSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $ShiritoriMazeSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of ShiritoriMazeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShiritoriMazeSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $ShiritoriMazeSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}


/// Adds pattern-matching-related methods to [ShiritoriMazeState].
extension ShiritoriMazeStatePatterns on ShiritoriMazeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShiritoriMazeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShiritoriMazeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShiritoriMazeState value)  $default,){
final _that = this;
switch (_that) {
case _ShiritoriMazeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShiritoriMazeState value)?  $default,){
final _that = this;
switch (_that) {
case _ShiritoriMazeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CommonGamePhase phase,  ShiritoriMazeSettings? settings,  ShiritoriMazeSession? session,  int epoch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShiritoriMazeState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CommonGamePhase phase,  ShiritoriMazeSettings? settings,  ShiritoriMazeSession? session,  int epoch)  $default,) {final _that = this;
switch (_that) {
case _ShiritoriMazeState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CommonGamePhase phase,  ShiritoriMazeSettings? settings,  ShiritoriMazeSession? session,  int epoch)?  $default,) {final _that = this;
switch (_that) {
case _ShiritoriMazeState() when $default != null:
return $default(_that.phase,_that.settings,_that.session,_that.epoch);case _:
  return null;

}
}

}

/// @nodoc


class _ShiritoriMazeState extends ShiritoriMazeState {
  const _ShiritoriMazeState({this.phase = CommonGamePhase.ready, this.settings, this.session, this.epoch = 0}): super._();
  

@override@JsonKey() final  CommonGamePhase phase;
@override final  ShiritoriMazeSettings? settings;
@override final  ShiritoriMazeSession? session;
@override@JsonKey() final  int epoch;

/// Create a copy of ShiritoriMazeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShiritoriMazeStateCopyWith<_ShiritoriMazeState> get copyWith => __$ShiritoriMazeStateCopyWithImpl<_ShiritoriMazeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShiritoriMazeState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,epoch);

@override
String toString() {
  return 'ShiritoriMazeState(phase: $phase, settings: $settings, session: $session, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class _$ShiritoriMazeStateCopyWith<$Res> implements $ShiritoriMazeStateCopyWith<$Res> {
  factory _$ShiritoriMazeStateCopyWith(_ShiritoriMazeState value, $Res Function(_ShiritoriMazeState) _then) = __$ShiritoriMazeStateCopyWithImpl;
@override @useResult
$Res call({
 CommonGamePhase phase, ShiritoriMazeSettings? settings, ShiritoriMazeSession? session, int epoch
});


@override $ShiritoriMazeSettingsCopyWith<$Res>? get settings;@override $ShiritoriMazeSessionCopyWith<$Res>? get session;

}
/// @nodoc
class __$ShiritoriMazeStateCopyWithImpl<$Res>
    implements _$ShiritoriMazeStateCopyWith<$Res> {
  __$ShiritoriMazeStateCopyWithImpl(this._self, this._then);

  final _ShiritoriMazeState _self;
  final $Res Function(_ShiritoriMazeState) _then;

/// Create a copy of ShiritoriMazeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? epoch = null,}) {
  return _then(_ShiritoriMazeState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as ShiritoriMazeSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as ShiritoriMazeSession?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of ShiritoriMazeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShiritoriMazeSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $ShiritoriMazeSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of ShiritoriMazeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShiritoriMazeSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $ShiritoriMazeSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

// dart format on
