// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'puzzle_game_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PuzzleGameSettings {

 int get questionCount;
/// Create a copy of PuzzleGameSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PuzzleGameSettingsCopyWith<PuzzleGameSettings> get copyWith => _$PuzzleGameSettingsCopyWithImpl<PuzzleGameSettings>(this as PuzzleGameSettings, _$identity);





@override
String toString() {
  return 'PuzzleGameSettings(questionCount: $questionCount)';
}


}

/// @nodoc
abstract mixin class $PuzzleGameSettingsCopyWith<$Res>  {
  factory $PuzzleGameSettingsCopyWith(PuzzleGameSettings value, $Res Function(PuzzleGameSettings) _then) = _$PuzzleGameSettingsCopyWithImpl;
@useResult
$Res call({
 int questionCount
});




}
/// @nodoc
class _$PuzzleGameSettingsCopyWithImpl<$Res>
    implements $PuzzleGameSettingsCopyWith<$Res> {
  _$PuzzleGameSettingsCopyWithImpl(this._self, this._then);

  final PuzzleGameSettings _self;
  final $Res Function(PuzzleGameSettings) _then;

/// Create a copy of PuzzleGameSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionCount = null,}) {
  return _then(_self.copyWith(
questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PuzzleGameSettings].
extension PuzzleGameSettingsPatterns on PuzzleGameSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PuzzleGameSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PuzzleGameSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PuzzleGameSettings value)  $default,){
final _that = this;
switch (_that) {
case _PuzzleGameSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PuzzleGameSettings value)?  $default,){
final _that = this;
switch (_that) {
case _PuzzleGameSettings() when $default != null:
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
case _PuzzleGameSettings() when $default != null:
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
case _PuzzleGameSettings():
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
case _PuzzleGameSettings() when $default != null:
return $default(_that.questionCount);case _:
  return null;

}
}

}

/// @nodoc


class _PuzzleGameSettings extends PuzzleGameSettings {
  const _PuzzleGameSettings({this.questionCount = 3}): super._();
  

@override@JsonKey() final  int questionCount;

/// Create a copy of PuzzleGameSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PuzzleGameSettingsCopyWith<_PuzzleGameSettings> get copyWith => __$PuzzleGameSettingsCopyWithImpl<_PuzzleGameSettings>(this, _$identity);





@override
String toString() {
  return 'PuzzleGameSettings(questionCount: $questionCount)';
}


}

