// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'placement_memory_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GridItem {

 String get word; int get gridIndex;
/// Create a copy of GridItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GridItemCopyWith<GridItem> get copyWith => _$GridItemCopyWithImpl<GridItem>(this as GridItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GridItem&&(identical(other.word, word) || other.word == word)&&(identical(other.gridIndex, gridIndex) || other.gridIndex == gridIndex));
}


@override
int get hashCode => Object.hash(runtimeType,word,gridIndex);

@override
String toString() {
  return 'GridItem(word: $word, gridIndex: $gridIndex)';
}


}

/// @nodoc
abstract mixin class $GridItemCopyWith<$Res>  {
  factory $GridItemCopyWith(GridItem value, $Res Function(GridItem) _then) = _$GridItemCopyWithImpl;
@useResult
$Res call({
 String word, int gridIndex
});




}
/// @nodoc
class _$GridItemCopyWithImpl<$Res>
    implements $GridItemCopyWith<$Res> {
  _$GridItemCopyWithImpl(this._self, this._then);

  final GridItem _self;
  final $Res Function(GridItem) _then;

/// Create a copy of GridItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? word = null,Object? gridIndex = null,}) {
  return _then(_self.copyWith(
word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,gridIndex: null == gridIndex ? _self.gridIndex : gridIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GridItem].
extension GridItemPatterns on GridItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GridItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GridItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GridItem value)  $default,){
final _that = this;
switch (_that) {
case _GridItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GridItem value)?  $default,){
final _that = this;
switch (_that) {
case _GridItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String word,  int gridIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GridItem() when $default != null:
return $default(_that.word,_that.gridIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String word,  int gridIndex)  $default,) {final _that = this;
switch (_that) {
case _GridItem():
return $default(_that.word,_that.gridIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String word,  int gridIndex)?  $default,) {final _that = this;
switch (_that) {
case _GridItem() when $default != null:
return $default(_that.word,_that.gridIndex);case _:
  return null;

}
}

}

/// @nodoc


class _GridItem extends GridItem {
  const _GridItem({required this.word, required this.gridIndex}): super._();
  

@override final  String word;
@override final  int gridIndex;

/// Create a copy of GridItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GridItemCopyWith<_GridItem> get copyWith => __$GridItemCopyWithImpl<_GridItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GridItem&&(identical(other.word, word) || other.word == word)&&(identical(other.gridIndex, gridIndex) || other.gridIndex == gridIndex));
}


@override
int get hashCode => Object.hash(runtimeType,word,gridIndex);

@override
String toString() {
  return 'GridItem(word: $word, gridIndex: $gridIndex)';
}


}

