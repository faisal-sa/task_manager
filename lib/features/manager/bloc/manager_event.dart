import 'package:freezed_annotation/freezed_annotation.dart';

part 'manager_event.freezed.dart';

@freezed
class ManagerEvent with _$ManagerEvent {
  const factory ManagerEvent.initialize() = _Initialize;
}