/// @nodoc
abstract mixin class _$PuzzleGameSettingsCopyWith<$Res> implements $PuzzleGameSettingsCopyWith<$Res> {
  factory _$PuzzleGameSettingsCopyWith(_PuzzleGameSettings value, $Res Function(_PuzzleGameSettings) _then) = __$PuzzleGameSettingsCopyWithImpl;
@override @useResult
$Res call({
 int questionCount
});




}
/// @nodoc
class __$PuzzleGameSettingsCopyWithImpl<$Res>
    implements _$PuzzleGameSettingsCopyWith<$Res> {
  __$PuzzleGameSettingsCopyWithImpl(this._self, this._then);

  final _PuzzleGameSettings _self;
  final $Res Function(_PuzzleGameSettings) _then;

/// Create a copy of PuzzleGameSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionCount = null,}) {
  return _then(_PuzzleGameSettings(
questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$PuzzlePiece {

 PuzzlePieceType get type; int get imageIndex; Rect get uvRect;// UV座標 (0.0〜1.0)
 int get gridPosition;// 2x2グリッド内の位置 (0-3)
 bool get isSelected;
/// Create a copy of PuzzlePiece
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PuzzlePieceCopyWith<PuzzlePiece> get copyWith => _$PuzzlePieceCopyWithImpl<PuzzlePiece>(this as PuzzlePiece, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PuzzlePiece&&(identical(other.type, type) || other.type == type)&&(identical(other.imageIndex, imageIndex) || other.imageIndex == imageIndex)&&(identical(other.uvRect, uvRect) || other.uvRect == uvRect)&&(identical(other.gridPosition, gridPosition) || other.gridPosition == gridPosition)&&(identical(other.isSelected, isSelected) || other.isSelected == isSelected));
}


@override
int get hashCode => Object.hash(runtimeType,type,imageIndex,uvRect,gridPosition,isSelected);

@override
String toString() {
  return 'PuzzlePiece(type: $type, imageIndex: $imageIndex, uvRect: $uvRect, gridPosition: $gridPosition, isSelected: $isSelected)';
}


}

/// @nodoc
abstract mixin class $PuzzlePieceCopyWith<$Res>  {
  factory $PuzzlePieceCopyWith(PuzzlePiece value, $Res Function(PuzzlePiece) _then) = _$PuzzlePieceCopyWithImpl;
@useResult
$Res call({
 PuzzlePieceType type, int imageIndex, Rect uvRect, int gridPosition, bool isSelected
});




}
/// @nodoc
class _$PuzzlePieceCopyWithImpl<$Res>
    implements $PuzzlePieceCopyWith<$Res> {
  _$PuzzlePieceCopyWithImpl(this._self, this._then);

  final PuzzlePiece _self;
  final $Res Function(PuzzlePiece) _then;

/// Create a copy of PuzzlePiece
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? imageIndex = null,Object? uvRect = null,Object? gridPosition = null,Object? isSelected = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PuzzlePieceType,imageIndex: null == imageIndex ? _self.imageIndex : imageIndex // ignore: cast_nullable_to_non_nullable
as int,uvRect: null == uvRect ? _self.uvRect : uvRect // ignore: cast_nullable_to_non_nullable
as Rect,gridPosition: null == gridPosition ? _self.gridPosition : gridPosition // ignore: cast_nullable_to_non_nullable
as int,isSelected: null == isSelected ? _self.isSelected : isSelected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PuzzlePiece].
extension PuzzlePiecePatterns on PuzzlePiece {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PuzzlePiece value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PuzzlePiece() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PuzzlePiece value)  $default,){
final _that = this;
switch (_that) {
case _PuzzlePiece():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PuzzlePiece value)?  $default,){
final _that = this;
switch (_that) {
case _PuzzlePiece() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PuzzlePieceType type,  int imageIndex,  Rect uvRect,  int gridPosition,  bool isSelected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PuzzlePiece() when $default != null:
return $default(_that.type,_that.imageIndex,_that.uvRect,_that.gridPosition,_that.isSelected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PuzzlePieceType type,  int imageIndex,  Rect uvRect,  int gridPosition,  bool isSelected)  $default,) {final _that = this;
switch (_that) {
case _PuzzlePiece():
return $default(_that.type,_that.imageIndex,_that.uvRect,_that.gridPosition,_that.isSelected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PuzzlePieceType type,  int imageIndex,  Rect uvRect,  int gridPosition,  bool isSelected)?  $default,) {final _that = this;
switch (_that) {
case _PuzzlePiece() when $default != null:
return $default(_that.type,_that.imageIndex,_that.uvRect,_that.gridPosition,_that.isSelected);case _:
  return null;

}
}

}

/// @nodoc


class _PuzzlePiece extends PuzzlePiece {
  const _PuzzlePiece({required this.type, required this.imageIndex, required this.uvRect, required this.gridPosition, this.isSelected = false}): super._();
  

@override final  PuzzlePieceType type;
@override final  int imageIndex;
@override final  Rect uvRect;
// UV座標 (0.0〜1.0)
@override final  int gridPosition;
// 2x2グリッド内の位置 (0-3)
@override@JsonKey() final  bool isSelected;

/// Create a copy of PuzzlePiece
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PuzzlePieceCopyWith<_PuzzlePiece> get copyWith => __$PuzzlePieceCopyWithImpl<_PuzzlePiece>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PuzzlePiece&&(identical(other.type, type) || other.type == type)&&(identical(other.imageIndex, imageIndex) || other.imageIndex == imageIndex)&&(identical(other.uvRect, uvRect) || other.uvRect == uvRect)&&(identical(other.gridPosition, gridPosition) || other.gridPosition == gridPosition)&&(identical(other.isSelected, isSelected) || other.isSelected == isSelected));
}


@override
int get hashCode => Object.hash(runtimeType,type,imageIndex,uvRect,gridPosition,isSelected);

@override
String toString() {
  return 'PuzzlePiece(type: $type, imageIndex: $imageIndex, uvRect: $uvRect, gridPosition: $gridPosition, isSelected: $isSelected)';
}


}