/// @nodoc
abstract mixin class _$GridItemCopyWith<$Res> implements $GridItemCopyWith<$Res> {
  factory _$GridItemCopyWith(_GridItem value, $Res Function(_GridItem) _then) = __$GridItemCopyWithImpl;
@override @useResult
$Res call({
 String word, int gridIndex
});




}
/// @nodoc
class __$GridItemCopyWithImpl<$Res>
    implements _$GridItemCopyWith<$Res> {
  __$GridItemCopyWithImpl(this._self, this._then);

  final _GridItem _self;
  final $Res Function(_GridItem) _then;

/// Create a copy of GridItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? word = null,Object? gridIndex = null,}) {
  return _then(_GridItem(
word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,gridIndex: null == gridIndex ? _self.gridIndex : gridIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$PlacementMemorySettings {

 int get questionCount; int get rows;// グリッドの行数
 int get cols;// グリッドの列数
 int? get itemCount;
/// Create a copy of PlacementMemorySettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacementMemorySettingsCopyWith<PlacementMemorySettings> get copyWith => _$PlacementMemorySettingsCopyWithImpl<PlacementMemorySettings>(this as PlacementMemorySettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacementMemorySettings&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.rows, rows) || other.rows == rows)&&(identical(other.cols, cols) || other.cols == cols)&&(identical(other.itemCount, itemCount) || other.itemCount == itemCount));
}


@override
int get hashCode => Object.hash(runtimeType,questionCount,rows,cols,itemCount);

@override
String toString() {
  return 'PlacementMemorySettings(questionCount: $questionCount, rows: $rows, cols: $cols, itemCount: $itemCount)';
}


}

/// @nodoc
abstract mixin class $PlacementMemorySettingsCopyWith<$Res>  {
  factory $PlacementMemorySettingsCopyWith(PlacementMemorySettings value, $Res Function(PlacementMemorySettings) _then) = _$PlacementMemorySettingsCopyWithImpl;
@useResult
$Res call({
 int questionCount, int rows, int cols, int? itemCount
});




}
/// @nodoc
class _$PlacementMemorySettingsCopyWithImpl<$Res>
    implements $PlacementMemorySettingsCopyWith<$Res> {
  _$PlacementMemorySettingsCopyWithImpl(this._self, this._then);

  final PlacementMemorySettings _self;
  final $Res Function(PlacementMemorySettings) _then;

/// Create a copy of PlacementMemorySettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionCount = null,Object? rows = null,Object? cols = null,Object? itemCount = freezed,}) {
  return _then(_self.copyWith(
questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as int,cols: null == cols ? _self.cols : cols // ignore: cast_nullable_to_non_nullable
as int,itemCount: freezed == itemCount ? _self.itemCount : itemCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlacementMemorySettings].
extension PlacementMemorySettingsPatterns on PlacementMemorySettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlacementMemorySettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlacementMemorySettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlacementMemorySettings value)  $default,){
final _that = this;
switch (_that) {
case _PlacementMemorySettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlacementMemorySettings value)?  $default,){
final _that = this;
switch (_that) {
case _PlacementMemorySettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int questionCount,  int rows,  int cols,  int? itemCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlacementMemorySettings() when $default != null:
return $default(_that.questionCount,_that.rows,_that.cols,_that.itemCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int questionCount,  int rows,  int cols,  int? itemCount)  $default,) {final _that = this;
switch (_that) {
case _PlacementMemorySettings():
return $default(_that.questionCount,_that.rows,_that.cols,_that.itemCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int questionCount,  int rows,  int cols,  int? itemCount)?  $default,) {final _that = this;
switch (_that) {
case _PlacementMemorySettings() when $default != null:
return $default(_that.questionCount,_that.rows,_that.cols,_that.itemCount);case _:
  return null;

}
}

}

/// @nodoc


class _PlacementMemorySettings extends PlacementMemorySettings {
  const _PlacementMemorySettings({this.questionCount = 3, this.rows = 2, this.cols = 2, this.itemCount}): super._();
  

@override@JsonKey() final  int questionCount;
@override@JsonKey() final  int rows;
// グリッドの行数
@override@JsonKey() final  int cols;
// グリッドの列数
@override final  int? itemCount;

/// Create a copy of PlacementMemorySettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlacementMemorySettingsCopyWith<_PlacementMemorySettings> get copyWith => __$PlacementMemorySettingsCopyWithImpl<_PlacementMemorySettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlacementMemorySettings&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.rows, rows) || other.rows == rows)&&(identical(other.cols, cols) || other.cols == cols)&&(identical(other.itemCount, itemCount) || other.itemCount == itemCount));
}


@override
int get hashCode => Object.hash(runtimeType,questionCount,rows,cols,itemCount);

@override
String toString() {
  return 'PlacementMemorySettings(questionCount: $questionCount, rows: $rows, cols: $cols, itemCount: $itemCount)';
}


}

/// @nodoc
abstract mixin class _$PlacementMemorySettingsCopyWith<$Res> implements $PlacementMemorySettingsCopyWith<$Res> {
  factory _$PlacementMemorySettingsCopyWith(_PlacementMemorySettings value, $Res Function(_PlacementMemorySettings) _then) = __$PlacementMemorySettingsCopyWithImpl;
@override @useResult
$Res call({
 int questionCount, int rows, int cols, int? itemCount
});




}
/// @nodoc
class __$PlacementMemorySettingsCopyWithImpl<$Res>
    implements _$PlacementMemorySettingsCopyWith<$Res> {
  __$PlacementMemorySettingsCopyWithImpl(this._self, this._then);

  final _PlacementMemorySettings _self;
  final $Res Function(_PlacementMemorySettings) _then;

/// Create a copy of PlacementMemorySettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionCount = null,Object? rows = null,Object? cols = null,Object? itemCount = freezed,}) {
  return _then(_PlacementMemorySettings(
questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as int,cols: null == cols ? _self.cols : cols // ignore: cast_nullable_to_non_nullable
as int,itemCount: freezed == itemCount ? _self.itemCount : itemCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$PlacementMemoryProblem {

 List<GridItem> get items;
/// Create a copy of PlacementMemoryProblem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacementMemoryProblemCopyWith<PlacementMemoryProblem> get copyWith => _$PlacementMemoryProblemCopyWithImpl<PlacementMemoryProblem>(this as PlacementMemoryProblem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacementMemoryProblem&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'PlacementMemoryProblem(items: $items)';
}


}

/// @nodoc
abstract mixin class $PlacementMemoryProblemCopyWith<$Res>  {
  factory $PlacementMemoryProblemCopyWith(PlacementMemoryProblem value, $Res Function(PlacementMemoryProblem) _then) = _$PlacementMemoryProblemCopyWithImpl;
@useResult
$Res call({
 List<GridItem> items
});




}
/// @nodoc
class _$PlacementMemoryProblemCopyWithImpl<$Res>
    implements $PlacementMemoryProblemCopyWith<$Res> {
  _$PlacementMemoryProblemCopyWithImpl(this._self, this._then);

  final PlacementMemoryProblem _self;
  final $Res Function(PlacementMemoryProblem) _then;

/// Create a copy of PlacementMemoryProblem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<GridItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlacementMemoryProblem].
extension PlacementMemoryProblemPatterns on PlacementMemoryProblem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlacementMemoryProblem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlacementMemoryProblem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlacementMemoryProblem value)  $default,){
final _that = this;
switch (_that) {
case _PlacementMemoryProblem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlacementMemoryProblem value)?  $default,){
final _that = this;
switch (_that) {
case _PlacementMemoryProblem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<GridItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlacementMemoryProblem() when $default != null:
return $default(_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<GridItem> items)  $default,) {final _that = this;
switch (_that) {
case _PlacementMemoryProblem():
return $default(_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<GridItem> items)?  $default,) {final _that = this;
switch (_that) {
case _PlacementMemoryProblem() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _PlacementMemoryProblem implements PlacementMemoryProblem {
  const _PlacementMemoryProblem({required final  List<GridItem> items}): _items = items;
  

 final  List<GridItem> _items;
@override List<GridItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of PlacementMemoryProblem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlacementMemoryProblemCopyWith<_PlacementMemoryProblem> get copyWith => __$PlacementMemoryProblemCopyWithImpl<_PlacementMemoryProblem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlacementMemoryProblem&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'PlacementMemoryProblem(items: $items)';
}


}

/// @nodoc
abstract mixin class _$PlacementMemoryProblemCopyWith<$Res> implements $PlacementMemoryProblemCopyWith<$Res> {
  factory _$PlacementMemoryProblemCopyWith(_PlacementMemoryProblem value, $Res Function(_PlacementMemoryProblem) _then) = __$PlacementMemoryProblemCopyWithImpl;
@override @useResult
$Res call({
 List<GridItem> items
});




}
/// @nodoc
class __$PlacementMemoryProblemCopyWithImpl<$Res>
    implements _$PlacementMemoryProblemCopyWith<$Res> {
  __$PlacementMemoryProblemCopyWithImpl(this._self, this._then);

  final _PlacementMemoryProblem _self;
  final $Res Function(_PlacementMemoryProblem) _then;

/// Create a copy of PlacementMemoryProblem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_PlacementMemoryProblem(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<GridItem>,
  ));
}


}

/// @nodoc
mixin _$PlacementMemorySession {

 int get index; int get total; List<bool?> get results; PlacementMemoryProblem? get currentProblem; int get wrongAttempts; List<GridItem> get userPlacement;
/// Create a copy of PlacementMemorySession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacementMemorySessionCopyWith<PlacementMemorySession> get copyWith => _$PlacementMemorySessionCopyWithImpl<PlacementMemorySession>(this as PlacementMemorySession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacementMemorySession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&(identical(other.wrongAttempts, wrongAttempts) || other.wrongAttempts == wrongAttempts)&&const DeepCollectionEquality().equals(other.userPlacement, userPlacement));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(results),currentProblem,wrongAttempts,const DeepCollectionEquality().hash(userPlacement));

@override
String toString() {
  return 'PlacementMemorySession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, wrongAttempts: $wrongAttempts, userPlacement: $userPlacement)';
}


}

/// @nodoc
abstract mixin class $PlacementMemorySessionCopyWith<$Res>  {
  factory $PlacementMemorySessionCopyWith(PlacementMemorySession value, $Res Function(PlacementMemorySession) _then) = _$PlacementMemorySessionCopyWithImpl;
@useResult
$Res call({
 int index, int total, List<bool?> results, PlacementMemoryProblem? currentProblem, int wrongAttempts, List<GridItem> userPlacement
});


$PlacementMemoryProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class _$PlacementMemorySessionCopyWithImpl<$Res>
    implements $PlacementMemorySessionCopyWith<$Res> {
  _$PlacementMemorySessionCopyWithImpl(this._self, this._then);

  final PlacementMemorySession _self;
  final $Res Function(PlacementMemorySession) _then;

/// Create a copy of PlacementMemorySession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? wrongAttempts = null,Object? userPlacement = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as PlacementMemoryProblem?,wrongAttempts: null == wrongAttempts ? _self.wrongAttempts : wrongAttempts // ignore: cast_nullable_to_non_nullable
as int,userPlacement: null == userPlacement ? _self.userPlacement : userPlacement // ignore: cast_nullable_to_non_nullable
as List<GridItem>,
  ));
}
/// Create a copy of PlacementMemorySession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlacementMemoryProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $PlacementMemoryProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlacementMemorySession].
extension PlacementMemorySessionPatterns on PlacementMemorySession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlacementMemorySession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlacementMemorySession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlacementMemorySession value)  $default,){
final _that = this;
switch (_that) {
case _PlacementMemorySession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlacementMemorySession value)?  $default,){
final _that = this;
switch (_that) {
case _PlacementMemorySession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  PlacementMemoryProblem? currentProblem,  int wrongAttempts,  List<GridItem> userPlacement)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlacementMemorySession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAttempts,_that.userPlacement);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  int total,  List<bool?> results,  PlacementMemoryProblem? currentProblem,  int wrongAttempts,  List<GridItem> userPlacement)  $default,) {final _that = this;
switch (_that) {
case _PlacementMemorySession():
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAttempts,_that.userPlacement);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  int total,  List<bool?> results,  PlacementMemoryProblem? currentProblem,  int wrongAttempts,  List<GridItem> userPlacement)?  $default,) {final _that = this;
switch (_that) {
case _PlacementMemorySession() when $default != null:
return $default(_that.index,_that.total,_that.results,_that.currentProblem,_that.wrongAttempts,_that.userPlacement);case _:
  return null;

}
}

}

