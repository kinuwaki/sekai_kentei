// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shape_matching_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TileSpec {

 GeoShape get shape; GeoVariant get variant; GeoColor get color;
/// Create a copy of TileSpec
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TileSpecCopyWith<TileSpec> get copyWith => _$TileSpecCopyWithImpl<TileSpec>(this as TileSpec, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TileSpec&&(identical(other.shape, shape) || other.shape == shape)&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode => Object.hash(runtimeType,shape,variant,color);

@override
String toString() {
  return 'TileSpec(shape: $shape, variant: $variant, color: $color)';
}


}

/// @nodoc
abstract mixin class $TileSpecCopyWith<$Res>  {
  factory $TileSpecCopyWith(TileSpec value, $Res Function(TileSpec) _then) = _$TileSpecCopyWithImpl;
@useResult
$Res call({
 GeoShape shape, GeoVariant variant, GeoColor color
});




}
/// @nodoc
class _$TileSpecCopyWithImpl<$Res>
    implements $TileSpecCopyWith<$Res> {
  _$TileSpecCopyWithImpl(this._self, this._then);

  final TileSpec _self;
  final $Res Function(TileSpec) _then;

/// Create a copy of TileSpec
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shape = null,Object? variant = null,Object? color = null,}) {
  return _then(_self.copyWith(
shape: null == shape ? _self.shape : shape // ignore: cast_nullable_to_non_nullable
as GeoShape,variant: null == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as GeoVariant,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as GeoColor,
  ));
}

}


/// Adds pattern-matching-related methods to [TileSpec].
extension TileSpecPatterns on TileSpec {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TileSpec value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TileSpec() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TileSpec value)  $default,){
final _that = this;
switch (_that) {
case _TileSpec():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TileSpec value)?  $default,){
final _that = this;
switch (_that) {
case _TileSpec() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GeoShape shape,  GeoVariant variant,  GeoColor color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TileSpec() when $default != null:
return $default(_that.shape,_that.variant,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GeoShape shape,  GeoVariant variant,  GeoColor color)  $default,) {final _that = this;
switch (_that) {
case _TileSpec():
return $default(_that.shape,_that.variant,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GeoShape shape,  GeoVariant variant,  GeoColor color)?  $default,) {final _that = this;
switch (_that) {
case _TileSpec() when $default != null:
return $default(_that.shape,_that.variant,_that.color);case _:
  return null;

}
}

}

/// @nodoc


class _TileSpec extends TileSpec {
  const _TileSpec({required this.shape, required this.variant, required this.color}): super._();
  

@override final  GeoShape shape;
@override final  GeoVariant variant;
@override final  GeoColor color;

/// Create a copy of TileSpec
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TileSpecCopyWith<_TileSpec> get copyWith => __$TileSpecCopyWithImpl<_TileSpec>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TileSpec&&(identical(other.shape, shape) || other.shape == shape)&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode => Object.hash(runtimeType,shape,variant,color);

@override
String toString() {
  return 'TileSpec(shape: $shape, variant: $variant, color: $color)';
}


}

/// @nodoc
abstract mixin class _$TileSpecCopyWith<$Res> implements $TileSpecCopyWith<$Res> {
  factory _$TileSpecCopyWith(_TileSpec value, $Res Function(_TileSpec) _then) = __$TileSpecCopyWithImpl;
@override @useResult
$Res call({
 GeoShape shape, GeoVariant variant, GeoColor color
});




}
/// @nodoc
class __$TileSpecCopyWithImpl<$Res>
    implements _$TileSpecCopyWith<$Res> {
  __$TileSpecCopyWithImpl(this._self, this._then);

  final _TileSpec _self;
  final $Res Function(_TileSpec) _then;

/// Create a copy of TileSpec
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shape = null,Object? variant = null,Object? color = null,}) {
  return _then(_TileSpec(
shape: null == shape ? _self.shape : shape // ignore: cast_nullable_to_non_nullable
as GeoShape,variant: null == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as GeoVariant,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as GeoColor,
  ));
}


}

/// @nodoc
mixin _$ShapeMatchingSettings {

 int get rows; int get cols; int get targetCountMin; int get targetCountMax; int get questionCount; int get seed;
/// Create a copy of ShapeMatchingSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShapeMatchingSettingsCopyWith<ShapeMatchingSettings> get copyWith => _$ShapeMatchingSettingsCopyWithImpl<ShapeMatchingSettings>(this as ShapeMatchingSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShapeMatchingSettings&&(identical(other.rows, rows) || other.rows == rows)&&(identical(other.cols, cols) || other.cols == cols)&&(identical(other.targetCountMin, targetCountMin) || other.targetCountMin == targetCountMin)&&(identical(other.targetCountMax, targetCountMax) || other.targetCountMax == targetCountMax)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.seed, seed) || other.seed == seed));
}


@override
int get hashCode => Object.hash(runtimeType,rows,cols,targetCountMin,targetCountMax,questionCount,seed);

