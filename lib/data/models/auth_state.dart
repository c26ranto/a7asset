import 'package:assets_mobile/data/models/cutom_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

enum AuthStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    required AuthStatus status,
    required String? result,
    required CustomError error,
  }) = _AuthState;

  factory AuthState.initial() {
    return const AuthState(status: AuthStatus.initial, result: "", error: CustomError());
  }
}
