import 'package:assets_mobile/data/models/cutom_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generate_clhead_state.freezed.dart';

enum GenerateClheadStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class GenerateClheadState with _$GenerateClheadState {
  const factory GenerateClheadState({
    required GenerateClheadStatus status,
    required String? success,
    required CustomError customError,
  }) = _GenerateClheadState;

  factory GenerateClheadState.initial() {
    return const GenerateClheadState(
        status: GenerateClheadStatus.initial,
        success: null,
        customError: CustomError());
  }
}
