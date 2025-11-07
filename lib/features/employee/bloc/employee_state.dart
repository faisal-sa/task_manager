import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_state.freezed.dart';

@freezed
class EmployeeState with _$EmployeeState {
  const factory EmployeeState.initial() = _Initial;

  const factory EmployeeState.loading() = _Loading;

  const factory EmployeeState.loaded({required List<String> employees}) =
      _Loaded;
}
