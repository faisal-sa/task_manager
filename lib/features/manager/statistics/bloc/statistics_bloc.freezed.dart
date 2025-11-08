// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistics_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StatisticsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StatisticsEvent()';
}


}

/// @nodoc
class $StatisticsEventCopyWith<$Res>  {
$StatisticsEventCopyWith(StatisticsEvent _, $Res Function(StatisticsEvent) __);
}


/// Adds pattern-matching-related methods to [StatisticsEvent].
extension StatisticsEventPatterns on StatisticsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _FetchStatistics value)?  fetchStatistics,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchStatistics() when fetchStatistics != null:
return fetchStatistics(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _FetchStatistics value)  fetchStatistics,}){
final _that = this;
switch (_that) {
case _FetchStatistics():
return fetchStatistics(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _FetchStatistics value)?  fetchStatistics,}){
final _that = this;
switch (_that) {
case _FetchStatistics() when fetchStatistics != null:
return fetchStatistics(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchStatistics,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchStatistics() when fetchStatistics != null:
return fetchStatistics();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchStatistics,}) {final _that = this;
switch (_that) {
case _FetchStatistics():
return fetchStatistics();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchStatistics,}) {final _that = this;
switch (_that) {
case _FetchStatistics() when fetchStatistics != null:
return fetchStatistics();case _:
  return null;

}
}

}

/// @nodoc


class _FetchStatistics implements StatisticsEvent {
  const _FetchStatistics();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchStatistics);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StatisticsEvent.fetchStatistics()';
}


}




/// @nodoc
mixin _$StatisticsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StatisticsState()';
}


}

/// @nodoc
class $StatisticsStateCopyWith<$Res>  {
$StatisticsStateCopyWith(StatisticsState _, $Res Function(StatisticsState) __);
}


/// Adds pattern-matching-related methods to [StatisticsState].
extension StatisticsStatePatterns on StatisticsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Error value)?  error,TResult Function( _Loaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Error() when error != null:
return error(_that);case _Loaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Error value)  error,required TResult Function( _Loaded value)  loaded,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Error():
return error(_that);case _Loaded():
return loaded(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Error value)?  error,TResult? Function( _Loaded value)?  loaded,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Error() when error != null:
return error(_that);case _Loaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String message)?  error,TResult Function( int totalTaskCount,  Map<String, int> tasksByStatus,  Map<String, int> tasksByPriority,  Map<String, int> tasksPerEmployee,  Duration? averageCompletionTime)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Error() when error != null:
return error(_that.message);case _Loaded() when loaded != null:
return loaded(_that.totalTaskCount,_that.tasksByStatus,_that.tasksByPriority,_that.tasksPerEmployee,_that.averageCompletionTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String message)  error,required TResult Function( int totalTaskCount,  Map<String, int> tasksByStatus,  Map<String, int> tasksByPriority,  Map<String, int> tasksPerEmployee,  Duration? averageCompletionTime)  loaded,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Error():
return error(_that.message);case _Loaded():
return loaded(_that.totalTaskCount,_that.tasksByStatus,_that.tasksByPriority,_that.tasksPerEmployee,_that.averageCompletionTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String message)?  error,TResult? Function( int totalTaskCount,  Map<String, int> tasksByStatus,  Map<String, int> tasksByPriority,  Map<String, int> tasksPerEmployee,  Duration? averageCompletionTime)?  loaded,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Error() when error != null:
return error(_that.message);case _Loaded() when loaded != null:
return loaded(_that.totalTaskCount,_that.tasksByStatus,_that.tasksByPriority,_that.tasksPerEmployee,_that.averageCompletionTime);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements StatisticsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StatisticsState.initial()';
}


}




/// @nodoc


class _Loading implements StatisticsState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StatisticsState.loading()';
}


}




/// @nodoc


class _Error implements StatisticsState {
  const _Error({required this.message});
  

 final  String message;

/// Create a copy of StatisticsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'StatisticsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $StatisticsStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of StatisticsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Loaded implements StatisticsState {
  const _Loaded({required this.totalTaskCount, required final  Map<String, int> tasksByStatus, required final  Map<String, int> tasksByPriority, required final  Map<String, int> tasksPerEmployee, required this.averageCompletionTime}): _tasksByStatus = tasksByStatus,_tasksByPriority = tasksByPriority,_tasksPerEmployee = tasksPerEmployee;
  

 final  int totalTaskCount;
 final  Map<String, int> _tasksByStatus;
 Map<String, int> get tasksByStatus {
  if (_tasksByStatus is EqualUnmodifiableMapView) return _tasksByStatus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_tasksByStatus);
}

 final  Map<String, int> _tasksByPriority;
 Map<String, int> get tasksByPriority {
  if (_tasksByPriority is EqualUnmodifiableMapView) return _tasksByPriority;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_tasksByPriority);
}

 final  Map<String, int> _tasksPerEmployee;
 Map<String, int> get tasksPerEmployee {
  if (_tasksPerEmployee is EqualUnmodifiableMapView) return _tasksPerEmployee;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_tasksPerEmployee);
}

 final  Duration? averageCompletionTime;

/// Create a copy of StatisticsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&(identical(other.totalTaskCount, totalTaskCount) || other.totalTaskCount == totalTaskCount)&&const DeepCollectionEquality().equals(other._tasksByStatus, _tasksByStatus)&&const DeepCollectionEquality().equals(other._tasksByPriority, _tasksByPriority)&&const DeepCollectionEquality().equals(other._tasksPerEmployee, _tasksPerEmployee)&&(identical(other.averageCompletionTime, averageCompletionTime) || other.averageCompletionTime == averageCompletionTime));
}


@override
int get hashCode => Object.hash(runtimeType,totalTaskCount,const DeepCollectionEquality().hash(_tasksByStatus),const DeepCollectionEquality().hash(_tasksByPriority),const DeepCollectionEquality().hash(_tasksPerEmployee),averageCompletionTime);

@override
String toString() {
  return 'StatisticsState.loaded(totalTaskCount: $totalTaskCount, tasksByStatus: $tasksByStatus, tasksByPriority: $tasksByPriority, tasksPerEmployee: $tasksPerEmployee, averageCompletionTime: $averageCompletionTime)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $StatisticsStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 int totalTaskCount, Map<String, int> tasksByStatus, Map<String, int> tasksByPriority, Map<String, int> tasksPerEmployee, Duration? averageCompletionTime
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of StatisticsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? totalTaskCount = null,Object? tasksByStatus = null,Object? tasksByPriority = null,Object? tasksPerEmployee = null,Object? averageCompletionTime = freezed,}) {
  return _then(_Loaded(
totalTaskCount: null == totalTaskCount ? _self.totalTaskCount : totalTaskCount // ignore: cast_nullable_to_non_nullable
as int,tasksByStatus: null == tasksByStatus ? _self._tasksByStatus : tasksByStatus // ignore: cast_nullable_to_non_nullable
as Map<String, int>,tasksByPriority: null == tasksByPriority ? _self._tasksByPriority : tasksByPriority // ignore: cast_nullable_to_non_nullable
as Map<String, int>,tasksPerEmployee: null == tasksPerEmployee ? _self._tasksPerEmployee : tasksPerEmployee // ignore: cast_nullable_to_non_nullable
as Map<String, int>,averageCompletionTime: freezed == averageCompletionTime ? _self.averageCompletionTime : averageCompletionTime // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}


}

// dart format on