@override
String toString() {
  return 'ShapeMatchingSettings(rows: $rows, cols: $cols, targetCountMin: $targetCountMin, targetCountMax: $targetCountMax, questionCount: $questionCount, seed: $seed)';
}


}

/// @nodoc
abstract mixin class $ShapeMatchingSettingsCopyWith<$Res>  {
  factory $ShapeMatchingSettingsCopyWith(ShapeMatchingSettings value, $Res Function(ShapeMatchingSettings) _then) = _$ShapeMatchingSettingsCopyWithImpl;
@useResult
$Res call({
 int rows, int cols, int targetCountMin, int targetCountMax, int questionCount, int seed
});




}
/// @nodoc
class _$ShapeMatchingSettingsCopyWithImpl<$Res>
    implements $ShapeMatchingSettingsCopyWith<$Res> {
  _$ShapeMatchingSettingsCopyWithImpl(this._self, this._then);

  final ShapeMatchingSettings _self;
  final $Res Function(ShapeMatchingSettings) _then;

/// Create a copy of ShapeMatchingSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rows = null,Object? cols = null,Object? targetCountMin = null,Object? targetCountMax = null,Object? questionCount = null,Object? seed = null,}) {
  return _then(_self.copyWith(
rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as int,cols: null == cols ? _self.cols : cols // ignore: cast_nullable_to_non_nullable
as int,targetCountMin: null == targetCountMin ? _self.targetCountMin : targetCountMin // ignore: cast_nullable_to_non_nullable
as int,targetCountMax: null == targetCountMax ? _self.targetCountMax : targetCountMax // ignore: cast_nullable_to_non_nullable
as int,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,seed: null == seed ? _self.seed : seed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ShapeMatchingSettings].
extension ShapeMatchingSettingsPatterns on ShapeMatchingSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShapeMatchingSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShapeMatchingSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShapeMatchingSettings value)  $default,){
final _that = this;
switch (_that) {
case _ShapeMatchingSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShapeMatchingSettings value)?  $default,){
final _that = this;
switch (_that) {
case _ShapeMatchingSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int rows,  int cols,  int targetCountMin,  int targetCountMax,  int questionCount,  int seed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShapeMatchingSettings() when $default != null:
return $default(_that.rows,_that.cols,_that.targetCountMin,_that.targetCountMax,_that.questionCount,_that.seed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int rows,  int cols,  int targetCountMin,  int targetCountMax,  int questionCount,  int seed)  $default,) {final _that = this;
switch (_that) {
case _ShapeMatchingSettings():
return $default(_that.rows,_that.cols,_that.targetCountMin,_that.targetCountMax,_that.questionCount,_that.seed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int rows,  int cols,  int targetCountMin,  int targetCountMax,  int questionCount,  int seed)?  $default,) {final _that = this;
switch (_that) {
case _ShapeMatchingSettings() when $default != null:
return $default(_that.rows,_that.cols,_that.targetCountMin,_that.targetCountMax,_that.questionCount,_that.seed);case _:
  return null;

}
}

}

/// @nodoc


class _ShapeMatchingSettings extends ShapeMatchingSettings {
  const _ShapeMatchingSettings({this.rows = 4, this.cols = 4, this.targetCountMin = 4, this.targetCountMax = 6, this.questionCount = 3, this.seed = 0}): super._();
  

@override@JsonKey() final  int rows;
@override@JsonKey() final  int cols;
@override@JsonKey() final  int targetCountMin;
@override@JsonKey() final  int targetCountMax;
@override@JsonKey() final  int questionCount;
@override@JsonKey() final  int seed;

/// Create a copy of ShapeMatchingSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShapeMatchingSettingsCopyWith<_ShapeMatchingSettings> get copyWith => __$ShapeMatchingSettingsCopyWithImpl<_ShapeMatchingSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShapeMatchingSettings&&(identical(other.rows, rows) || other.rows == rows)&&(identical(other.cols, cols) || other.cols == cols)&&(identical(other.targetCountMin, targetCountMin) || other.targetCountMin == targetCountMin)&&(identical(other.targetCountMax, targetCountMax) || other.targetCountMax == targetCountMax)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.seed, seed) || other.seed == seed));
}


@override
int get hashCode => Object.hash(runtimeType,rows,cols,targetCountMin,targetCountMax,questionCount,seed);

@override
String toString() {
  return 'ShapeMatchingSettings(rows: $rows, cols: $cols, targetCountMin: $targetCountMin, targetCountMax: $targetCountMax, questionCount: $questionCount, seed: $seed)';
}


}

