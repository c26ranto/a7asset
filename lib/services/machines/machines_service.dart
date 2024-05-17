import 'dart:convert';

import 'package:assets_mobile/config/http_client.dart';
import 'package:assets_mobile/data/models/http_client_params.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MachinesService {
  MachinesService({required this.ref});

  final Ref ref;
  late SharedPreferences preferences;

  Future<List<Map<String, dynamic>>> getAllMachines({required String id, required String type}) async {
    try {
      final httpClient = HttpClientParams(
        path: "datadr",
        controller: "TRLSAS",
        subMethod: "LoadGrid",
        page: 1,
        perPage: 5,
        limit: 10,
      );

      final response = await ref.read(httpClientProvider(httpClient)).callHttp;

      final data = response["data"]["data"];

      AppPrint.debugLog("C: ${data["items"]}");

      final items = List<Map<String, dynamic>>.from(data["items"]);

      return items;
    } catch (e, st) {
      AppPrint.debugLog("ERROR GET ALL MACHINE DATA: $e $st");
      rethrow;
    }
  }

  // TODO GET PROGRESS
  // Future getProgress({required String id, required String type, required String templateId, required String date, required String shift}) async {
  //   try {
  //     final httpClient = HttpClientParams(path: "datadr", controller: "TBLSYS", subMethod: "LoadGridPopup", param: {"sqlCondition": "and tsdscd = 'STSM'"});

  //     final response = await ref.read(httpClientProvider(httpClient)).callHttp;

  //     AppPrint.debugLog("RESPONSE: $response");
  //   } catch (e, st) {
  //     AppPrint.debugLog("ERROR GET PROGRESS MACHINE: $e $st");
  //     rethrow;
  //   }
  // }

  Future<List<Map<String, dynamic>>> getMachineData(String machineId) async {
    try {
      final httpClientParams = HttpClientParams(path: "datadr", controller: "MCMCTH_MCMCTD", subMethod: "LoadData", param: {"trlsno": machineId});
      final response = await ref.read(httpClientProvider(httpClientParams)).callHttp;
      AppPrint.debugLog("GET MACHINE DATA: $response");
      final data = response["data"]["Data"];

      if (data is List) {
        if (data.isEmpty) return [];
      }

      return List<Map<String, dynamic>>.from(data);
    } catch (e, st) {
      AppPrint.debugLog("ERROR GET MACHINE DATA: $e $st");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getDataChecklist() async {
    try {
      final httpClient = HttpClientParams(
        path: "datadr",
        controller: "CLHEAD",
        subMethod: "LoadGrid",
        page: 1,
        perPage: 10,
        start: 1,
      );
      final response = await ref.read(httpClientProvider(httpClient)).callHttp;
      AppPrint.debugLog("RESPONSE GET DATA CHECKLIST: ${response["data"]["data"]}");
      return List<Map<String, dynamic>>.from(response["data"]["data"]["items"]);
    } catch (e, st) {
      AppPrint.debugLog("ERROR GET DATA CHECKLIST: $e $st");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getStatusMachine() async {
    AppPrint.debugLog("GET STATUS MACHINE API SERVICE CALLED");
    try {
      final httpClient = HttpClientParams(path: "datadr", controller: "TBLSYS", subMethod: "LoadGridPopup", param: {"sqlCondition": "and tsdscd = 'STSM'"});
      final response = await ref.read(httpClientProvider(httpClient)).callHttp;
      AppPrint.debugLog("RESPONSE GET STATUS MACHINE: ${response["data"]["data"]}");
      final data = jsonDecode(jsonEncode(response["data"]["data"]));

      return data;
    } catch (e, st) {
      AppPrint.debugLog("ERROR GET STATUS MACHINE: $e $st");
      rethrow;
    }
  }
}