/// @nodoc
abstract mixin class _$PuzzlePieceCopyWith<$Res> implements $PuzzlePieceCopyWith<$Res> {
  factory _$PuzzlePieceCopyWith(_PuzzlePiece value, $Res Function(_PuzzlePiece) _then) = __$PuzzlePieceCopyWithImpl;
@override @useResult
$Res call({
 PuzzlePieceType type, int imageIndex, Rect uvRect, int gridPosition, bool isSelected
});




}
/// @nodoc
class __$PuzzlePieceCopyWithImpl<$Res>
    implements _$PuzzlePieceCopyWith<$Res> {
  __$PuzzlePieceCopyWithImpl(this._self, this._then);

  final _PuzzlePiece _self;
  final $Res Function(_PuzzlePiece) _then;

/// Create a copy of PuzzlePiece
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? imageIndex = null,Object? uvRect = null,Object? gridPosition = null,Object? isSelected = null,}) {
  return _then(_PuzzlePiece(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PuzzlePieceType,imageIndex: null == imageIndex ? _self.imageIndex : imageIndex // ignore: cast_nullable_to_non_nullable
as int,uvRect: null == uvRect ? _self.uvRect : uvRect // ignore: cast_nullable_to_non_nullable
as Rect,gridPosition: null == gridPosition ? _self.gridPosition : gridPosition // ignore: cast_nullable_to_non_nullable
as int,isSelected: null == isSelected ? _self.isSelected : isSelected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$PuzzleProblem {

 String get imagePath; int get imageIndex; List<PuzzlePiece> get pieces;// シャッフルされた3ピース
 Image? get fullImage;
/// Create a copy of PuzzleProblem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PuzzleProblemCopyWith<PuzzleProblem> get copyWith => _$PuzzleProblemCopyWithImpl<PuzzleProblem>(this as PuzzleProblem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PuzzleProblem&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.imageIndex, imageIndex) || other.imageIndex == imageIndex)&&const DeepCollectionEquality().equals(other.pieces, pieces)&&(identical(other.fullImage, fullImage) || other.fullImage == fullImage));
}


@override
int get hashCode => Object.hash(runtimeType,imagePath,imageIndex,const DeepCollectionEquality().hash(pieces),fullImage);

@override
String toString() {
  return 'PuzzleProblem(imagePath: $imagePath, imageIndex: $imageIndex, pieces: $pieces, fullImage: $fullImage)';
}


}

/// @nodoc
abstract mixin class $PuzzleProblemCopyWith<$Res>  {
  factory $PuzzleProblemCopyWith(PuzzleProblem value, $Res Function(PuzzleProblem) _then) = _$PuzzleProblemCopyWithImpl;
@useResult
$Res call({
 String imagePath, int imageIndex, List<PuzzlePiece> pieces, Image? fullImage
});




}
/// @nodoc
class _$PuzzleProblemCopyWithImpl<$Res>
    implements $PuzzleProblemCopyWith<$Res> {
  _$PuzzleProblemCopyWithImpl(this._self, this._then);

  final PuzzleProblem _self;
  final $Res Function(PuzzleProblem) _then;

/// Create a copy of PuzzleProblem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imagePath = null,Object? imageIndex = null,Object? pieces = null,Object? fullImage = freezed,}) {
  return _then(_self.copyWith(
imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,imageIndex: null == imageIndex ? _self.imageIndex : imageIndex // ignore: cast_nullable_to_non_nullable
as int,pieces: null == pieces ? _self.pieces : pieces // ignore: cast_nullable_to_non_nullable
as List<PuzzlePiece>,fullImage: freezed == fullImage ? _self.fullImage : fullImage // ignore: cast_nullable_to_non_nullable
as Image?,
  ));
}

}


/// Adds pattern-matching-related methods to [PuzzleProblem].
extension PuzzleProblemPatterns on PuzzleProblem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PuzzleProblem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PuzzleProblem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PuzzleProblem value)  $default,){
final _that = this;
switch (_that) {
case _PuzzleProblem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PuzzleProblem value)?  $default,){
final _that = this;
switch (_that) {
case _PuzzleProblem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String imagePath,  int imageIndex,  List<PuzzlePiece> pieces,  Image? fullImage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PuzzleProblem() when $default != null:
return $default(_that.imagePath,_that.imageIndex,_that.pieces,_that.fullImage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String imagePath,  int imageIndex,  List<PuzzlePiece> pieces,  Image? fullImage)  $default,) {final _that = this;
switch (_that) {
case _PuzzleProblem():
return $default(_that.imagePath,_that.imageIndex,_that.pieces,_that.fullImage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String imagePath,  int imageIndex,  List<PuzzlePiece> pieces,  Image? fullImage)?  $default,) {final _that = this;
switch (_that) {
case _PuzzleProblem() when $default != null:
return $default(_that.imagePath,_that.imageIndex,_that.pieces,_that.fullImage);case _:
  return null;

}
}

}

/// @nodoc


class _PuzzleProblem extends PuzzleProblem {
  const _PuzzleProblem({required this.imagePath, required this.imageIndex, required final  List<PuzzlePiece> pieces, required this.fullImage}): _pieces = pieces,super._();
  

@override final  String imagePath;
@override final  int imageIndex;
 final  List<PuzzlePiece> _pieces;
@override List<PuzzlePiece> get pieces {
  if (_pieces is EqualUnmodifiableListView) return _pieces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pieces);
}

// シャッフルされた3ピース
@override final  Image? fullImage;

/// Create a copy of PuzzleProblem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PuzzleProblemCopyWith<_PuzzleProblem> get copyWith => __$PuzzleProblemCopyWithImpl<_PuzzleProblem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PuzzleProblem&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.imageIndex, imageIndex) || other.imageIndex == imageIndex)&&const DeepCollectionEquality().equals(other._pieces, _pieces)&&(identical(other.fullImage, fullImage) || other.fullImage == fullImage));
}


@override
int get hashCode => Object.hash(runtimeType,imagePath,imageIndex,const DeepCollectionEquality().hash(_pieces),fullImage);