/// @nodoc
abstract mixin class _$ShapeMatchingSettingsCopyWith<$Res> implements $ShapeMatchingSettingsCopyWith<$Res> {
  factory _$ShapeMatchingSettingsCopyWith(_ShapeMatchingSettings value, $Res Function(_ShapeMatchingSettings) _then) = __$ShapeMatchingSettingsCopyWithImpl;
@override @useResult
$Res call({
 int rows, int cols, int targetCountMin, int targetCountMax, int questionCount, int seed
});




}
/// @nodoc
class __$ShapeMatchingSettingsCopyWithImpl<$Res>
    implements _$ShapeMatchingSettingsCopyWith<$Res> {
  __$ShapeMatchingSettingsCopyWithImpl(this._self, this._then);

  final _ShapeMatchingSettings _self;
  final $Res Function(_ShapeMatchingSettings) _then;

/// Create a copy of ShapeMatchingSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rows = null,Object? cols = null,Object? targetCountMin = null,Object? targetCountMax = null,Object? questionCount = null,Object? seed = null,}) {
  return _then(_ShapeMatchingSettings(
rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as int,cols: null == cols ? _self.cols : cols // ignore: cast_nullable_to_non_nullable
as int,targetCountMin: null == targetCountMin ? _self.targetCountMin : targetCountMin // ignore: cast_nullable_to_non_nullable
as int,targetCountMax: null == targetCountMax ? _self.targetCountMax : targetCountMax // ignore: cast_nullable_to_non_nullable
as int,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,seed: null == seed ? _self.seed : seed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ShapeMatchingProblem {

 TileSpec get target;// お手本
 List<TileSpec> get grid;// グリッドのタイル
 Set<int> get answerIndices;// 正解のインデックス
 String get questionText;
/// Create a copy of ShapeMatchingProblem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShapeMatchingProblemCopyWith<ShapeMatchingProblem> get copyWith => _$ShapeMatchingProblemCopyWithImpl<ShapeMatchingProblem>(this as ShapeMatchingProblem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShapeMatchingProblem&&(identical(other.target, target) || other.target == target)&&const DeepCollectionEquality().equals(other.grid, grid)&&const DeepCollectionEquality().equals(other.answerIndices, answerIndices)&&(identical(other.questionText, questionText) || other.questionText == questionText));
}


@override
int get hashCode => Object.hash(runtimeType,target,const DeepCollectionEquality().hash(grid),const DeepCollectionEquality().hash(answerIndices),questionText);

@override
String toString() {
  return 'ShapeMatchingProblem(target: $target, grid: $grid, answerIndices: $answerIndices, questionText: $questionText)';
}


}

/// @nodoc
abstract mixin class $ShapeMatchingProblemCopyWith<$Res>  {
  factory $ShapeMatchingProblemCopyWith(ShapeMatchingProblem value, $Res Function(ShapeMatchingProblem) _then) = _$ShapeMatchingProblemCopyWithImpl;
@useResult
$Res call({
 TileSpec target, List<TileSpec> grid, Set<int> answerIndices, String questionText
});


$TileSpecCopyWith<$Res> get target;

}
/// @nodoc
class _$ShapeMatchingProblemCopyWithImpl<$Res>
    implements $ShapeMatchingProblemCopyWith<$Res> {
  _$ShapeMatchingProblemCopyWithImpl(this._self, this._then);

  final ShapeMatchingProblem _self;
  final $Res Function(ShapeMatchingProblem) _then;

/// Create a copy of ShapeMatchingProblem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? target = null,Object? grid = null,Object? answerIndices = null,Object? questionText = null,}) {
  return _then(_self.copyWith(
target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as TileSpec,grid: null == grid ? _self.grid : grid // ignore: cast_nullable_to_non_nullable
as List<TileSpec>,answerIndices: null == answerIndices ? _self.answerIndices : answerIndices // ignore: cast_nullable_to_non_nullable
as Set<int>,questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of ShapeMatchingProblem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TileSpecCopyWith<$Res> get target {
  
  return $TileSpecCopyWith<$Res>(_self.target, (value) {
    return _then(_self.copyWith(target: value));
  });
}
}


/// Adds pattern-matching-related methods to [ShapeMatchingProblem].
extension ShapeMatchingProblemPatterns on ShapeMatchingProblem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShapeMatchingProblem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShapeMatchingProblem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShapeMatchingProblem value)  $default,){
final _that = this;
switch (_that) {
case _ShapeMatchingProblem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShapeMatchingProblem value)?  $default,){
final _that = this;
switch (_that) {
case _ShapeMatchingProblem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TileSpec target,  List<TileSpec> grid,  Set<int> answerIndices,  String questionText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShapeMatchingProblem() when $default != null:
return $default(_that.target,_that.grid,_that.answerIndices,_that.questionText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TileSpec target,  List<TileSpec> grid,  Set<int> answerIndices,  String questionText)  $default,) {final _that = this;
switch (_that) {
case _ShapeMatchingProblem():
return $default(_that.target,_that.grid,_that.answerIndices,_that.questionText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TileSpec target,  List<TileSpec> grid,  Set<int> answerIndices,  String questionText)?  $default,) {final _that = this;
switch (_that) {
case _ShapeMatchingProblem() when $default != null:
return $default(_that.target,_that.grid,_that.answerIndices,_that.questionText);case _:
  return null;

}
}

}

/// @nodoc


class _ShapeMatchingProblem extends ShapeMatchingProblem {
  const _ShapeMatchingProblem({required this.target, required final  List<TileSpec> grid, required final  Set<int> answerIndices, required this.questionText}): _grid = grid,_answerIndices = answerIndices,super._();
  

@override final  TileSpec target;
// お手本
 final  List<TileSpec> _grid;
// お手本
@override List<TileSpec> get grid {
  if (_grid is EqualUnmodifiableListView) return _grid;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_grid);
}

// グリッドのタイル
 final  Set<int> _answerIndices;
// グリッドのタイル
@override Set<int> get answerIndices {
  if (_answerIndices is EqualUnmodifiableSetView) return _answerIndices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_answerIndices);
}

// 正解のインデックス
@override final  String questionText;

/// Create a copy of ShapeMatchingProblem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShapeMatchingProblemCopyWith<_ShapeMatchingProblem> get copyWith => __$ShapeMatchingProblemCopyWithImpl<_ShapeMatchingProblem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShapeMatchingProblem&&(identical(other.target, target) || other.target == target)&&const DeepCollectionEquality().equals(other._grid, _grid)&&const DeepCollectionEquality().equals(other._answerIndices, _answerIndices)&&(identical(other.questionText, questionText) || other.questionText == questionText));
}


@override
int get hashCode => Object.hash(runtimeType,target,const DeepCollectionEquality().hash(_grid),const DeepCollectionEquality().hash(_answerIndices),questionText);

@override
String toString() {
  return 'ShapeMatchingProblem(target: $target, grid: $grid, answerIndices: $answerIndices, questionText: $questionText)';
}


}

