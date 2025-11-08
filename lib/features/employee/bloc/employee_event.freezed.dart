// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EmployeeEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmployeeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EmployeeEvent()';
}


}

/// @nodoc
class $EmployeeEventCopyWith<$Res>  {
$EmployeeEventCopyWith(EmployeeEvent _, $Res Function(EmployeeEvent) __);
}


/// Adds pattern-matching-related methods to [EmployeeEvent].
extension EmployeeEventPatterns on EmployeeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initialize value)?  initialize,TResult Function( _FetchTasks value)?  fetchTasks,TResult Function( _FilterTasks value)?  filterTasks,TResult Function( _FetchPerformanceStats value)?  fetchPerformanceStats,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initialize() when initialize != null:
return initialize(_that);case _FetchTasks() when fetchTasks != null:
return fetchTasks(_that);case _FilterTasks() when filterTasks != null:
return filterTasks(_that);case _FetchPerformanceStats() when fetchPerformanceStats != null:
return fetchPerformanceStats(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initialize value)  initialize,required TResult Function( _FetchTasks value)  fetchTasks,required TResult Function( _FilterTasks value)  filterTasks,required TResult Function( _FetchPerformanceStats value)  fetchPerformanceStats,}){
final _that = this;
switch (_that) {
case _Initialize():
return initialize(_that);case _FetchTasks():
return fetchTasks(_that);case _FilterTasks():
return filterTasks(_that);case _FetchPerformanceStats():
return fetchPerformanceStats(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initialize value)?  initialize,TResult? Function( _FetchTasks value)?  fetchTasks,TResult? Function( _FilterTasks value)?  filterTasks,TResult? Function( _FetchPerformanceStats value)?  fetchPerformanceStats,}){
final _that = this;
switch (_that) {
case _Initialize() when initialize != null:
return initialize(_that);case _FetchTasks() when fetchTasks != null:
return fetchTasks(_that);case _FilterTasks() when filterTasks != null:
return filterTasks(_that);case _FetchPerformanceStats() when fetchPerformanceStats != null:
return fetchPerformanceStats(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initialize,TResult Function( String employeeId)?  fetchTasks,TResult Function( String employeeId,  String priority)?  filterTasks,TResult Function( String employeeId)?  fetchPerformanceStats,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initialize() when initialize != null:
return initialize();case _FetchTasks() when fetchTasks != null:
return fetchTasks(_that.employeeId);case _FilterTasks() when filterTasks != null:
return filterTasks(_that.employeeId,_that.priority);case _FetchPerformanceStats() when fetchPerformanceStats != null:
return fetchPerformanceStats(_that.employeeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initialize,required TResult Function( String employeeId)  fetchTasks,required TResult Function( String employeeId,  String priority)  filterTasks,required TResult Function( String employeeId)  fetchPerformanceStats,}) {final _that = this;
switch (_that) {
case _Initialize():
return initialize();case _FetchTasks():
return fetchTasks(_that.employeeId);case _FilterTasks():
return filterTasks(_that.employeeId,_that.priority);case _FetchPerformanceStats():
return fetchPerformanceStats(_that.employeeId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initialize,TResult? Function( String employeeId)?  fetchTasks,TResult? Function( String employeeId,  String priority)?  filterTasks,TResult? Function( String employeeId)?  fetchPerformanceStats,}) {final _that = this;
switch (_that) {
case _Initialize() when initialize != null:
return initialize();case _FetchTasks() when fetchTasks != null:
return fetchTasks(_that.employeeId);case _FilterTasks() when filterTasks != null:
return filterTasks(_that.employeeId,_that.priority);case _FetchPerformanceStats() when fetchPerformanceStats != null:
return fetchPerformanceStats(_that.employeeId);case _:
  return null;

}
}

}

/// @nodoc


class _Initialize implements EmployeeEvent {
  const _Initialize();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initialize);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EmployeeEvent.initialize()';
}


}




/// @nodoc


class _FetchTasks implements EmployeeEvent {
  const _FetchTasks({required this.employeeId});
  

