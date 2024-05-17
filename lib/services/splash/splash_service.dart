import 'dart:developer';

import 'package:assets_mobile/config/http_client.dart';
import 'package:assets_mobile/data/models/cutom_error.dart';
import 'package:assets_mobile/data/models/http_client_params.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashService {
  SplashService({required this.ref});

  final Ref ref;

  late SharedPreferences preferences;

  Future<Map<String, dynamic>> getConList() async {
    AppPrint.debugLog("GET CON LIST CALLED");
    try {
      final params = HttpClientParams(
        path: "getConnList",
      );

      final response = await ref.read(httpClientProvider(params)).callHttp;

      log("RESPONSE GET CON LIST: $response");

      if (response.containsKey("data") && response["data"] == null) throw const CustomError(errorMessage: "Maaf, terjadi kesalahan, tidak ada data tersedia.");

      return response;
    } catch (e, st) {
      AppPrint.debugLog("Error get con list: $e $st");
      rethrow;
    }
  }
}