/// @nodoc
abstract mixin class _$ShapeMatchingProblemCopyWith<$Res> implements $ShapeMatchingProblemCopyWith<$Res> {
  factory _$ShapeMatchingProblemCopyWith(_ShapeMatchingProblem value, $Res Function(_ShapeMatchingProblem) _then) = __$ShapeMatchingProblemCopyWithImpl;
@override @useResult
$Res call({
 TileSpec target, List<TileSpec> grid, Set<int> answerIndices, String questionText
});


@override $TileSpecCopyWith<$Res> get target;

}
/// @nodoc
class __$ShapeMatchingProblemCopyWithImpl<$Res>
    implements _$ShapeMatchingProblemCopyWith<$Res> {
  __$ShapeMatchingProblemCopyWithImpl(this._self, this._then);

  final _ShapeMatchingProblem _self;
  final $Res Function(_ShapeMatchingProblem) _then;

/// Create a copy of ShapeMatchingProblem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? target = null,Object? grid = null,Object? answerIndices = null,Object? questionText = null,}) {
  return _then(_ShapeMatchingProblem(
target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as TileSpec,grid: null == grid ? _self._grid : grid // ignore: cast_nullable_to_non_nullable
as List<TileSpec>,answerIndices: null == answerIndices ? _self._answerIndices : answerIndices // ignore: cast_nullable_to_non_nullable
as Set<int>,questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of ShapeMatchingProblem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TileSpecCopyWith<$Res> get target {
  
  return $TileSpecCopyWith<$Res>(_self.target, (value) {
    return _then(_self.copyWith(target: value));
  });
}
}

/// @nodoc
mixin _$ShapeMatchingResult {

 Set<int> get selectedIndices; Set<int> get correctIndices; bool get isCorrect; bool get isPerfect;// 一発正解
 int get attemptCount;
/// Create a copy of ShapeMatchingResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShapeMatchingResultCopyWith<ShapeMatchingResult> get copyWith => _$ShapeMatchingResultCopyWithImpl<ShapeMatchingResult>(this as ShapeMatchingResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShapeMatchingResult&&const DeepCollectionEquality().equals(other.selectedIndices, selectedIndices)&&const DeepCollectionEquality().equals(other.correctIndices, correctIndices)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.isPerfect, isPerfect) || other.isPerfect == isPerfect)&&(identical(other.attemptCount, attemptCount) || other.attemptCount == attemptCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(selectedIndices),const DeepCollectionEquality().hash(correctIndices),isCorrect,isPerfect,attemptCount);

@override
String toString() {
  return 'ShapeMatchingResult(selectedIndices: $selectedIndices, correctIndices: $correctIndices, isCorrect: $isCorrect, isPerfect: $isPerfect, attemptCount: $attemptCount)';
}


}

/// @nodoc
abstract mixin class $ShapeMatchingResultCopyWith<$Res>  {
  factory $ShapeMatchingResultCopyWith(ShapeMatchingResult value, $Res Function(ShapeMatchingResult) _then) = _$ShapeMatchingResultCopyWithImpl;
@useResult
$Res call({
 Set<int> selectedIndices, Set<int> correctIndices, bool isCorrect, bool isPerfect, int attemptCount
});




}
/// @nodoc
class _$ShapeMatchingResultCopyWithImpl<$Res>
    implements $ShapeMatchingResultCopyWith<$Res> {
  _$ShapeMatchingResultCopyWithImpl(this._self, this._then);

  final ShapeMatchingResult _self;
  final $Res Function(ShapeMatchingResult) _then;

/// Create a copy of ShapeMatchingResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedIndices = null,Object? correctIndices = null,Object? isCorrect = null,Object? isPerfect = null,Object? attemptCount = null,}) {
  return _then(_self.copyWith(
selectedIndices: null == selectedIndices ? _self.selectedIndices : selectedIndices // ignore: cast_nullable_to_non_nullable
as Set<int>,correctIndices: null == correctIndices ? _self.correctIndices : correctIndices // ignore: cast_nullable_to_non_nullable
as Set<int>,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,isPerfect: null == isPerfect ? _self.isPerfect : isPerfect // ignore: cast_nullable_to_non_nullable
as bool,attemptCount: null == attemptCount ? _self.attemptCount : attemptCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ShapeMatchingResult].
extension ShapeMatchingResultPatterns on ShapeMatchingResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShapeMatchingResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShapeMatchingResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShapeMatchingResult value)  $default,){
final _that = this;
switch (_that) {
case _ShapeMatchingResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShapeMatchingResult value)?  $default,){
final _that = this;
switch (_that) {
case _ShapeMatchingResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Set<int> selectedIndices,  Set<int> correctIndices,  bool isCorrect,  bool isPerfect,  int attemptCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShapeMatchingResult() when $default != null:
return $default(_that.selectedIndices,_that.correctIndices,_that.isCorrect,_that.isPerfect,_that.attemptCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Set<int> selectedIndices,  Set<int> correctIndices,  bool isCorrect,  bool isPerfect,  int attemptCount)  $default,) {final _that = this;
switch (_that) {
case _ShapeMatchingResult():
return $default(_that.selectedIndices,_that.correctIndices,_that.isCorrect,_that.isPerfect,_that.attemptCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Set<int> selectedIndices,  Set<int> correctIndices,  bool isCorrect,  bool isPerfect,  int attemptCount)?  $default,) {final _that = this;
switch (_that) {
case _ShapeMatchingResult() when $default != null:
return $default(_that.selectedIndices,_that.correctIndices,_that.isCorrect,_that.isPerfect,_that.attemptCount);case _:
  return null;

}
}

}

/// @nodoc


class _ShapeMatchingResult extends ShapeMatchingResult {
  const _ShapeMatchingResult({required final  Set<int> selectedIndices, required final  Set<int> correctIndices, required this.isCorrect, this.isPerfect = false, this.attemptCount = 0}): _selectedIndices = selectedIndices,_correctIndices = correctIndices,super._();
  

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
@override@JsonKey() final  bool isPerfect;
// 一発正解
@override@JsonKey() final  int attemptCount;

/// Create a copy of ShapeMatchingResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShapeMatchingResultCopyWith<_ShapeMatchingResult> get copyWith => __$ShapeMatchingResultCopyWithImpl<_ShapeMatchingResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShapeMatchingResult&&const DeepCollectionEquality().equals(other._selectedIndices, _selectedIndices)&&const DeepCollectionEquality().equals(other._correctIndices, _correctIndices)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.isPerfect, isPerfect) || other.isPerfect == isPerfect)&&(identical(other.attemptCount, attemptCount) || other.attemptCount == attemptCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_selectedIndices),const DeepCollectionEquality().hash(_correctIndices),isCorrect,isPerfect,attemptCount);

@override
String toString() {
  return 'ShapeMatchingResult(selectedIndices: $selectedIndices, correctIndices: $correctIndices, isCorrect: $isCorrect, isPerfect: $isPerfect, attemptCount: $attemptCount)';
}


}

/// @nodoc
abstract mixin class _$ShapeMatchingResultCopyWith<$Res> implements $ShapeMatchingResultCopyWith<$Res> {
  factory _$ShapeMatchingResultCopyWith(_ShapeMatchingResult value, $Res Function(_ShapeMatchingResult) _then) = __$ShapeMatchingResultCopyWithImpl;
@override @useResult
$Res call({
 Set<int> selectedIndices, Set<int> correctIndices, bool isCorrect, bool isPerfect, int attemptCount
});




}
/// @nodoc
class __$ShapeMatchingResultCopyWithImpl<$Res>
    implements _$ShapeMatchingResultCopyWith<$Res> {
  __$ShapeMatchingResultCopyWithImpl(this._self, this._then);

  final _ShapeMatchingResult _self;
  final $Res Function(_ShapeMatchingResult) _then;

/// Create a copy of ShapeMatchingResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedIndices = null,Object? correctIndices = null,Object? isCorrect = null,Object? isPerfect = null,Object? attemptCount = null,}) {
  return _then(_ShapeMatchingResult(
selectedIndices: null == selectedIndices ? _self._selectedIndices : selectedIndices // ignore: cast_nullable_to_non_nullable
as Set<int>,correctIndices: null == correctIndices ? _self._correctIndices : correctIndices // ignore: cast_nullable_to_non_nullable
as Set<int>,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,isPerfect: null == isPerfect ? _self.isPerfect : isPerfect // ignore: cast_nullable_to_non_nullable
as bool,attemptCount: null == attemptCount ? _self.attemptCount : attemptCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ShapeMatchingSession {

 int get index;// 現在の問題番号（0-based）
 int get total;// 総問題数
 List<bool?> get results;// 結果配列（null=未回答）
 ShapeMatchingProblem? get currentProblem; int get wrongAttempts;// 不正解回数
 Set<int> get selectedTiles;// 選択中のタイル
 Set<int> get correctlySelectedTiles;
/// Create a copy of ShapeMatchingSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShapeMatchingSessionCopyWith<ShapeMatchingSession> get copyWith => _$ShapeMatchingSessionCopyWithImpl<ShapeMatchingSession>(this as ShapeMatchingSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShapeMatchingSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&(identical(other.wrongAttempts, wrongAttempts) || other.wrongAttempts == wrongAttempts)&&const DeepCollectionEquality().equals(other.selectedTiles, selectedTiles)&&const DeepCollectionEquality().equals(other.correctlySelectedTiles, correctlySelectedTiles));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(results),currentProblem,wrongAttempts,const DeepCollectionEquality().hash(selectedTiles),const DeepCollectionEquality().hash(correctlySelectedTiles));

@override
String toString() {
  return 'ShapeMatchingSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, wrongAttempts: $wrongAttempts, selectedTiles: $selectedTiles, correctlySelectedTiles: $correctlySelectedTiles)';
}


}

/// @nodoc
abstract mixin class $ShapeMatchingSessionCopyWith<$Res>  {
  factory $ShapeMatchingSessionCopyWith(ShapeMatchingSession value, $Res Function(ShapeMatchingSession) _then) = _$ShapeMatchingSessionCopyWithImpl;
@useResult
$Res call({
 int index, int total, List<bool?> results, ShapeMatchingProblem? currentProblem, int wrongAttempts, Set<int> selectedTiles, Set<int> correctlySelectedTiles
});


$ShapeMatchingProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class _$ShapeMatchingSessionCopyWithImpl<$Res>
    implements $ShapeMatchingSessionCopyWith<$Res> {
  _$ShapeMatchingSessionCopyWithImpl(this._self, this._then);

  final ShapeMatchingSession _self;
  final $Res Function(ShapeMatchingSession) _then;

/// Create a copy of ShapeMatchingSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? wrongAttempts = null,Object? selectedTiles = null,Object? correctlySelectedTiles = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as ShapeMatchingProblem?,wrongAttempts: null == wrongAttempts ? _self.wrongAttempts : wrongAttempts // ignore: cast_nullable_to_non_nullable
as int,selectedTiles: null == selectedTiles ? _self.selectedTiles : selectedTiles // ignore: cast_nullable_to_non_nullable
as Set<int>,correctlySelectedTiles: null == correctlySelectedTiles ? _self.correctlySelectedTiles : correctlySelectedTiles // ignore: cast_nullable_to_non_nullable
as Set<int>,
  ));
}
/// Create a copy of ShapeMatchingSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShapeMatchingProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $ShapeMatchingProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}


/// Adds pattern-matching-related methods to [ShapeMatchingSession].
extension ShapeMatchingSessionPatterns on ShapeMatchingSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShapeMatchingSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShapeMatchingSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShapeMatchingSession value)  $default,){
final _that = this;
switch (_that) {
case _ShapeMatchingSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShapeMatchingSession value)?  $default,){
final _that = this;
switch (_that) {
case _ShapeMatchingSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  ShapeMatchingProblem? currentProblem,  int wrongAttempts,  Set<int> selectedTiles,  Set<int> correctlySelectedTiles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShapeMatchingSession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAttempts,_that.selectedTiles,_that.correctlySelectedTiles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  ShapeMatchingProblem? currentProblem,  int wrongAttempts,  Set<int> selectedTiles,  Set<int> correctlySelectedTiles)  $default,) {final _that = this;
switch (_that) {
case _ShapeMatchingSession():
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAttempts,_that.selectedTiles,_that.correctlySelectedTiles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  int total,  List<bool?> results,  ShapeMatchingProblem? currentProblem,  int wrongAttempts,  Set<int> selectedTiles,  Set<int> correctlySelectedTiles)?  $default,) {final _that = this;
switch (_that) {
case _ShapeMatchingSession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAttempts,_that.selectedTiles,_that.correctlySelectedTiles);case _:
  return null;

}
}

}

/// @nodoc


class _ShapeMatchingSession extends ShapeMatchingSession {
  const _ShapeMatchingSession({required this.index, required this.total, required final  List<bool?> results, this.currentProblem, this.wrongAttempts = 0, final  Set<int> selectedTiles = const {}, final  Set<int> correctlySelectedTiles = const {}}): _results = results,_selectedTiles = selectedTiles,_correctlySelectedTiles = correctlySelectedTiles,super._();
  

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

// 結果配列（null=未回答）
@override final  ShapeMatchingProblem? currentProblem;
@override@JsonKey() final  int wrongAttempts;
// 不正解回数
 final  Set<int> _selectedTiles;
// 不正解回数
@override@JsonKey() Set<int> get selectedTiles {
  if (_selectedTiles is EqualUnmodifiableSetView) return _selectedTiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedTiles);
}

// 選択中のタイル
 final  Set<int> _correctlySelectedTiles;
// 選択中のタイル
@override@JsonKey() Set<int> get correctlySelectedTiles {
  if (_correctlySelectedTiles is EqualUnmodifiableSetView) return _correctlySelectedTiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_correctlySelectedTiles);
}


