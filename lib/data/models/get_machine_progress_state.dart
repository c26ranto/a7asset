import 'package:assets_mobile/data/models/cutom_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_machine_progress_state.freezed.dart';

enum GetMachineProgressStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class GetMachineProgressState with _$GetMachineProgressState {
  const factory GetMachineProgressState({
    required GetMachineProgressStatus status,
    required String? success,
    required CustomError customError,
  }) = _GetMachineProgressState;

  factory GetMachineProgressState.initial() {
    return const GetMachineProgressState(
        status: GetMachineProgressStatus.initial,
        success: null,
        customError: CustomError());
  }
}