@override
String toString() {
  return 'PuzzleProblem(imagePath: $imagePath, imageIndex: $imageIndex, pieces: $pieces, fullImage: $fullImage)';
}


}

/// @nodoc
abstract mixin class _$PuzzleProblemCopyWith<$Res> implements $PuzzleProblemCopyWith<$Res> {
  factory _$PuzzleProblemCopyWith(_PuzzleProblem value, $Res Function(_PuzzleProblem) _then) = __$PuzzleProblemCopyWithImpl;
@override @useResult
$Res call({
 String imagePath, int imageIndex, List<PuzzlePiece> pieces, Image? fullImage
});




}
/// @nodoc
class __$PuzzleProblemCopyWithImpl<$Res>
    implements _$PuzzleProblemCopyWith<$Res> {
  __$PuzzleProblemCopyWithImpl(this._self, this._then);

  final _PuzzleProblem _self;
  final $Res Function(_PuzzleProblem) _then;

/// Create a copy of PuzzleProblem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imagePath = null,Object? imageIndex = null,Object? pieces = null,Object? fullImage = freezed,}) {
  return _then(_PuzzleProblem(
imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,imageIndex: null == imageIndex ? _self.imageIndex : imageIndex // ignore: cast_nullable_to_non_nullable
as int,pieces: null == pieces ? _self._pieces : pieces // ignore: cast_nullable_to_non_nullable
as List<PuzzlePiece>,fullImage: freezed == fullImage ? _self.fullImage : fullImage // ignore: cast_nullable_to_non_nullable
as Image?,
  ));
}


}

/// @nodoc
mixin _$PuzzleAnswerResult {

 List<int> get selectedIndices; bool get isCorrect; bool get isPerfect; Duration get timeTaken;
/// Create a copy of PuzzleAnswerResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PuzzleAnswerResultCopyWith<PuzzleAnswerResult> get copyWith => _$PuzzleAnswerResultCopyWithImpl<PuzzleAnswerResult>(this as PuzzleAnswerResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PuzzleAnswerResult&&const DeepCollectionEquality().equals(other.selectedIndices, selectedIndices)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.isPerfect, isPerfect) || other.isPerfect == isPerfect)&&(identical(other.timeTaken, timeTaken) || other.timeTaken == timeTaken));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(selectedIndices),isCorrect,isPerfect,timeTaken);

@override
String toString() {
  return 'PuzzleAnswerResult(selectedIndices: $selectedIndices, isCorrect: $isCorrect, isPerfect: $isPerfect, timeTaken: $timeTaken)';
}


}

/// @nodoc
abstract mixin class $PuzzleAnswerResultCopyWith<$Res>  {
  factory $PuzzleAnswerResultCopyWith(PuzzleAnswerResult value, $Res Function(PuzzleAnswerResult) _then) = _$PuzzleAnswerResultCopyWithImpl;
@useResult
$Res call({
 List<int> selectedIndices, bool isCorrect, bool isPerfect, Duration timeTaken
});




}
/// @nodoc
class _$PuzzleAnswerResultCopyWithImpl<$Res>
    implements $PuzzleAnswerResultCopyWith<$Res> {
  _$PuzzleAnswerResultCopyWithImpl(this._self, this._then);

  final PuzzleAnswerResult _self;
  final $Res Function(PuzzleAnswerResult) _then;

/// Create a copy of PuzzleAnswerResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedIndices = null,Object? isCorrect = null,Object? isPerfect = null,Object? timeTaken = null,}) {
  return _then(_self.copyWith(
selectedIndices: null == selectedIndices ? _self.selectedIndices : selectedIndices // ignore: cast_nullable_to_non_nullable
as List<int>,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,isPerfect: null == isPerfect ? _self.isPerfect : isPerfect // ignore: cast_nullable_to_non_nullable
as bool,timeTaken: null == timeTaken ? _self.timeTaken : timeTaken // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

}


/// Adds pattern-matching-related methods to [PuzzleAnswerResult].
extension PuzzleAnswerResultPatterns on PuzzleAnswerResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PuzzleAnswerResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PuzzleAnswerResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PuzzleAnswerResult value)  $default,){
final _that = this;
switch (_that) {
case _PuzzleAnswerResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PuzzleAnswerResult value)?  $default,){
final _that = this;
switch (_that) {
case _PuzzleAnswerResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<int> selectedIndices,  bool isCorrect,  bool isPerfect,  Duration timeTaken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PuzzleAnswerResult() when $default != null:
return $default(_that.selectedIndices,_that.isCorrect,_that.isPerfect,_that.timeTaken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<int> selectedIndices,  bool isCorrect,  bool isPerfect,  Duration timeTaken)  $default,) {final _that = this;
switch (_that) {
case _PuzzleAnswerResult():
return $default(_that.selectedIndices,_that.isCorrect,_that.isPerfect,_that.timeTaken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<int> selectedIndices,  bool isCorrect,  bool isPerfect,  Duration timeTaken)?  $default,) {final _that = this;
switch (_that) {
case _PuzzleAnswerResult() when $default != null:
return $default(_that.selectedIndices,_that.isCorrect,_that.isPerfect,_that.timeTaken);case _:
  return null;

}
}

}

/// @nodoc


class _PuzzleAnswerResult implements PuzzleAnswerResult {
  const _PuzzleAnswerResult({required final  List<int> selectedIndices, required this.isCorrect, required this.isPerfect, this.timeTaken = Duration.zero}): _selectedIndices = selectedIndices;
  

 final  List<int> _selectedIndices;
@override List<int> get selectedIndices {
  if (_selectedIndices is EqualUnmodifiableListView) return _selectedIndices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedIndices);
}

@override final  bool isCorrect;
@override final  bool isPerfect;
@override@JsonKey() final  Duration timeTaken;

/// Create a copy of PuzzleAnswerResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PuzzleAnswerResultCopyWith<_PuzzleAnswerResult> get copyWith => __$PuzzleAnswerResultCopyWithImpl<_PuzzleAnswerResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PuzzleAnswerResult&&const DeepCollectionEquality().equals(other._selectedIndices, _selectedIndices)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.isPerfect, isPerfect) || other.isPerfect == isPerfect)&&(identical(other.timeTaken, timeTaken) || other.timeTaken == timeTaken));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_selectedIndices),isCorrect,isPerfect,timeTaken);

@override
String toString() {
  return 'PuzzleAnswerResult(selectedIndices: $selectedIndices, isCorrect: $isCorrect, isPerfect: $isPerfect, timeTaken: $timeTaken)';
}


}

