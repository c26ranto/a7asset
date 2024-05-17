import 'package:assets_mobile/repositories/auth/auth_repository.dart';
import 'package:assets_mobile/services/auth/provider/auth_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(authService: ref.watch(authServiceProvider));
}