/// @nodoc


class _PlacementMemorySession extends PlacementMemorySession {
  const _PlacementMemorySession({required this.index, required this.total, required final  List<bool?> results, this.currentProblem, this.wrongAttempts = 0, final  List<GridItem> userPlacement = const []}): _results = results,_userPlacement = userPlacement,super._();
  

@override final  int index;
@override final  int total;
 final  List<bool?> _results;
@override List<bool?> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override final  PlacementMemoryProblem? currentProblem;
@override@JsonKey() final  int wrongAttempts;
 final  List<GridItem> _userPlacement;
@override@JsonKey() List<GridItem> get userPlacement {
  if (_userPlacement is EqualUnmodifiableListView) return _userPlacement;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_userPlacement);
}


/// Create a copy of PlacementMemorySession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlacementMemorySessionCopyWith<_PlacementMemorySession> get copyWith => __$PlacementMemorySessionCopyWithImpl<_PlacementMemorySession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlacementMemorySession&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.currentProblem, currentProblem) || other.currentProblem == currentProblem)&&(identical(other.wrongAttempts, wrongAttempts) || other.wrongAttempts == wrongAttempts)&&const DeepCollectionEquality().equals(other._userPlacement, _userPlacement));
}


@override
int get hashCode => Object.hash(runtimeType,index,total,const DeepCollectionEquality().hash(_results),currentProblem,wrongAttempts,const DeepCollectionEquality().hash(_userPlacement));