/// @nodoc
abstract mixin class _$PuzzleAnswerResultCopyWith<$Res> implements $PuzzleAnswerResultCopyWith<$Res> {
  factory _$PuzzleAnswerResultCopyWith(_PuzzleAnswerResult value, $Res Function(_PuzzleAnswerResult) _then) = __$PuzzleAnswerResultCopyWithImpl;
@override @useResult
$Res call({
 List<int> selectedIndices, bool isCorrect, bool isPerfect, Duration timeTaken
});




}
/// @nodoc
class __$PuzzleAnswerResultCopyWithImpl<$Res>
    implements _$PuzzleAnswerResultCopyWith<$Res> {
  __$PuzzleAnswerResultCopyWithImpl(this._self, this._then);

  final _PuzzleAnswerResult _self;
  final $Res Function(_PuzzleAnswerResult) _then;

/// Create a copy of PuzzleAnswerResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedIndices = null,Object? isCorrect = null,Object? isPerfect = null,Object? timeTaken = null,}) {
  return _then(_PuzzleAnswerResult(
selectedIndices: null == selectedIndices ? _self._selectedIndices : selectedIndices // ignore: cast_nullable_to_non_nullable
as List<int>,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,isPerfect: null == isPerfect ? _self.isPerfect : isPerfect // ignore: cast_nullable_to_non_nullable
as bool,timeTaken: null == timeTaken ? _self.timeTaken : timeTaken // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

/// @nodoc
mixin _$PuzzleGameSession {

 int get index; int get total; List<bool?> get results; PuzzleProblem? get currentProblem; int get wrongAnswers; List<int> get selectedPieceIndices; Duration get totalTime; DateTime? get questionStartTime;
/// Create a copy of PuzzleGameSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PuzzleGameSessionCopyWith<PuzzleGameSession> get copyWith => _$PuzzleGameSessionCopyWithImpl<PuzzleGameSession>(this as PuzzleGameSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PuzzleGameSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&(identical(other.wrongAnswers, wrongAnswers) || other.wrongAnswers == wrongAnswers)&&const DeepCollectionEquality().equals(other.selectedPieceIndices, selectedPieceIndices)&&(identical(other.totalTime, totalTime) || other.totalTime == totalTime)&&(identical(other.questionStartTime, questionStartTime) || other.questionStartTime == questionStartTime));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(results),currentProblem,wrongAnswers,const DeepCollectionEquality().hash(selectedPieceIndices),totalTime,questionStartTime);

@override
String toString() {
  return 'PuzzleGameSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, wrongAnswers: $wrongAnswers, selectedPieceIndices: $selectedPieceIndices, totalTime: $totalTime, questionStartTime: $questionStartTime)';
}


}

/// @nodoc
abstract mixin class $PuzzleGameSessionCopyWith<$Res>  {
  factory $PuzzleGameSessionCopyWith(PuzzleGameSession value, $Res Function(PuzzleGameSession) _then) = _$PuzzleGameSessionCopyWithImpl;
@useResult
$Res call({
 int index, int total, List<bool?> results, PuzzleProblem? currentProblem, int wrongAnswers, List<int> selectedPieceIndices, Duration totalTime, DateTime? questionStartTime
});


$PuzzleProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class _$PuzzleGameSessionCopyWithImpl<$Res>
    implements $PuzzleGameSessionCopyWith<$Res> {
  _$PuzzleGameSessionCopyWithImpl(this._self, this._then);

  final PuzzleGameSession _self;
  final $Res Function(PuzzleGameSession) _then;

/// Create a copy of PuzzleGameSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? wrongAnswers = null,Object? selectedPieceIndices = null,Object? totalTime = null,Object? questionStartTime = freezed,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as PuzzleProblem?,wrongAnswers: null == wrongAnswers ? _self.wrongAnswers : wrongAnswers // ignore: cast_nullable_to_non_nullable
as int,selectedPieceIndices: null == selectedPieceIndices ? _self.selectedPieceIndices : selectedPieceIndices // ignore: cast_nullable_to_non_nullable
as List<int>,totalTime: null == totalTime ? _self.totalTime : totalTime // ignore: cast_nullable_to_non_nullable
as Duration,questionStartTime: freezed == questionStartTime ? _self.questionStartTime : questionStartTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of PuzzleGameSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PuzzleProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $PuzzleProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}


/// Adds pattern-matching-related methods to [PuzzleGameSession].
extension PuzzleGameSessionPatterns on PuzzleGameSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PuzzleGameSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PuzzleGameSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PuzzleGameSession value)  $default,){
final _that = this;
switch (_that) {
case _PuzzleGameSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PuzzleGameSession value)?  $default,){
final _that = this;
switch (_that) {
case _PuzzleGameSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  PuzzleProblem? currentProblem,  int wrongAnswers,  List<int> selectedPieceIndices,  Duration totalTime,  DateTime? questionStartTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PuzzleGameSession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAnswers,_that.selectedPieceIndices,_that.totalTime,_that.questionStartTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  PuzzleProblem? currentProblem,  int wrongAnswers,  List<int> selectedPieceIndices,  Duration totalTime,  DateTime? questionStartTime)  $default,) {final _that = this;
switch (_that) {
case _PuzzleGameSession():
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAnswers,_that.selectedPieceIndices,_that.totalTime,_that.questionStartTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  int total,  List<bool?> results,  PuzzleProblem? currentProblem,  int wrongAnswers,  List<int> selectedPieceIndices,  Duration totalTime,  DateTime? questionStartTime)?  $default,) {final _that = this;
switch (_that) {
case _PuzzleGameSession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAnswers,_that.selectedPieceIndices,_that.totalTime,_that.questionStartTime);case _:
  return null;

}
}

}

