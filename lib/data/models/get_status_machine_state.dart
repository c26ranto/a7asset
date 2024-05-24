import 'package:assets_mobile/data/models/cutom_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_status_machine_state.freezed.dart';

enum GetStatusMachineStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class GetStatusMachineState with _$GetStatusMachineState {
  const factory GetStatusMachineState({
    required GetStatusMachineStatus status,
    required String? success,
    required CustomError customError,
  }) = _GetStatusMachineState;

  factory GetStatusMachineState.initial() {
    return const GetStatusMachineState(
        status: GetStatusMachineStatus.initial,
        success: null,
        customError: CustomError());
  }
}
