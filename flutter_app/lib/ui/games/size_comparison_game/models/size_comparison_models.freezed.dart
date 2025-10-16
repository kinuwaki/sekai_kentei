// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'size_comparison_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IconInfo {

 String get filename;// assets/images/figures/vocabulary/<filename>.png
 String get slug;
/// Create a copy of IconInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IconInfoCopyWith<IconInfo> get copyWith => _$IconInfoCopyWithImpl<IconInfo>(this as IconInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IconInfo&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.slug, slug) || other.slug == slug));
}


@override
int get hashCode => Object.hash(runtimeType,filename,slug);

@override
String toString() {
  return 'IconInfo(filename: $filename, slug: $slug)';
}


}

/// @nodoc
abstract mixin class $IconInfoCopyWith<$Res>  {
  factory $IconInfoCopyWith(IconInfo value, $Res Function(IconInfo) _then) = _$IconInfoCopyWithImpl;
@useResult
$Res call({
 String filename, String slug
});




}
/// @nodoc
class _$IconInfoCopyWithImpl<$Res>
    implements $IconInfoCopyWith<$Res> {
  _$IconInfoCopyWithImpl(this._self, this._then);

  final IconInfo _self;
  final $Res Function(IconInfo) _then;

/// Create a copy of IconInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filename = null,Object? slug = null,}) {
  return _then(_self.copyWith(
filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [IconInfo].
extension IconInfoPatterns on IconInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IconInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IconInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IconInfo value)  $default,){
final _that = this;
switch (_that) {
case _IconInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IconInfo value)?  $default,){
final _that = this;
switch (_that) {
case _IconInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String filename,  String slug)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IconInfo() when $default != null:
return $default(_that.filename,_that.slug);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String filename,  String slug)  $default,) {final _that = this;
switch (_that) {
case _IconInfo():
return $default(_that.filename,_that.slug);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String filename,  String slug)?  $default,) {final _that = this;
switch (_that) {
case _IconInfo() when $default != null:
return $default(_that.filename,_that.slug);case _:
  return null;

}
}

}

/// @nodoc


class _IconInfo extends IconInfo {
  const _IconInfo({required this.filename, required this.slug}): super._();
  

@override final  String filename;
// assets/images/figures/vocabulary/<filename>.png
@override final  String slug;

/// Create a copy of IconInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IconInfoCopyWith<_IconInfo> get copyWith => __$IconInfoCopyWithImpl<_IconInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IconInfo&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.slug, slug) || other.slug == slug));
}


@override
int get hashCode => Object.hash(runtimeType,filename,slug);

@override
String toString() {
  return 'IconInfo(filename: $filename, slug: $slug)';
}


}

