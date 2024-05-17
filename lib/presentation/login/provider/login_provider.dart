import 'package:assets_mobile/data/models/auth_state.dart';
import 'package:assets_mobile/data/models/cutom_error.dart';
import 'package:assets_mobile/repositories/auth/provider/auth_repository_provider.dart';
import 'package:assets_mobile/utils/app_error_message.dart';
import 'package:assets_mobile/utils/app_key.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_provider.g.dart';

final obsecurePasswordProvider = StateProvider.autoDispose<bool>((ref) {
  return true;
});

final tokenProvider = StateProvider<String>((ref) {
  return "";
});

final versiProvider = StateProvider<String>((ref) {
  return "";
});

final databaseProvider = StateProvider<String>((ref) {
  return "";
});

final usernameProvider = StateProvider<String>((ref) {
  return "";
});

final emailProvider = StateProvider<String>((ref) {
  return "";
});

final serverProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

@riverpod
class Login extends _$Login {
  @override
  AuthState build() {
    return AuthState.initial();
  }

  void changeObsecure() => ref.read(obsecurePasswordProvider.notifier).update((state) => !state);

  Future<void> signIn(String username, String password, String database) async {
    state = state.copyWith(
      status: AuthStatus.loading,
    );

    try {
      final authService = ref.read(authRepositoryProvider);
      await authService.signIn(username: username, password: password, database: database);
      final prefs = await SharedPreferences.getInstance();
      ref.read(tokenProvider.notifier).update((state) => prefs.getString(AppKey.token) ?? "");
      ref.read(usernameProvider.notifier).update((state) => prefs.getString(AppKey.username) ?? "");
      ref.read(emailProvider.notifier).update((state) => prefs.getString(AppKey.email) ?? "");
      ref.read(versiProvider.notifier).update((state) => prefs.getString(AppKey.version) ?? "");
      ref.read(databaseProvider.notifier).update((state) => prefs.getString(AppKey.appDB) ?? "");

      state = state.copyWith(status: AuthStatus.success, result: "Login Success");
    } on CustomError catch (e) {
      state = state.copyWith(status: AuthStatus.failure, error: e, result: null);
    } catch (e, st) {
      AppPrint.debugLog("ERRRO SIGN IN: $e $st");
      state = state.copyWith(status: AuthStatus.failure, error: CustomError(errorMessage: AppErrorMessage.unknownError), result: null);
    }
  }
}
