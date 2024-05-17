import 'package:assets_mobile/config/http_client.dart';
import 'package:assets_mobile/data/models/http_client_params.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MaintenanceServices {
  MaintenanceServices({required this.ref});

  late SharedPreferences preferences;
  final Ref ref;

  Future fetchType() async {
    try {
      final params = HttpClientParams(
        path: "getShift",
        controller: "",
      );

      final resp = ref.read(httpClientProvider(params)).callHttp;

      return resp;
    } catch (e, st) {
      AppPrint.debugLog("ERROR FROM FETCH TYPE: $e - $st");
      rethrow;
    }
  }
}
