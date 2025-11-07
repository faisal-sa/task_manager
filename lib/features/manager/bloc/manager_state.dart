import 'package:freezed_annotation/freezed_annotation.dart';

part 'manager_state.freezed.dart';

@freezed
class ManagerState with _$ManagerState {
  const factory ManagerState.initial() = _Initial;

  const factory ManagerState.loading() = _Loading;

  const factory ManagerState.loaded({required String name, List? projects}) =
      _Loaded;
}
