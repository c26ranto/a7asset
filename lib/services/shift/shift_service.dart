import 'dart:convert';

import 'package:assets_mobile/config/http_client.dart';
import 'package:assets_mobile/data/models/http_client_params.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShiftService {
  ShiftService({required this.ref});

  final Ref ref;
  late SharedPreferences preferences;

  Future<List<Map<String, dynamic>>> getShift() async {
    try {
      final httpClientParams = HttpClientParams(
        path: "datadr",
        controller: "TBLSYS",
        filter: jsonEncode([
          {"operator": "like", "value": "SHFT", "property": "tsdscd"}
        ]),
        source: "Flutter",
        subMethod: "LoadGrid",
        limit: 10,
        start: 0,
        tipeGrid: "WithPaging",
      );

      final response = await ref.read(httpClientProvider(httpClientParams)).callHttp;

      AppPrint.debugLog("RESPONSE GET SHIFT: $response");
      return List<Map<String, dynamic>>.from(response["data"]["data"]["items"]);
    } catch (e, st) {
      AppPrint.debugLog("ERROR FROM GET SHIFT: $e $st");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getChecklistPeriod() async {
    try {
      final httpClientParams = HttpClientParams(
          path: 'datadr', controller: "MCMTCP", source: "Flutter", subMethod: "LoadGrid", tipeGrid: "WithPaging", limit: 10, start: 0, page: 1, perPage: 10);

      final response = await ref.read(httpClientProvider(httpClientParams)).callHttp;

      AppPrint.debugLog("RESPPPPO: $response");

      final item = response["data"]["data"]["items"];

      if (item == null) return [];

      return List<Map<String, dynamic>>.from(item);
    } catch (e, st) {
      AppPrint.debugLog("ERROR FROM GET CHECKLIST PERIOD: $e $st");
      rethrow;
    }
  }
}
