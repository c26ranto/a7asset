import 'package:assets_mobile/data/models/cutom_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_checklist_state.freezed.dart';

enum SaveChecklistStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class SaveChecklistState with _$SaveChecklistState {
  const factory SaveChecklistState({
    required SaveChecklistStatus status,
    required String? success,
    required CustomError customError,
  }) = _SaveChecklistState;

  factory SaveChecklistState.initial() {
    return const SaveChecklistState(status: SaveChecklistStatus.initial, success: null, customError: CustomError());
  }
}