/// Create a copy of ShapeMatchingSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShapeMatchingSessionCopyWith<_ShapeMatchingSession> get copyWith => __$ShapeMatchingSessionCopyWithImpl<_ShapeMatchingSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShapeMatchingSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&(identical(other.wrongAttempts, wrongAttempts) || other.wrongAttempts == wrongAttempts)&&const DeepCollectionEquality().equals(other._selectedTiles, _selectedTiles)&&const DeepCollectionEquality().equals(other._correctlySelectedTiles, _correctlySelectedTiles));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(_results),currentProblem,wrongAttempts,const DeepCollectionEquality().hash(_selectedTiles),const DeepCollectionEquality().hash(_correctlySelectedTiles));

@override
String toString() {
  return 'ShapeMatchingSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, wrongAttempts: $wrongAttempts, selectedTiles: $selectedTiles, correctlySelectedTiles: $correctlySelectedTiles)';
}


}

/// @nodoc
abstract mixin class _$ShapeMatchingSessionCopyWith<$Res> implements $ShapeMatchingSessionCopyWith<$Res> {
  factory _$ShapeMatchingSessionCopyWith(_ShapeMatchingSession value, $Res Function(_ShapeMatchingSession) _then) = __$ShapeMatchingSessionCopyWithImpl;
@override @useResult
$Res call({
 int index, int total, List<bool?> results, ShapeMatchingProblem? currentProblem, int wrongAttempts, Set<int> selectedTiles, Set<int> correctlySelectedTiles
});


@override $ShapeMatchingProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class __$ShapeMatchingSessionCopyWithImpl<$Res>
    implements _$ShapeMatchingSessionCopyWith<$Res> {
  __$ShapeMatchingSessionCopyWithImpl(this._self, this._then);

  final _ShapeMatchingSession _self;
  final $Res Function(_ShapeMatchingSession) _then;

/// Create a copy of ShapeMatchingSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? wrongAttempts = null,Object? selectedTiles = null,Object? correctlySelectedTiles = null,}) {
  return _then(_ShapeMatchingSession(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as ShapeMatchingProblem?,wrongAttempts: null == wrongAttempts ? _self.wrongAttempts : wrongAttempts // ignore: cast_nullable_to_non_nullable
as int,selectedTiles: null == selectedTiles ? _self._selectedTiles : selectedTiles // ignore: cast_nullable_to_non_nullable
as Set<int>,correctlySelectedTiles: null == correctlySelectedTiles ? _self._correctlySelectedTiles : correctlySelectedTiles // ignore: cast_nullable_to_non_nullable
as Set<int>,
  ));
}

/// Create a copy of ShapeMatchingSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShapeMatchingProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $ShapeMatchingProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}

/// @nodoc
mixin _$ShapeMatchingState {

 CommonGamePhase get phase; ShapeMatchingSettings? get settings; ShapeMatchingSession? get session; ShapeMatchingResult? get lastResult; int get epoch;
/// Create a copy of ShapeMatchingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShapeMatchingStateCopyWith<ShapeMatchingState> get copyWith => _$ShapeMatchingStateCopyWithImpl<ShapeMatchingState>(this as ShapeMatchingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShapeMatchingState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.lastResult, lastResult) || other.lastResult == lastResult)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,lastResult,epoch);

@override
String toString() {
  return 'ShapeMatchingState(phase: $phase, settings: $settings, session: $session, lastResult: $lastResult, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class $ShapeMatchingStateCopyWith<$Res>  {
  factory $ShapeMatchingStateCopyWith(ShapeMatchingState value, $Res Function(ShapeMatchingState) _then) = _$ShapeMatchingStateCopyWithImpl;
@useResult
$Res call({
 CommonGamePhase phase, ShapeMatchingSettings? settings, ShapeMatchingSession? session, ShapeMatchingResult? lastResult, int epoch
});


$ShapeMatchingSettingsCopyWith<$Res>? get settings;$ShapeMatchingSessionCopyWith<$Res>? get session;$ShapeMatchingResultCopyWith<$Res>? get lastResult;

}
/// @nodoc
class _$ShapeMatchingStateCopyWithImpl<$Res>
    implements $ShapeMatchingStateCopyWith<$Res> {
  _$ShapeMatchingStateCopyWithImpl(this._self, this._then);

  final ShapeMatchingState _self;
  final $Res Function(ShapeMatchingState) _then;

/// Create a copy of ShapeMatchingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? lastResult = freezed,Object? epoch = null,}) {
  return _then(_self.copyWith(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as ShapeMatchingSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as ShapeMatchingSession?,lastResult: freezed == lastResult ? _self.lastResult : lastResult // ignore: cast_nullable_to_non_nullable
as ShapeMatchingResult?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of ShapeMatchingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShapeMatchingSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $ShapeMatchingSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of ShapeMatchingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShapeMatchingSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $ShapeMatchingSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of ShapeMatchingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShapeMatchingResultCopyWith<$Res>? get lastResult {
    if (_self.lastResult == null) {
    return null;
  }

  return $ShapeMatchingResultCopyWith<$Res>(_self.lastResult!, (value) {
    return _then(_self.copyWith(lastResult: value));
  });
}
}


/// Adds pattern-matching-related methods to [ShapeMatchingState].
extension ShapeMatchingStatePatterns on ShapeMatchingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShapeMatchingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShapeMatchingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShapeMatchingState value)  $default,){
final _that = this;
switch (_that) {
case _ShapeMatchingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShapeMatchingState value)?  $default,){
final _that = this;
switch (_that) {
case _ShapeMatchingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CommonGamePhase phase,  ShapeMatchingSettings? settings,  ShapeMatchingSession? session,  ShapeMatchingResult? lastResult,  int epoch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShapeMatchingState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CommonGamePhase phase,  ShapeMatchingSettings? settings,  ShapeMatchingSession? session,  ShapeMatchingResult? lastResult,  int epoch)  $default,) {final _that = this;
switch (_that) {
case _ShapeMatchingState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CommonGamePhase phase,  ShapeMatchingSettings? settings,  ShapeMatchingSession? session,  ShapeMatchingResult? lastResult,  int epoch)?  $default,) {final _that = this;
switch (_that) {
case _ShapeMatchingState() when $default != null:
return $default(_that.phase,_that.settings,_that.session,_that.lastResult,_that.epoch);case _:
  return null;

}
}

}

/// @nodoc


class _ShapeMatchingState extends ShapeMatchingState {
  const _ShapeMatchingState({this.phase = CommonGamePhase.ready, this.settings, this.session, this.lastResult, this.epoch = 0}): super._();
  

@override@JsonKey() final  CommonGamePhase phase;
@override final  ShapeMatchingSettings? settings;
@override final  ShapeMatchingSession? session;
@override final  ShapeMatchingResult? lastResult;
@override@JsonKey() final  int epoch;

/// Create a copy of ShapeMatchingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShapeMatchingStateCopyWith<_ShapeMatchingState> get copyWith => __$ShapeMatchingStateCopyWithImpl<_ShapeMatchingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShapeMatchingState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.lastResult, lastResult) || other.lastResult == lastResult)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,lastResult,epoch);

@override
String toString() {
  return 'ShapeMatchingState(phase: $phase, settings: $settings, session: $session, lastResult: $lastResult, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class _$ShapeMatchingStateCopyWith<$Res> implements $ShapeMatchingStateCopyWith<$Res> {
  factory _$ShapeMatchingStateCopyWith(_ShapeMatchingState value, $Res Function(_ShapeMatchingState) _then) = __$ShapeMatchingStateCopyWithImpl;
@override @useResult
$Res call({
 CommonGamePhase phase, ShapeMatchingSettings? settings, ShapeMatchingSession? session, ShapeMatchingResult? lastResult, int epoch
});


@override $ShapeMatchingSettingsCopyWith<$Res>? get settings;@override $ShapeMatchingSessionCopyWith<$Res>? get session;@override $ShapeMatchingResultCopyWith<$Res>? get lastResult;

}
/// @nodoc
class __$ShapeMatchingStateCopyWithImpl<$Res>
    implements _$ShapeMatchingStateCopyWith<$Res> {
  __$ShapeMatchingStateCopyWithImpl(this._self, this._then);

  final _ShapeMatchingState _self;
  final $Res Function(_ShapeMatchingState) _then;

/// Create a copy of ShapeMatchingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? lastResult = freezed,Object? epoch = null,}) {
  return _then(_ShapeMatchingState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as ShapeMatchingSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as ShapeMatchingSession?,lastResult: freezed == lastResult ? _self.lastResult : lastResult // ignore: cast_nullable_to_non_nullable
as ShapeMatchingResult?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of ShapeMatchingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShapeMatchingSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $ShapeMatchingSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of ShapeMatchingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShapeMatchingSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $ShapeMatchingSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of ShapeMatchingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShapeMatchingResultCopyWith<$Res>? get lastResult {
    if (_self.lastResult == null) {
    return null;
  }

  return $ShapeMatchingResultCopyWith<$Res>(_self.lastResult!, (value) {
    return _then(_self.copyWith(lastResult: value));
  });
}
}

// dart format on
