// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manager_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ManagerEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManagerEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ManagerEvent()';
}


}

/// @nodoc
class $ManagerEventCopyWith<$Res>  {
$ManagerEventCopyWith(ManagerEvent _, $Res Function(ManagerEvent) __);
}


/// Adds pattern-matching-related methods to [ManagerEvent].
extension ManagerEventPatterns on ManagerEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _FetchAllData value)?  fetchAllData,TResult Function( _DeleteTask value)?  deleteTask,TResult Function( _FilterChanged value)?  filterChanged,TResult Function( _SearchQueryChanged value)?  searchQueryChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchAllData() when fetchAllData != null:
return fetchAllData(_that);case _DeleteTask() when deleteTask != null:
return deleteTask(_that);case _FilterChanged() when filterChanged != null:
return filterChanged(_that);case _SearchQueryChanged() when searchQueryChanged != null:
return searchQueryChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _FetchAllData value)  fetchAllData,required TResult Function( _DeleteTask value)  deleteTask,required TResult Function( _FilterChanged value)  filterChanged,required TResult Function( _SearchQueryChanged value)  searchQueryChanged,}){
final _that = this;
switch (_that) {
case _FetchAllData():
return fetchAllData(_that);case _DeleteTask():
return deleteTask(_that);case _FilterChanged():
return filterChanged(_that);case _SearchQueryChanged():
return searchQueryChanged(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _FetchAllData value)?  fetchAllData,TResult? Function( _DeleteTask value)?  deleteTask,TResult? Function( _FilterChanged value)?  filterChanged,TResult? Function( _SearchQueryChanged value)?  searchQueryChanged,}){
final _that = this;
switch (_that) {
case _FetchAllData() when fetchAllData != null:
return fetchAllData(_that);case _DeleteTask() when deleteTask != null:
return deleteTask(_that);case _FilterChanged() when filterChanged != null:
return filterChanged(_that);case _SearchQueryChanged() when searchQueryChanged != null:
return searchQueryChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchAllData,TResult Function( String taskId)?  deleteTask,TResult Function( TaskFilter filter)?  filterChanged,TResult Function( String query)?  searchQueryChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchAllData() when fetchAllData != null:
return fetchAllData();case _DeleteTask() when deleteTask != null:
return deleteTask(_that.taskId);case _FilterChanged() when filterChanged != null:
return filterChanged(_that.filter);case _SearchQueryChanged() when searchQueryChanged != null:
return searchQueryChanged(_that.query);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchAllData,required TResult Function( String taskId)  deleteTask,required TResult Function( TaskFilter filter)  filterChanged,required TResult Function( String query)  searchQueryChanged,}) {final _that = this;
switch (_that) {
case _FetchAllData():
return fetchAllData();case _DeleteTask():
return deleteTask(_that.taskId);case _FilterChanged():
return filterChanged(_that.filter);case _SearchQueryChanged():
return searchQueryChanged(_that.query);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchAllData,TResult? Function( String taskId)?  deleteTask,TResult? Function( TaskFilter filter)?  filterChanged,TResult? Function( String query)?  searchQueryChanged,}) {final _that = this;
switch (_that) {
case _FetchAllData() when fetchAllData != null:
return fetchAllData();case _DeleteTask() when deleteTask != null:
return deleteTask(_that.taskId);case _FilterChanged() when filterChanged != null:
return filterChanged(_that.filter);case _SearchQueryChanged() when searchQueryChanged != null:
return searchQueryChanged(_that.query);case _:
  return null;

}
}

}

/// @nodoc


class _FetchAllData implements ManagerEvent {
  const _FetchAllData();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchAllData);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ManagerEvent.fetchAllData()';
}


}




/// @nodoc


class _DeleteTask implements ManagerEvent {
  const _DeleteTask({required this.taskId});
  

 final  String taskId;

/// Create a copy of ManagerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteTaskCopyWith<_DeleteTask> get copyWith => __$DeleteTaskCopyWithImpl<_DeleteTask>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteTask&&(identical(other.taskId, taskId) || other.taskId == taskId));
}


@override
int get hashCode => Object.hash(runtimeType,taskId);

@override
String toString() {
  return 'ManagerEvent.deleteTask(taskId: $taskId)';
}


}

/// @nodoc
abstract mixin class _$DeleteTaskCopyWith<$Res> implements $ManagerEventCopyWith<$Res> {
  factory _$DeleteTaskCopyWith(_DeleteTask value, $Res Function(_DeleteTask) _then) = __$DeleteTaskCopyWithImpl;
@useResult
$Res call({
 String taskId
});




}
/// @nodoc
class __$DeleteTaskCopyWithImpl<$Res>
    implements _$DeleteTaskCopyWith<$Res> {
  __$DeleteTaskCopyWithImpl(this._self, this._then);

  final _DeleteTask _self;
  final $Res Function(_DeleteTask) _then;

/// Create a copy of ManagerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? taskId = null,}) {
  return _then(_DeleteTask(
taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _FilterChanged implements ManagerEvent {
  const _FilterChanged({required this.filter});
  

 final  TaskFilter filter;

/// Create a copy of ManagerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilterChangedCopyWith<_FilterChanged> get copyWith => __$FilterChangedCopyWithImpl<_FilterChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilterChanged&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,filter);

@override
String toString() {
  return 'ManagerEvent.filterChanged(filter: $filter)';
}


}

/// @nodoc
abstract mixin class _$FilterChangedCopyWith<$Res> implements $ManagerEventCopyWith<$Res> {
  factory _$FilterChangedCopyWith(_FilterChanged value, $Res Function(_FilterChanged) _then) = __$FilterChangedCopyWithImpl;
@useResult
$Res call({
 TaskFilter filter
});




}
/// @nodoc
class __$FilterChangedCopyWithImpl<$Res>
    implements _$FilterChangedCopyWith<$Res> {
  __$FilterChangedCopyWithImpl(this._self, this._then);

  final _FilterChanged _self;
  final $Res Function(_FilterChanged) _then;

/// Create a copy of ManagerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filter = null,}) {
  return _then(_FilterChanged(
filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as TaskFilter,
  ));
}


}

/// @nodoc


class _SearchQueryChanged implements ManagerEvent {
  const _SearchQueryChanged({required this.query});
  

 final  String query;

/// Create a copy of ManagerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchQueryChangedCopyWith<_SearchQueryChanged> get copyWith => __$SearchQueryChangedCopyWithImpl<_SearchQueryChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchQueryChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'ManagerEvent.searchQueryChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class _$SearchQueryChangedCopyWith<$Res> implements $ManagerEventCopyWith<$Res> {
  factory _$SearchQueryChangedCopyWith(_SearchQueryChanged value, $Res Function(_SearchQueryChanged) _then) = __$SearchQueryChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$SearchQueryChangedCopyWithImpl<$Res>
    implements _$SearchQueryChangedCopyWith<$Res> {
  __$SearchQueryChangedCopyWithImpl(this._self, this._then);

  final _SearchQueryChanged _self;
  final $Res Function(_SearchQueryChanged) _then;

/// Create a copy of ManagerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_SearchQueryChanged(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
