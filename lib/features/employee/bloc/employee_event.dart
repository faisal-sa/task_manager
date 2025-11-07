import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_event.freezed.dart';

@freezed
class EmployeeEvent with _$EmployeeEvent {
  const factory EmployeeEvent.initialize() = _Initialize;
}
