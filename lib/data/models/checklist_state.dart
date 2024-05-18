import 'package:assets_mobile/data/models/checklist.dart';
import 'package:assets_mobile/data/models/cutom_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'checklist_state.freezed.dart';

enum ChecklistStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class ChecklistState with _$ChecklistState {
  const factory ChecklistState({
    required ChecklistStatus status,
    required List<Map<String, dynamic>>? success,
    required CustomError customError,
  }) = _ChecklistState;

  factory ChecklistState.initial() {
    return const ChecklistState(
        status: ChecklistStatus.initial,
        success: null,
        customError: CustomError());
  }
}