/// @nodoc
abstract mixin class _$IconInfoCopyWith<$Res> implements $IconInfoCopyWith<$Res> {
  factory _$IconInfoCopyWith(_IconInfo value, $Res Function(_IconInfo) _then) = __$IconInfoCopyWithImpl;
@override @useResult
$Res call({
 String filename, String slug
});




}
/// @nodoc
class __$IconInfoCopyWithImpl<$Res>
    implements _$IconInfoCopyWith<$Res> {
  __$IconInfoCopyWithImpl(this._self, this._then);

  final _IconInfo _self;
  final $Res Function(_IconInfo) _then;

/// Create a copy of IconInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? filename = null,Object? slug = null,}) {
  return _then(_IconInfo(
filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SizedIcon {

 IconInfo get iconInfo; double get size; int get sizeRank;
/// Create a copy of SizedIcon
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SizedIconCopyWith<SizedIcon> get copyWith => _$SizedIconCopyWithImpl<SizedIcon>(this as SizedIcon, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SizedIcon&&(identical(other.iconInfo, iconInfo) || other.iconInfo == iconInfo)&&(identical(other.size, size) || other.size == size)&&(identical(other.sizeRank, sizeRank) || other.sizeRank == sizeRank));
}


@override
int get hashCode => Object.hash(runtimeType,iconInfo,size,sizeRank);

@override
String toString() {
  return 'SizedIcon(iconInfo: $iconInfo, size: $size, sizeRank: $sizeRank)';
}


}

/// @nodoc
abstract mixin class $SizedIconCopyWith<$Res>  {
  factory $SizedIconCopyWith(SizedIcon value, $Res Function(SizedIcon) _then) = _$SizedIconCopyWithImpl;
@useResult
$Res call({
 IconInfo iconInfo, double size, int sizeRank
});


$IconInfoCopyWith<$Res> get iconInfo;

}
/// @nodoc
class _$SizedIconCopyWithImpl<$Res>
    implements $SizedIconCopyWith<$Res> {
  _$SizedIconCopyWithImpl(this._self, this._then);

  final SizedIcon _self;
  final $Res Function(SizedIcon) _then;

/// Create a copy of SizedIcon
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? iconInfo = null,Object? size = null,Object? sizeRank = null,}) {
  return _then(_self.copyWith(
iconInfo: null == iconInfo ? _self.iconInfo : iconInfo // ignore: cast_nullable_to_non_nullable
as IconInfo,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as double,sizeRank: null == sizeRank ? _self.sizeRank : sizeRank // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of SizedIcon
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IconInfoCopyWith<$Res> get iconInfo {
  
  return $IconInfoCopyWith<$Res>(_self.iconInfo, (value) {
    return _then(_self.copyWith(iconInfo: value));
  });
}
}


/// Adds pattern-matching-related methods to [SizedIcon].
extension SizedIconPatterns on SizedIcon {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SizedIcon value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SizedIcon() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SizedIcon value)  $default,){
final _that = this;
switch (_that) {
case _SizedIcon():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SizedIcon value)?  $default,){
final _that = this;
switch (_that) {
case _SizedIcon() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( IconInfo iconInfo,  double size,  int sizeRank)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SizedIcon() when $default != null:
return $default(_that.iconInfo,_that.size,_that.sizeRank);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( IconInfo iconInfo,  double size,  int sizeRank)  $default,) {final _that = this;
switch (_that) {
case _SizedIcon():
return $default(_that.iconInfo,_that.size,_that.sizeRank);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( IconInfo iconInfo,  double size,  int sizeRank)?  $default,) {final _that = this;
switch (_that) {
case _SizedIcon() when $default != null:
return $default(_that.iconInfo,_that.size,_that.sizeRank);case _:
  return null;

}
}

}

/// @nodoc


class _SizedIcon extends SizedIcon {
  const _SizedIcon({required this.iconInfo, required this.size, required this.sizeRank}): super._();
  

@override final  IconInfo iconInfo;
@override final  double size;
@override final  int sizeRank;

/// Create a copy of SizedIcon
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SizedIconCopyWith<_SizedIcon> get copyWith => __$SizedIconCopyWithImpl<_SizedIcon>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SizedIcon&&(identical(other.iconInfo, iconInfo) || other.iconInfo == iconInfo)&&(identical(other.size, size) || other.size == size)&&(identical(other.sizeRank, sizeRank) || other.sizeRank == sizeRank));
}


@override
int get hashCode => Object.hash(runtimeType,iconInfo,size,sizeRank);

@override
String toString() {
  return 'SizedIcon(iconInfo: $iconInfo, size: $size, sizeRank: $sizeRank)';
}


}

/// @nodoc
abstract mixin class _$SizedIconCopyWith<$Res> implements $SizedIconCopyWith<$Res> {
  factory _$SizedIconCopyWith(_SizedIcon value, $Res Function(_SizedIcon) _then) = __$SizedIconCopyWithImpl;
@override @useResult
$Res call({
 IconInfo iconInfo, double size, int sizeRank
});


@override $IconInfoCopyWith<$Res> get iconInfo;

}
/// @nodoc
class __$SizedIconCopyWithImpl<$Res>
    implements _$SizedIconCopyWith<$Res> {
  __$SizedIconCopyWithImpl(this._self, this._then);

  final _SizedIcon _self;
  final $Res Function(_SizedIcon) _then;

/// Create a copy of SizedIcon
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? iconInfo = null,Object? size = null,Object? sizeRank = null,}) {
  return _then(_SizedIcon(
iconInfo: null == iconInfo ? _self.iconInfo : iconInfo // ignore: cast_nullable_to_non_nullable
as IconInfo,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as double,sizeRank: null == sizeRank ? _self.sizeRank : sizeRank // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of SizedIcon
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IconInfoCopyWith<$Res> get iconInfo {
  
  return $IconInfoCopyWith<$Res>(_self.iconInfo, (value) {
    return _then(_self.copyWith(iconInfo: value));
  });
}
}

/// @nodoc
mixin _$SizeComparisonSettings {

 ComparisonChoice get comparisonChoice; int get questionCount;
/// Create a copy of SizeComparisonSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SizeComparisonSettingsCopyWith<SizeComparisonSettings> get copyWith => _$SizeComparisonSettingsCopyWithImpl<SizeComparisonSettings>(this as SizeComparisonSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SizeComparisonSettings&&(identical(other.comparisonChoice, comparisonChoice) || other.comparisonChoice == comparisonChoice)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount));
}


@override
int get hashCode => Object.hash(runtimeType,comparisonChoice,questionCount);

@override
String toString() {
  return 'SizeComparisonSettings(comparisonChoice: $comparisonChoice, questionCount: $questionCount)';
}


}

/// @nodoc
abstract mixin class $SizeComparisonSettingsCopyWith<$Res>  {
  factory $SizeComparisonSettingsCopyWith(SizeComparisonSettings value, $Res Function(SizeComparisonSettings) _then) = _$SizeComparisonSettingsCopyWithImpl;
@useResult
$Res call({
 ComparisonChoice comparisonChoice, int questionCount
});




}
/// @nodoc
class _$SizeComparisonSettingsCopyWithImpl<$Res>
    implements $SizeComparisonSettingsCopyWith<$Res> {
  _$SizeComparisonSettingsCopyWithImpl(this._self, this._then);

  final SizeComparisonSettings _self;
  final $Res Function(SizeComparisonSettings) _then;

/// Create a copy of SizeComparisonSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? comparisonChoice = null,Object? questionCount = null,}) {
  return _then(_self.copyWith(
comparisonChoice: null == comparisonChoice ? _self.comparisonChoice : comparisonChoice // ignore: cast_nullable_to_non_nullable
as ComparisonChoice,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SizeComparisonSettings].
extension SizeComparisonSettingsPatterns on SizeComparisonSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SizeComparisonSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SizeComparisonSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SizeComparisonSettings value)  $default,){
final _that = this;
switch (_that) {
case _SizeComparisonSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SizeComparisonSettings value)?  $default,){
final _that = this;
switch (_that) {
case _SizeComparisonSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ComparisonChoice comparisonChoice,  int questionCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SizeComparisonSettings() when $default != null:
return $default(_that.comparisonChoice,_that.questionCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ComparisonChoice comparisonChoice,  int questionCount)  $default,) {final _that = this;
switch (_that) {
case _SizeComparisonSettings():
return $default(_that.comparisonChoice,_that.questionCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ComparisonChoice comparisonChoice,  int questionCount)?  $default,) {final _that = this;
switch (_that) {
case _SizeComparisonSettings() when $default != null:
return $default(_that.comparisonChoice,_that.questionCount);case _:
  return null;

}
}

}

/// @nodoc


class _SizeComparisonSettings extends SizeComparisonSettings {
  const _SizeComparisonSettings({this.comparisonChoice = ComparisonChoice.sizeRandom, this.questionCount = 4}): super._();
  

@override@JsonKey() final  ComparisonChoice comparisonChoice;
@override@JsonKey() final  int questionCount;

/// Create a copy of SizeComparisonSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SizeComparisonSettingsCopyWith<_SizeComparisonSettings> get copyWith => __$SizeComparisonSettingsCopyWithImpl<_SizeComparisonSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SizeComparisonSettings&&(identical(other.comparisonChoice, comparisonChoice) || other.comparisonChoice == comparisonChoice)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount));
}


@override
int get hashCode => Object.hash(runtimeType,comparisonChoice,questionCount);

@override
String toString() {
  return 'SizeComparisonSettings(comparisonChoice: $comparisonChoice, questionCount: $questionCount)';
}


}

/// @nodoc
abstract mixin class _$SizeComparisonSettingsCopyWith<$Res> implements $SizeComparisonSettingsCopyWith<$Res> {
  factory _$SizeComparisonSettingsCopyWith(_SizeComparisonSettings value, $Res Function(_SizeComparisonSettings) _then) = __$SizeComparisonSettingsCopyWithImpl;
@override @useResult
$Res call({
 ComparisonChoice comparisonChoice, int questionCount
});




}
/// @nodoc
class __$SizeComparisonSettingsCopyWithImpl<$Res>
    implements _$SizeComparisonSettingsCopyWith<$Res> {
  __$SizeComparisonSettingsCopyWithImpl(this._self, this._then);

  final _SizeComparisonSettings _self;
  final $Res Function(_SizeComparisonSettings) _then;

/// Create a copy of SizeComparisonSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? comparisonChoice = null,Object? questionCount = null,}) {
  return _then(_SizeComparisonSettings(
comparisonChoice: null == comparisonChoice ? _self.comparisonChoice : comparisonChoice // ignore: cast_nullable_to_non_nullable
as ComparisonChoice,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$SizeComparisonProblem {

 String get questionText;// TTS用の質問文
 ComparisonType get comparisonType;// 大きい or 小さい
 int get targetRank;// 何番目（1-5）
 List<SizedIcon> get icons;// 5個のサイズ違いアイコン（位置はシャッフル済み）
 int get correctAnswerIndex;// 正解のインデックス（icons配列での位置）
 bool get isPositionMode;
/// Create a copy of SizeComparisonProblem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SizeComparisonProblemCopyWith<SizeComparisonProblem> get copyWith => _$SizeComparisonProblemCopyWithImpl<SizeComparisonProblem>(this as SizeComparisonProblem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SizeComparisonProblem&&(identical(other.questionText, questionText) || other.questionText == questionText)&&(identical(other.comparisonType, comparisonType) || other.comparisonType == comparisonType)&&(identical(other.targetRank, targetRank) || other.targetRank == targetRank)&&const DeepCollectionEquality().equals(other.icons, icons)&&(identical(other.correctAnswerIndex, correctAnswerIndex) || other.correctAnswerIndex == correctAnswerIndex)&&(identical(other.isPositionMode, isPositionMode) || other.isPositionMode == isPositionMode));
}


@override
int get hashCode => Object.hash(runtimeType,questionText,comparisonType,targetRank,const DeepCollectionEquality().hash(icons),correctAnswerIndex,isPositionMode);

@override
String toString() {
  return 'SizeComparisonProblem(questionText: $questionText, comparisonType: $comparisonType, targetRank: $targetRank, icons: $icons, correctAnswerIndex: $correctAnswerIndex, isPositionMode: $isPositionMode)';
}


}

/// @nodoc
abstract mixin class $SizeComparisonProblemCopyWith<$Res>  {
  factory $SizeComparisonProblemCopyWith(SizeComparisonProblem value, $Res Function(SizeComparisonProblem) _then) = _$SizeComparisonProblemCopyWithImpl;
@useResult
$Res call({
 String questionText, ComparisonType comparisonType, int targetRank, List<SizedIcon> icons, int correctAnswerIndex, bool isPositionMode
});




}
/// @nodoc
class _$SizeComparisonProblemCopyWithImpl<$Res>
    implements $SizeComparisonProblemCopyWith<$Res> {
  _$SizeComparisonProblemCopyWithImpl(this._self, this._then);

  final SizeComparisonProblem _self;
  final $Res Function(SizeComparisonProblem) _then;

/// Create a copy of SizeComparisonProblem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionText = null,Object? comparisonType = null,Object? targetRank = null,Object? icons = null,Object? correctAnswerIndex = null,Object? isPositionMode = null,}) {
  return _then(_self.copyWith(
questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,comparisonType: null == comparisonType ? _self.comparisonType : comparisonType // ignore: cast_nullable_to_non_nullable
as ComparisonType,targetRank: null == targetRank ? _self.targetRank : targetRank // ignore: cast_nullable_to_non_nullable
as int,icons: null == icons ? _self.icons : icons // ignore: cast_nullable_to_non_nullable
as List<SizedIcon>,correctAnswerIndex: null == correctAnswerIndex ? _self.correctAnswerIndex : correctAnswerIndex // ignore: cast_nullable_to_non_nullable
as int,isPositionMode: null == isPositionMode ? _self.isPositionMode : isPositionMode // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SizeComparisonProblem].
extension SizeComparisonProblemPatterns on SizeComparisonProblem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SizeComparisonProblem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SizeComparisonProblem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SizeComparisonProblem value)  $default,){
final _that = this;
switch (_that) {
case _SizeComparisonProblem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SizeComparisonProblem value)?  $default,){
final _that = this;
switch (_that) {
case _SizeComparisonProblem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String questionText,  ComparisonType comparisonType,  int targetRank,  List<SizedIcon> icons,  int correctAnswerIndex,  bool isPositionMode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SizeComparisonProblem() when $default != null:
return $default(_that.questionText,_that.comparisonType,_that.targetRank,_that.icons,_that.correctAnswerIndex,_that.isPositionMode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String questionText,  ComparisonType comparisonType,  int targetRank,  List<SizedIcon> icons,  int correctAnswerIndex,  bool isPositionMode)  $default,) {final _that = this;
switch (_that) {
case _SizeComparisonProblem():
return $default(_that.questionText,_that.comparisonType,_that.targetRank,_that.icons,_that.correctAnswerIndex,_that.isPositionMode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String questionText,  ComparisonType comparisonType,  int targetRank,  List<SizedIcon> icons,  int correctAnswerIndex,  bool isPositionMode)?  $default,) {final _that = this;
switch (_that) {
case _SizeComparisonProblem() when $default != null:
return $default(_that.questionText,_that.comparisonType,_that.targetRank,_that.icons,_that.correctAnswerIndex,_that.isPositionMode);case _:
  return null;

}
}

}

/// @nodoc


class _SizeComparisonProblem extends SizeComparisonProblem {
  const _SizeComparisonProblem({required this.questionText, required this.comparisonType, required this.targetRank, required final  List<SizedIcon> icons, required this.correctAnswerIndex, this.isPositionMode = false}): _icons = icons,super._();
  

@override final  String questionText;
// TTS用の質問文
@override final  ComparisonType comparisonType;
// 大きい or 小さい
@override final  int targetRank;
// 何番目（1-5）
 final  List<SizedIcon> _icons;
// 何番目（1-5）
@override List<SizedIcon> get icons {
  if (_icons is EqualUnmodifiableListView) return _icons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_icons);
}

// 5個のサイズ違いアイコン（位置はシャッフル済み）
@override final  int correctAnswerIndex;
// 正解のインデックス（icons配列での位置）
@override@JsonKey() final  bool isPositionMode;

/// Create a copy of SizeComparisonProblem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SizeComparisonProblemCopyWith<_SizeComparisonProblem> get copyWith => __$SizeComparisonProblemCopyWithImpl<_SizeComparisonProblem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SizeComparisonProblem&&(identical(other.questionText, questionText) || other.questionText == questionText)&&(identical(other.comparisonType, comparisonType) || other.comparisonType == comparisonType)&&(identical(other.targetRank, targetRank) || other.targetRank == targetRank)&&const DeepCollectionEquality().equals(other._icons, _icons)&&(identical(other.correctAnswerIndex, correctAnswerIndex) || other.correctAnswerIndex == correctAnswerIndex)&&(identical(other.isPositionMode, isPositionMode) || other.isPositionMode == isPositionMode));
}


@override
int get hashCode => Object.hash(runtimeType,questionText,comparisonType,targetRank,const DeepCollectionEquality().hash(_icons),correctAnswerIndex,isPositionMode);

@override
String toString() {
  return 'SizeComparisonProblem(questionText: $questionText, comparisonType: $comparisonType, targetRank: $targetRank, icons: $icons, correctAnswerIndex: $correctAnswerIndex, isPositionMode: $isPositionMode)';
}


}

/// @nodoc
abstract mixin class _$SizeComparisonProblemCopyWith<$Res> implements $SizeComparisonProblemCopyWith<$Res> {
  factory _$SizeComparisonProblemCopyWith(_SizeComparisonProblem value, $Res Function(_SizeComparisonProblem) _then) = __$SizeComparisonProblemCopyWithImpl;
@override @useResult
$Res call({
 String questionText, ComparisonType comparisonType, int targetRank, List<SizedIcon> icons, int correctAnswerIndex, bool isPositionMode
});




}
/// @nodoc
class __$SizeComparisonProblemCopyWithImpl<$Res>
    implements _$SizeComparisonProblemCopyWith<$Res> {
  __$SizeComparisonProblemCopyWithImpl(this._self, this._then);

  final _SizeComparisonProblem _self;
  final $Res Function(_SizeComparisonProblem) _then;

/// Create a copy of SizeComparisonProblem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionText = null,Object? comparisonType = null,Object? targetRank = null,Object? icons = null,Object? correctAnswerIndex = null,Object? isPositionMode = null,}) {
  return _then(_SizeComparisonProblem(
questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,comparisonType: null == comparisonType ? _self.comparisonType : comparisonType // ignore: cast_nullable_to_non_nullable
as ComparisonType,targetRank: null == targetRank ? _self.targetRank : targetRank // ignore: cast_nullable_to_non_nullable
as int,icons: null == icons ? _self._icons : icons // ignore: cast_nullable_to_non_nullable
as List<SizedIcon>,correctAnswerIndex: null == correctAnswerIndex ? _self.correctAnswerIndex : correctAnswerIndex // ignore: cast_nullable_to_non_nullable
as int,isPositionMode: null == isPositionMode ? _self.isPositionMode : isPositionMode // ignore: cast_nullable_to_non_nullable
as bool,
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


class _AnswerResult extends AnswerResult {
  const _AnswerResult({required this.selectedIndex, required this.correctIndex, required this.isCorrect, required this.isPerfect}): super._();
  

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
mixin _$SizeComparisonSession {

 int get index;// 現在の問題番号 (0-based)
 int get total;// 総問題数
 List<bool?> get results;// 結果配列（null=未回答, bool=完璧/不完璧）
 SizeComparisonProblem? get currentProblem; int get wrongAnswers;// 不正解回数
 DateTime? get startedAt; DateTime? get completedAt;
/// Create a copy of SizeComparisonSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SizeComparisonSessionCopyWith<SizeComparisonSession> get copyWith => _$SizeComparisonSessionCopyWithImpl<SizeComparisonSession>(this as SizeComparisonSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SizeComparisonSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&(identical(other.wrongAnswers, wrongAnswers) || other.wrongAnswers == wrongAnswers)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(results),currentProblem,wrongAnswers,startedAt,completedAt);

@override
String toString() {
  return 'SizeComparisonSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, wrongAnswers: $wrongAnswers, startedAt: $startedAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $SizeComparisonSessionCopyWith<$Res>  {
  factory $SizeComparisonSessionCopyWith(SizeComparisonSession value, $Res Function(SizeComparisonSession) _then) = _$SizeComparisonSessionCopyWithImpl;
@useResult
$Res call({
 int index, int total, List<bool?> results, SizeComparisonProblem? currentProblem, int wrongAnswers, DateTime? startedAt, DateTime? completedAt
});


$SizeComparisonProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class _$SizeComparisonSessionCopyWithImpl<$Res>
    implements $SizeComparisonSessionCopyWith<$Res> {
  _$SizeComparisonSessionCopyWithImpl(this._self, this._then);

  final SizeComparisonSession _self;
  final $Res Function(SizeComparisonSession) _then;

/// Create a copy of SizeComparisonSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? wrongAnswers = null,Object? startedAt = freezed,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as SizeComparisonProblem?,wrongAnswers: null == wrongAnswers ? _self.wrongAnswers : wrongAnswers // ignore: cast_nullable_to_non_nullable
as int,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of SizeComparisonSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SizeComparisonProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $SizeComparisonProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}


/// Adds pattern-matching-related methods to [SizeComparisonSession].
extension SizeComparisonSessionPatterns on SizeComparisonSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SizeComparisonSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SizeComparisonSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SizeComparisonSession value)  $default,){
final _that = this;
switch (_that) {
case _SizeComparisonSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SizeComparisonSession value)?  $default,){
final _that = this;
switch (_that) {
case _SizeComparisonSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  SizeComparisonProblem? currentProblem,  int wrongAnswers,  DateTime? startedAt,  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SizeComparisonSession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAnswers,_that.startedAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  SizeComparisonProblem? currentProblem,  int wrongAnswers,  DateTime? startedAt,  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _SizeComparisonSession():
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAnswers,_that.startedAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  int total,  List<bool?> results,  SizeComparisonProblem? currentProblem,  int wrongAnswers,  DateTime? startedAt,  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _SizeComparisonSession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAnswers,_that.startedAt,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc


class _SizeComparisonSession extends SizeComparisonSession {
  const _SizeComparisonSession({required this.index, required this.total, required final  List<bool?> results, this.currentProblem, this.wrongAnswers = 0, this.startedAt, this.completedAt}): _results = results,super._();
  

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
@override final  SizeComparisonProblem? currentProblem;
@override@JsonKey() final  int wrongAnswers;
// 不正解回数
@override final  DateTime? startedAt;
@override final  DateTime? completedAt;

/// Create a copy of SizeComparisonSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SizeComparisonSessionCopyWith<_SizeComparisonSession> get copyWith => __$SizeComparisonSessionCopyWithImpl<_SizeComparisonSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SizeComparisonSession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&(identical(other.wrongAnswers, wrongAnswers) || other.wrongAnswers == wrongAnswers)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(_results),currentProblem,wrongAnswers,startedAt,completedAt);

@override
String toString() {
  return 'SizeComparisonSession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, wrongAnswers: $wrongAnswers, startedAt: $startedAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$SizeComparisonSessionCopyWith<$Res> implements $SizeComparisonSessionCopyWith<$Res> {
  factory _$SizeComparisonSessionCopyWith(_SizeComparisonSession value, $Res Function(_SizeComparisonSession) _then) = __$SizeComparisonSessionCopyWithImpl;
@override @useResult
$Res call({
 int index, int total, List<bool?> results, SizeComparisonProblem? currentProblem, int wrongAnswers, DateTime? startedAt, DateTime? completedAt
});


@override $SizeComparisonProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class __$SizeComparisonSessionCopyWithImpl<$Res>
    implements _$SizeComparisonSessionCopyWith<$Res> {
  __$SizeComparisonSessionCopyWithImpl(this._self, this._then);

  final _SizeComparisonSession _self;
  final $Res Function(_SizeComparisonSession) _then;

/// Create a copy of SizeComparisonSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? wrongAnswers = null,Object? startedAt = freezed,Object? completedAt = freezed,}) {
  return _then(_SizeComparisonSession(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as SizeComparisonProblem?,wrongAnswers: null == wrongAnswers ? _self.wrongAnswers : wrongAnswers // ignore: cast_nullable_to_non_nullable
as int,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of SizeComparisonSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SizeComparisonProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $SizeComparisonProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}

/// @nodoc
mixin _$SizeComparisonState {

 CommonGamePhase get phase; SizeComparisonSettings? get settings; SizeComparisonSession? get session; AnswerResult? get lastResult; int get epoch;
/// Create a copy of SizeComparisonState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SizeComparisonStateCopyWith<SizeComparisonState> get copyWith => _$SizeComparisonStateCopyWithImpl<SizeComparisonState>(this as SizeComparisonState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SizeComparisonState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.lastResult, lastResult) || other.lastResult == lastResult)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,lastResult,epoch);

@override
String toString() {
  return 'SizeComparisonState(phase: $phase, settings: $settings, session: $session, lastResult: $lastResult, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class $SizeComparisonStateCopyWith<$Res>  {
  factory $SizeComparisonStateCopyWith(SizeComparisonState value, $Res Function(SizeComparisonState) _then) = _$SizeComparisonStateCopyWithImpl;
@useResult
$Res call({
 CommonGamePhase phase, SizeComparisonSettings? settings, SizeComparisonSession? session, AnswerResult? lastResult, int epoch
});


$SizeComparisonSettingsCopyWith<$Res>? get settings;$SizeComparisonSessionCopyWith<$Res>? get session;$AnswerResultCopyWith<$Res>? get lastResult;

}
/// @nodoc
class _$SizeComparisonStateCopyWithImpl<$Res>
    implements $SizeComparisonStateCopyWith<$Res> {
  _$SizeComparisonStateCopyWithImpl(this._self, this._then);

  final SizeComparisonState _self;
  final $Res Function(SizeComparisonState) _then;

/// Create a copy of SizeComparisonState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? lastResult = freezed,Object? epoch = null,}) {
  return _then(_self.copyWith(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as SizeComparisonSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as SizeComparisonSession?,lastResult: freezed == lastResult ? _self.lastResult : lastResult // ignore: cast_nullable_to_non_nullable
as AnswerResult?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of SizeComparisonState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SizeComparisonSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $SizeComparisonSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of SizeComparisonState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SizeComparisonSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $SizeComparisonSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of SizeComparisonState
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


/// Adds pattern-matching-related methods to [SizeComparisonState].
extension SizeComparisonStatePatterns on SizeComparisonState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SizeComparisonState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SizeComparisonState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SizeComparisonState value)  $default,){
final _that = this;
switch (_that) {
case _SizeComparisonState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SizeComparisonState value)?  $default,){
final _that = this;
switch (_that) {
case _SizeComparisonState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CommonGamePhase phase,  SizeComparisonSettings? settings,  SizeComparisonSession? session,  AnswerResult? lastResult,  int epoch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SizeComparisonState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CommonGamePhase phase,  SizeComparisonSettings? settings,  SizeComparisonSession? session,  AnswerResult? lastResult,  int epoch)  $default,) {final _that = this;
switch (_that) {
case _SizeComparisonState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CommonGamePhase phase,  SizeComparisonSettings? settings,  SizeComparisonSession? session,  AnswerResult? lastResult,  int epoch)?  $default,) {final _that = this;
switch (_that) {
case _SizeComparisonState() when $default != null:
return $default(_that.phase,_that.settings,_that.session,_that.lastResult,_that.epoch);case _:
  return null;

}
}

}

/// @nodoc


class _SizeComparisonState extends SizeComparisonState {
  const _SizeComparisonState({this.phase = CommonGamePhase.ready, this.settings, this.session, this.lastResult, this.epoch = 0}): super._();
  

@override@JsonKey() final  CommonGamePhase phase;
@override final  SizeComparisonSettings? settings;
@override final  SizeComparisonSession? session;
@override final  AnswerResult? lastResult;
@override@JsonKey() final  int epoch;

/// Create a copy of SizeComparisonState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SizeComparisonStateCopyWith<_SizeComparisonState> get copyWith => __$SizeComparisonStateCopyWithImpl<_SizeComparisonState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SizeComparisonState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.lastResult, lastResult) || other.lastResult == lastResult)&&(identical(other.epoch, epoch) || other.epoch == epoch));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,lastResult,epoch);

@override
String toString() {
  return 'SizeComparisonState(phase: $phase, settings: $settings, session: $session, lastResult: $lastResult, epoch: $epoch)';
}


}

/// @nodoc
abstract mixin class _$SizeComparisonStateCopyWith<$Res> implements $SizeComparisonStateCopyWith<$Res> {
  factory _$SizeComparisonStateCopyWith(_SizeComparisonState value, $Res Function(_SizeComparisonState) _then) = __$SizeComparisonStateCopyWithImpl;
@override @useResult
$Res call({
 CommonGamePhase phase, SizeComparisonSettings? settings, SizeComparisonSession? session, AnswerResult? lastResult, int epoch
});


@override $SizeComparisonSettingsCopyWith<$Res>? get settings;@override $SizeComparisonSessionCopyWith<$Res>? get session;@override $AnswerResultCopyWith<$Res>? get lastResult;

}
/// @nodoc
class __$SizeComparisonStateCopyWithImpl<$Res>
    implements _$SizeComparisonStateCopyWith<$Res> {
  __$SizeComparisonStateCopyWithImpl(this._self, this._then);

  final _SizeComparisonState _self;
  final $Res Function(_SizeComparisonState) _then;

/// Create a copy of SizeComparisonState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? lastResult = freezed,Object? epoch = null,}) {
  return _then(_SizeComparisonState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as SizeComparisonSettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as SizeComparisonSession?,lastResult: freezed == lastResult ? _self.lastResult : lastResult // ignore: cast_nullable_to_non_nullable
as AnswerResult?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of SizeComparisonState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SizeComparisonSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $SizeComparisonSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of SizeComparisonState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SizeComparisonSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $SizeComparisonSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of SizeComparisonState
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