@override
String toString() {
  return 'PlacementMemorySession(index: $index, total: $total, results: $results, currentProblem: $currentProblem, wrongAttempts: $wrongAttempts, userPlacement: $userPlacement)';
}


}

/// @nodoc
abstract mixin class _$PlacementMemorySessionCopyWith<$Res> implements $PlacementMemorySessionCopyWith<$Res> {
  factory _$PlacementMemorySessionCopyWith(_PlacementMemorySession value, $Res Function(_PlacementMemorySession) _then) = __$PlacementMemorySessionCopyWithImpl;
@override @useResult
$Res call({
 int index, int total, List<bool?> results, PlacementMemoryProblem? currentProblem, int wrongAttempts, List<GridItem> userPlacement
});


@override $PlacementMemoryProblemCopyWith<$Res>? get currentProblem;

}
/// @nodoc
class __$PlacementMemorySessionCopyWithImpl<$Res>
    implements _$PlacementMemorySessionCopyWith<$Res> {
  __$PlacementMemorySessionCopyWithImpl(this._self, this._then);

  final _PlacementMemorySession _self;
  final $Res Function(_PlacementMemorySession) _then;

/// Create a copy of PlacementMemorySession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? total = null,Object? results = null,Object? currentProblem = freezed,Object? wrongAttempts = null,Object? userPlacement = null,}) {
  return _then(_PlacementMemorySession(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<bool?>,currentProblem: freezed == currentProblem ? _self.currentProblem : currentProblem // ignore: cast_nullable_to_non_nullable
as PlacementMemoryProblem?,wrongAttempts: null == wrongAttempts ? _self.wrongAttempts : wrongAttempts // ignore: cast_nullable_to_non_nullable
as int,userPlacement: null == userPlacement ? _self._userPlacement : userPlacement // ignore: cast_nullable_to_non_nullable
as List<GridItem>,
  ));
}