 final  String employeeId;

/// Create a copy of EmployeeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchTasksCopyWith<_FetchTasks> get copyWith => __$FetchTasksCopyWithImpl<_FetchTasks>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchTasks&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId));
}


@override
int get hashCode => Object.hash(runtimeType,employeeId);

@override
String toString() {
  return 'EmployeeEvent.fetchTasks(employeeId: $employeeId)';
}


}

/// @nodoc
abstract mixin class _$FetchTasksCopyWith<$Res> implements $EmployeeEventCopyWith<$Res> {
  factory _$FetchTasksCopyWith(_FetchTasks value, $Res Function(_FetchTasks) _then) = __$FetchTasksCopyWithImpl;
@useResult
$Res call({
 String employeeId
});




}
/// @nodoc
class __$FetchTasksCopyWithImpl<$Res>
    implements _$FetchTasksCopyWith<$Res> {
  __$FetchTasksCopyWithImpl(this._self, this._then);

  final _FetchTasks _self;
  final $Res Function(_FetchTasks) _then;

/// Create a copy of EmployeeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? employeeId = null,}) {
  return _then(_FetchTasks(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _FilterTasks implements EmployeeEvent {
  const _FilterTasks({required this.employeeId, required this.priority});
  

 final  String employeeId;
 final  String priority;

/// Create a copy of EmployeeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilterTasksCopyWith<_FilterTasks> get copyWith => __$FilterTasksCopyWithImpl<_FilterTasks>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilterTasks&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.priority, priority) || other.priority == priority));
}


@override
int get hashCode => Object.hash(runtimeType,employeeId,priority);

@override
String toString() {
  return 'EmployeeEvent.filterTasks(employeeId: $employeeId, priority: $priority)';
}


}

/// @nodoc
abstract mixin class _$FilterTasksCopyWith<$Res> implements $EmployeeEventCopyWith<$Res> {
  factory _$FilterTasksCopyWith(_FilterTasks value, $Res Function(_FilterTasks) _then) = __$FilterTasksCopyWithImpl;
@useResult
$Res call({
 String employeeId, String priority
});




}
/// @nodoc
class __$FilterTasksCopyWithImpl<$Res>
    implements _$FilterTasksCopyWith<$Res> {
  __$FilterTasksCopyWithImpl(this._self, this._then);

  final _FilterTasks _self;
  final $Res Function(_FilterTasks) _then;

/// Create a copy of EmployeeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? employeeId = null,Object? priority = null,}) {
  return _then(_FilterTasks(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _FetchPerformanceStats implements EmployeeEvent {
  const _FetchPerformanceStats({required this.employeeId});
  

 final  String employeeId;

/// Create a copy of EmployeeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchPerformanceStatsCopyWith<_FetchPerformanceStats> get copyWith => __$FetchPerformanceStatsCopyWithImpl<_FetchPerformanceStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchPerformanceStats&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId));
}


@override
int get hashCode => Object.hash(runtimeType,employeeId);

@override
String toString() {
  return 'EmployeeEvent.fetchPerformanceStats(employeeId: $employeeId)';
}


}

/// @nodoc
abstract mixin class _$FetchPerformanceStatsCopyWith<$Res> implements $EmployeeEventCopyWith<$Res> {
  factory _$FetchPerformanceStatsCopyWith(_FetchPerformanceStats value, $Res Function(_FetchPerformanceStats) _then) = __$FetchPerformanceStatsCopyWithImpl;
@useResult
$Res call({
 String employeeId
});




}
/// @nodoc
class __$FetchPerformanceStatsCopyWithImpl<$Res>
    implements _$FetchPerformanceStatsCopyWith<$Res> {
  __$FetchPerformanceStatsCopyWithImpl(this._self, this._then);

  final _FetchPerformanceStats _self;
  final $Res Function(_FetchPerformanceStats) _then;

/// Create a copy of EmployeeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? employeeId = null,}) {
  return _then(_FetchPerformanceStats(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