/// @nodoc


class _PuzzleGameSession extends PuzzleGameSession {
  const _PuzzleGameSession({required this.index, required this.total, required final  List<bool?> results, this.currentProblem, this.wrongAnswers = 0, final  List<int> selectedPieceIndices = const [], this.totalTime = Duration.zero, this.questionStartTime}): _results = results,_selectedPieceIndices = selectedPieceIndices,super._();
  

@override final  int index;
@override final  int total;
 final  List<bool?> _results;
@override List<bool?> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override final  PuzzleProblem? currentProblem;
@override@JsonKey() final  int wrongAnswers;
 final  List<int> _selectedPieceIndices;
@override@JsonKey() List<int> get selectedPieceIndices {
  if (_selectedPieceIndices is EqualUnmodifiableListView) return _selectedPieceIndices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedPieceIndices);
}

@override@JsonKey() final  Duration totalTime;
@override final  DateTime? questionStartTime;

/// Create a copy of PuzzleGameSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PuzzleGameSessionCopyWith<_PuzzleGameSession> get copyWith => __$PuzzleGameSessionCopyWithImpl<_PuzzleGameSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PuzzleGameSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&(identical(other.wrongAnswers, wrongAnswers) || other.wrongAnswers == wrongAnswers)&&const DeepCollectionEquality().equals(other._selectedPieceIndices, _selectedPieceIndices)&&(identical(other.totalTime, totalTime) || other.totalTime == totalTime)&&(identical(other.questionStartTime, questionStartTime) || other.questionStartTime == questionStartTime));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(_results),currentProblem,wrongAnswers,const DeepCollectionEquality().hash(_selectedPieceIndices),totalTime,questionStartTime);

@override
String toString() {
  return 'PuzzleGameSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, wrongAnswers: $wrongAnswers, selectedPieceIndices: $selectedPieceIndices, totalTime: $totalTime, questionStartTime: $questionStartTime)';
}


}

