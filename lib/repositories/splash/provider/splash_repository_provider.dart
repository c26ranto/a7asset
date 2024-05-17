import 'package:assets_mobile/repositories/splash/splash_repository.dart';
import 'package:assets_mobile/services/splash/provider/splash_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_repository_provider.g.dart';

@riverpod
SplashRepository splashRepository(SplashRepositoryRef ref) {
  return SplashRepository(splashService: ref.watch(splashServiceProvider));
}
