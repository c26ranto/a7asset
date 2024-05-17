import 'dart:async';

import 'package:assets_mobile/config/http_client_repository.dart';
import 'package:assets_mobile/services/splash/splash_service.dart';

class SplashRepository {
  final SplashService splashService;

  SplashRepository({required this.splashService});

  Future<Map<String, dynamic>> getConList() async {
    return HttpClientRepository.safeApiCall(() => splashService.getConList());
  }
}