/// Create a copy of PlacementMemorySession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlacementMemoryProblemCopyWith<$Res>? get currentProblem {
    if (_self.currentProblem == null) {
    return null;
  }

  return $PlacementMemoryProblemCopyWith<$Res>(_self.currentProblem!, (value) {
    return _then(_self.copyWith(currentProblem: value));
  });
}
}

/// @nodoc
mixin _$PlacementMemoryState {

 CommonGamePhase get phase; PlacementMemorySettings? get settings; PlacementMemorySession? get session; int get epoch; bool get showingAnswer;
/// Create a copy of PlacementMemoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacementMemoryStateCopyWith<PlacementMemoryState> get copyWith => _$PlacementMemoryStateCopyWithImpl<PlacementMemoryState>(this as PlacementMemoryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacementMemoryState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.epoch, epoch) || other.epoch == epoch)&&(identical(other.showingAnswer, showingAnswer) || other.showingAnswer == showingAnswer));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,epoch,showingAnswer);

@override
String toString() {
  return 'PlacementMemoryState(phase: $phase, settings: $settings, session: $session, epoch: $epoch, showingAnswer: $showingAnswer)';
}


}

/// @nodoc
abstract mixin class $PlacementMemoryStateCopyWith<$Res>  {
  factory $PlacementMemoryStateCopyWith(PlacementMemoryState value, $Res Function(PlacementMemoryState) _then) = _$PlacementMemoryStateCopyWithImpl;
@useResult
$Res call({
 CommonGamePhase phase, PlacementMemorySettings? settings, PlacementMemorySession? session, int epoch, bool showingAnswer
});


$PlacementMemorySettingsCopyWith<$Res>? get settings;$PlacementMemorySessionCopyWith<$Res>? get session;

}
/// @nodoc
class _$PlacementMemoryStateCopyWithImpl<$Res>
    implements $PlacementMemoryStateCopyWith<$Res> {
  _$PlacementMemoryStateCopyWithImpl(this._self, this._then);

  final PlacementMemoryState _self;
  final $Res Function(PlacementMemoryState) _then;

/// Create a copy of PlacementMemoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? epoch = null,Object? showingAnswer = null,}) {
  return _then(_self.copyWith(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as PlacementMemorySettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as PlacementMemorySession?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,showingAnswer: null == showingAnswer ? _self.showingAnswer : showingAnswer // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of PlacementMemoryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlacementMemorySettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $PlacementMemorySettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of PlacementMemoryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlacementMemorySessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $PlacementMemorySessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlacementMemoryState].
extension PlacementMemoryStatePatterns on PlacementMemoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlacementMemoryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlacementMemoryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlacementMemoryState value)  $default,){
final _that = this;
switch (_that) {
case _PlacementMemoryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlacementMemoryState value)?  $default,){
final _that = this;
switch (_that) {
case _PlacementMemoryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CommonGamePhase phase,  PlacementMemorySettings? settings,  PlacementMemorySession? session,  int epoch,  bool showingAnswer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlacementMemoryState() when $default != null:
return $default(_that.phase,_that.settings,_that.session,_that.epoch,_that.showingAnswer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CommonGamePhase phase,  PlacementMemorySettings? settings,  PlacementMemorySession? session,  int epoch,  bool showingAnswer)  $default,) {final _that = this;
switch (_that) {
case _PlacementMemoryState():
return $default(_that.phase,_that.settings,_that.session,_that.epoch,_that.showingAnswer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CommonGamePhase phase,  PlacementMemorySettings? settings,  PlacementMemorySession? session,  int epoch,  bool showingAnswer)?  $default,) {final _that = this;
switch (_that) {
case _PlacementMemoryState() when $default != null:
return $default(_that.phase,_that.settings,_that.session,_that.epoch,_that.showingAnswer);case _:
  return null;

}
}

}

/// @nodoc


class _PlacementMemoryState extends PlacementMemoryState {
  const _PlacementMemoryState({this.phase = CommonGamePhase.ready, this.settings, this.session, this.epoch = 0, this.showingAnswer = false}): super._();
  

@override@JsonKey() final  CommonGamePhase phase;
@override final  PlacementMemorySettings? settings;
@override final  PlacementMemorySession? session;
@override@JsonKey() final  int epoch;
@override@JsonKey() final  bool showingAnswer;

/// Create a copy of PlacementMemoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlacementMemoryStateCopyWith<_PlacementMemoryState> get copyWith => __$PlacementMemoryStateCopyWithImpl<_PlacementMemoryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlacementMemoryState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.session, session) || other.session == session)&&(identical(other.epoch, epoch) || other.epoch == epoch)&&(identical(other.showingAnswer, showingAnswer) || other.showingAnswer == showingAnswer));
}


@override
int get hashCode => Object.hash(runtimeType,phase,settings,session,epoch,showingAnswer);

@override
String toString() {
  return 'PlacementMemoryState(phase: $phase, settings: $settings, session: $session, epoch: $epoch, showingAnswer: $showingAnswer)';
}


}

/// @nodoc
abstract mixin class _$PlacementMemoryStateCopyWith<$Res> implements $PlacementMemoryStateCopyWith<$Res> {
  factory _$PlacementMemoryStateCopyWith(_PlacementMemoryState value, $Res Function(_PlacementMemoryState) _then) = __$PlacementMemoryStateCopyWithImpl;
@override @useResult
$Res call({
 CommonGamePhase phase, PlacementMemorySettings? settings, PlacementMemorySession? session, int epoch, bool showingAnswer
});


@override $PlacementMemorySettingsCopyWith<$Res>? get settings;@override $PlacementMemorySessionCopyWith<$Res>? get session;

}
/// @nodoc
class __$PlacementMemoryStateCopyWithImpl<$Res>
    implements _$PlacementMemoryStateCopyWith<$Res> {
  __$PlacementMemoryStateCopyWithImpl(this._self, this._then);

  final _PlacementMemoryState _self;
  final $Res Function(_PlacementMemoryState) _then;

/// Create a copy of PlacementMemoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? settings = freezed,Object? session = freezed,Object? epoch = null,Object? showingAnswer = null,}) {
  return _then(_PlacementMemoryState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CommonGamePhase,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as PlacementMemorySettings?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as PlacementMemorySession?,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,showingAnswer: null == showingAnswer ? _self.showingAnswer : showingAnswer // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of PlacementMemoryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlacementMemorySettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $PlacementMemorySettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of PlacementMemoryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlacementMemorySessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $PlacementMemorySessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

// dart format on