/// @nodoc
abstract mixin class _$PuzzleGameSessionCopyWith<$Res> implements $PuzzleGameSessionCopyWith<$Res> {
  factory _$PuzzleGameSessionCopyWith(_PuzzleGameSession value, $Res Function(_PuzzleGameSession) _then) = __$PuzzleGameSessionCopyWithImpl;
@override @useResult
$Res call({
 int index, int total, List<bool?> results, PuzzleProblem? currentProblem, int wrongAnswers, List<int> selectedPieceIndices, Duration totalTime, DateTime? questionStartTime
});


@override $PuzzleProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class __$PuzzleGameSessionCopyWithImpl<$Res>
    implements _$PuzzleGameSessionCopyWith<$Res> {
  __$PuzzleGameSessionCopyWithImpl(this._self, this._then);

  final _PuzzleGameSession _self;
  final $Res Function(_PuzzleGameSession) _then;

/// Create a copy of PuzzleGameSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? wrongAnswers = null,Object? selectedPieceIndices = null,Object? totalTime = null,Object? questionStartTime = freezed,}) {
  return _then(_PuzzleGameSession(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as PuzzleProblem?,wrongAnswers: null == wrongAnswers ? _self.wrongAnswers : wrongAnswers // ignore: cast_nullable_to_non_nullable
as int,selectedPieceIndices: null == selectedPieceIndices ? _self._selectedPieceIndices : selectedPieceIndices // ignore: cast_nullable_to_non_nullable
as List<int>,totalTime: null == totalTime ? _self.totalTime : totalTime // ignore: cast_nullable_to_non_nullable
as Duration,questionStartTime: freezed == questionStartTime ? _self.questionStartTime : questionStartTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of PuzzleGameSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PuzzleProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $PuzzleProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}

/// @nodoc
mixin _$PuzzleGameState {

 CommonGamePhase get phase; PuzzleGameSettings? get settings; PuzzleGameSession? get session; PuzzleAnswerResult? get lastResult; int get epoch;// 競合状態防止
 List<Image?> get preloadedImages;// 事前読み込み画像
 String? get errorMessage;
/// Create a copy of PuzzleGameState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PuzzleGameStateCopyWith<PuzzleGameState> get copyWith => _$PuzzleGameStateCopyWithImpl<PuzzleGameState>(this as PuzzleGameState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PuzzleGameState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.lastResult, lastResult) || other.lastResult == lastResult)&&(identical(other.epoch, epoch) || other.epoch == epoch)&&const DeepCollectionEquality().equals(other.preloadedImages, preloadedImages)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,lastResult,epoch,const DeepCollectionEquality().hash(preloadedImages),errorMessage);

@override
String toString() {
  return 'PuzzleGameState(phase: $phase, settings: $settings, session: $session, lastResult: $lastResult, epoch: $epoch, preloadedImages: $preloadedImages, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PuzzleGameStateCopyWith<$Res>  {
  factory $PuzzleGameStateCopyWith(PuzzleGameState value, $Res Function(PuzzleGameState) _then) = _$PuzzleGameStateCopyWithImpl;
@useResult
$Res call({
 CommonGamePhase phase, PuzzleGameSettings? settings, PuzzleGameSession? session, PuzzleAnswerResult? lastResult, int epoch, List<Image?> preloadedImages, String? errorMessage
});


$PuzzleGameSettingsCopyWith<$Res>? get settings;$PuzzleGameSessionCopyWith<$Res>? get session;$PuzzleAnswerResultCopyWith<$Res>? get lastResult;

}
/// @nodoc
class _$PuzzleGameStateCopyWithImpl<$Res>
    implements $PuzzleGameStateCopyWith<$Res> {
  _$PuzzleGameStateCopyWithImpl(this._self, this._then);

  final PuzzleGameState _self;
  final $Res Function(PuzzleGameState) _then;

/// Create a copy of PuzzleGameState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? lastResult = freezed,Object? epoch = null,Object? preloadedImages = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as PuzzleGameSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as PuzzleGameSession?,lastResult: freezed == lastResult ? _self.lastResult : lastResult // ignore: cast_nullable_to_non_nullable
as PuzzleAnswerResult?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,preloadedImages: null == preloadedImages ? _self.preloadedImages : preloadedImages // ignore: cast_nullable_to_non_nullable
as List<Image?>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PuzzleGameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PuzzleGameSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $PuzzleGameSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of PuzzleGameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PuzzleGameSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $PuzzleGameSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of PuzzleGameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PuzzleAnswerResultCopyWith<$Res>? get lastResult {
    if (_self.lastResult == null) {
    return null;
  }

  return $PuzzleAnswerResultCopyWith<$Res>(_self.lastResult!, (value) {
    return _then(_self.copyWith(lastResult: value));
  });
}
}


/// Adds pattern-matching-related methods to [PuzzleGameState].
extension PuzzleGameStatePatterns on PuzzleGameState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PuzzleGameState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PuzzleGameState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PuzzleGameState value)  $default,){
final _that = this;
switch (_that) {
case _PuzzleGameState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PuzzleGameState value)?  $default,){
final _that = this;
switch (_that) {
case _PuzzleGameState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CommonGamePhase phase,  PuzzleGameSettings? settings,  PuzzleGameSession? session,  PuzzleAnswerResult? lastResult,  int epoch,  List<Image?> preloadedImages,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PuzzleGameState() when $default != null:
return $default(_that.phase,_that.settings,_that.session,_that.lastResult,_that.epoch,_that.preloadedImages,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CommonGamePhase phase,  PuzzleGameSettings? settings,  PuzzleGameSession? session,  PuzzleAnswerResult? lastResult,  int epoch,  List<Image?> preloadedImages,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _PuzzleGameState():
return $default(_that.phase,_that.settings,_that.session,_that.lastResult,_that.epoch,_that.preloadedImages,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CommonGamePhase phase,  PuzzleGameSettings? settings,  PuzzleGameSession? session,  PuzzleAnswerResult? lastResult,  int epoch,  List<Image?> preloadedImages,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _PuzzleGameState() when $default != null:
return $default(_that.phase,_that.settings,_that.session,_that.lastResult,_that.epoch,_that.preloadedImages,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _PuzzleGameState extends PuzzleGameState {
  const _PuzzleGameState({this.phase = CommonGamePhase.ready, this.settings, this.session, this.lastResult, this.epoch = 0, final  List<Image?> preloadedImages = const [], this.errorMessage}): _preloadedImages = preloadedImages,super._();
  

@override@JsonKey() final  CommonGamePhase phase;
@override final  PuzzleGameSettings? settings;
@override final  PuzzleGameSession? session;
@override final  PuzzleAnswerResult? lastResult;
@override@JsonKey() final  int epoch;
// 競合状態防止
 final  List<Image?> _preloadedImages;
// 競合状態防止
@override@JsonKey() List<Image?> get preloadedImages {
  if (_preloadedImages is EqualUnmodifiableListView) return _preloadedImages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_preloadedImages);
}

// 事前読み込み画像
@override final  String? errorMessage;

/// Create a copy of PuzzleGameState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PuzzleGameStateCopyWith<_PuzzleGameState> get copyWith => __$PuzzleGameStateCopyWithImpl<_PuzzleGameState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PuzzleGameState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.lastResult, lastResult) || other.lastResult == lastResult)&&(identical(other.epoch, epoch) || other.epoch == epoch)&&const DeepCollectionEquality().equals(other._preloadedImages, _preloadedImages)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,lastResult,epoch,const DeepCollectionEquality().hash(_preloadedImages),errorMessage);

@override
String toString() {
  return 'PuzzleGameState(phase: $phase, settings: $settings, session: $session, lastResult: $lastResult, epoch: $epoch, preloadedImages: $preloadedImages, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$PuzzleGameStateCopyWith<$Res> implements $PuzzleGameStateCopyWith<$Res> {
  factory _$PuzzleGameStateCopyWith(_PuzzleGameState value, $Res Function(_PuzzleGameState) _then) = __$PuzzleGameStateCopyWithImpl;
@override @useResult
$Res call({
 CommonGamePhase phase, PuzzleGameSettings? settings, PuzzleGameSession? session, PuzzleAnswerResult? lastResult, int epoch, List<Image?> preloadedImages, String? errorMessage
});


@override $PuzzleGameSettingsCopyWith<$Res>? get settings;@override $PuzzleGameSessionCopyWith<$Res>? get session;@override $PuzzleAnswerResultCopyWith<$Res>? get lastResult;

}
/// @nodoc
class __$PuzzleGameStateCopyWithImpl<$Res>
    implements _$PuzzleGameStateCopyWith<$Res> {
  __$PuzzleGameStateCopyWithImpl(this._self, this._then);

  final _PuzzleGameState _self;
  final $Res Function(_PuzzleGameState) _then;

/// Create a copy of PuzzleGameState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? lastResult = freezed,Object? epoch = null,Object? preloadedImages = null,Object? errorMessage = freezed,}) {
  return _then(_PuzzleGameState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as PuzzleGameSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as PuzzleGameSession?,lastResult: freezed == lastResult ? _self.lastResult : lastResult // ignore: cast_nullable_to_non_nullable
as PuzzleAnswerResult?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,preloadedImages: null == preloadedImages ? _self._preloadedImages : preloadedImages // ignore: cast_nullable_to_non_nullable
as List<Image?>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PuzzleGameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PuzzleGameSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $PuzzleGameSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of PuzzleGameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PuzzleGameSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $PuzzleGameSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of PuzzleGameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PuzzleAnswerResultCopyWith<$Res>? get lastResult {
    if (_self.lastResult == null) {
    return null;
  }

  return $PuzzleAnswerResultCopyWith<$Res>(_self.lastResult!, (value) {
    return _then(_self.copyWith(lastResult: value));
  });
}
}

// dart format on
