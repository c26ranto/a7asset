import 'package:assets_mobile/data/models/auth_state.dart';
import 'package:assets_mobile/data/models/cutom_error.dart';
import 'package:assets_mobile/repositories/auth/provider/auth_repository_provider.dart';
import 'package:assets_mobile/utils/app_error_message.dart';
import 'package:assets_mobile/utils/app_key.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_provider.g.dart';

final obsecureNewPasswordProvider = StateProvider<bool>((ref) {
  return true;
});
final obsecureNewConfirmPasswordProvider = StateProvider<bool>((ref) {
  return true;
});

@riverpod
class ChangePassword extends _$ChangePassword {
  @override
  AuthState build() {
    return AuthState.initial();
  }

  Future<void> callChange(String password) async {
    state = state.copyWith(
      status: AuthStatus.loading,
    );

    try {
      final authService = ref.read(authRepositoryProvider);
      await authService.changePassword(newPassword: password);
      state = state.copyWith(status: AuthStatus.success, result: "Change passwordd success");
    } on CustomError catch (e) {
      state = state.copyWith(status: AuthStatus.failure, error: e, result: null);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.failure, error: CustomError(errorMessage: AppErrorMessage.unknownError), result: null);
    }
  }
}

@riverpod
class Logout extends _$Logout {
  @override
  AuthState build() {
    return AuthState.initial();
  }

  Future<void> callLogout() async {
    final pref = await SharedPreferences.getInstance();

    state = state.copyWith(
      status: AuthStatus.loading,
    );

    try {
      final authService = ref.read(authRepositoryProvider);
      await authService.logout();
      state = state.copyWith(status: AuthStatus.success, result: "Logout sucess");
    } on CustomError catch (e) {
      state = state.copyWith(status: AuthStatus.failure, error: e, result: null);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.failure, error: CustomError(errorMessage: AppErrorMessage.unknownError), result: null);
    } finally {
      if (state.status == AuthStatus.success) {
        pref.remove(AppKey.email);
        pref.remove(AppKey.username);
        pref.remove(AppKey.password);
        pref.remove(AppKey.refreshToken);
        pref.remove(AppKey.token);
      }
    }
  }
}
