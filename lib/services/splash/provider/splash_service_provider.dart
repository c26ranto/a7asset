import 'package:assets_mobile/services/splash/splash_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_service_provider.g.dart';

@riverpod
SplashService splashService(SplashServiceRef ref) {
  return SplashService(ref: ref);
}
