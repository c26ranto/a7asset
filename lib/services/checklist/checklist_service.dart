import 'package:assets_mobile/config/http_client.dart';
import 'package:assets_mobile/data/models/checklist_detail.dart';
import 'package:assets_mobile/data/models/cldetl.dart';
import 'package:assets_mobile/data/models/http_client_params.dart';
import 'package:assets_mobile/utils/app_enums.dart';
import 'package:assets_mobile/utils/app_key.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChecklistService {
  ChecklistService({required this.ref});

  final Ref ref;
  late SharedPreferences preferences;

  Future<void> generateClhead({
    required String shiftId,
    required String machineNumber,
    required String statusId,
    required String period,
  }) async {
    preferences = await SharedPreferences.getInstance();

    DateFormat dateFormat = DateFormat("yyyyMMdd");
    final date = dateFormat.format(DateTime.now());

    try {
      final params = {
        "trlsno": machineNumber,
        "clshft": shiftId,
        "clstsm": statusId,
        "mtmtnm": period,
        "cltrdt": date,
        "Mode": "A",
      };

      final token = preferences.getString(AppKey.token);

      AppPrint.debugLog("PARAMS GENERATE CLHEAD: $params");

      final httpClientParams = HttpClientParams(
        path: "datadr",
        param: params,
        controller: "CLHEAD",
        subMethod: "Generate",
        method: "POST",
        token: token,
        postRequestType: PostRequestType.formdata,
      );

      final response =
          await ref.read(httpClientProvider(httpClientParams)).callHttp;

      AppPrint.debugLog("RESPONSE GENERATE CLHEAD: $response");
    } catch (e) {
      AppPrint.debugLog("ERROR GENERATE CLHEAD: $e");
      rethrow;
    }
  }

  Future<List<CldetlModel>> getGenerateCldetl({
    required String shiftId,
    required String machineNumber,
    required String statusId,
    required String period,
  }) async {
    try {
      preferences = await SharedPreferences.getInstance();

      DateFormat dateFormat = DateFormat("yyyyMMdd");
      final date = dateFormat.format(DateTime.now());
      final params = {
        "trlsno": machineNumber,
        "clshft": shiftId,
        "clstsm": statusId,
        "mtmtnm": period,
        "cltrdt": date,
        "Mode": "A",
      };

      final token = preferences.getString(AppKey.token);

      AppPrint.debugLog("PARAMS GET GENERATE CLDETL: $params");

      final httpClientParams = HttpClientParams(
        path: "datadr",
        param: params,
        controller: "CLDETL",
        subMethod: "LoadData",
        token: token,
      );

      final response =
          await ref.read(httpClientProvider(httpClientParams)).callHttp;

      List<CldetlModel> tempData = [];

      AppPrint.debugLog("Resp get generate cldetl: $response");

      final data = response["data"]["Data"];

      if (data is String) return tempData;

      for (final a in data) {
        tempData.add(CldetlModel.fromMap(a));
      }

      return tempData;
    } catch (e, st) {
      AppPrint.debugLog("ERROR GET GENERATE CLDETL: $e $st");
      rethrow;
    }
  }

  Future<List<ChecklistDetailModel>> getChecklist(
      {required String cdchcdiy}) async {
    try {
      final httpClientParams = HttpClientParams(
          path: "datadr",
          controller: "MCCHKH_MCCHKD",
          subMethod: "LoadGrid",
          param: {"sqlCondition": "and cdchcdiy = '$cdchcdiy'"});

      final response =
          await ref.read(httpClientProvider(httpClientParams)).callHttp;

      final data = response["data"]["data"]["items"];

      AppPrint.debugLog("RESPONSE GET CHECKLIST: $data");

      List<ChecklistDetailModel> temp = [];

      for (final item in data) {
        temp.add(ChecklistDetailModel.fromMap(item));
      }

      return temp;
    } catch (e, st) {
      AppPrint.debugLog("ERROR GET CHECKLIST: $e $st");
      rethrow;
    }
  }

  Future saveChecklist({
    required String cmcmlniy,
    required String cmacvl,
    required String cdcdlniy,
    required SaveChecklistType saveChecklistType,
    String? ckcknoiy,
    String? note,
    List<Uint8List>? files,
  }) async {
    try {
      final Map<String, Uint8List> filesMap = {};
      Map<String, dynamic> param = {};

      if (files != null) {
        if (saveChecklistType == SaveChecklistType.dialog) {
          for (int i = 0; i < files.length; i++) {
            filesMap["cmflk${i + 1}"] = files[i];
          }
        } else {
          for (int i = 0; i < files.length; i++) {
            filesMap["ckflk${i + 1}"] = files[i];
          }
        }
      }

      if (saveChecklistType == SaveChecklistType.dialog) {
        param = {
          "cmcmlniy": cmcmlniy,
          "cmacvl": cmacvl,
          "cdcdlniy": cdcdlniy,
        };
      } else {
        param = {
          "ckcknoiy": ckcknoiy,
        };
      }

      final controller =
          saveChecklistType == SaveChecklistType.dialog ? "CLDETL" : "CLLINE";

      final httpClientParams = HttpClientParams(
          path: "datadr",
          controller: controller,
          subMethod: "Update",
          method: "POST",
          isEdit: true,
          postRequestType: PostRequestType.formdata,
          files: filesMap,
          param: param);

      if (note != null) {
        if (saveChecklistType == SaveChecklistType.dialog) {
          httpClientParams.param?["cmremk"] = note;
        } else {
          httpClientParams.param?["ckremk"] = note;
        }
      }

      AppPrint.debugLog("PARAM CALL SAVE CHECKLIST: $param");

      final response =
          await ref.read(httpClientProvider(httpClientParams)).callHttp;

      AppPrint.debugLog("RESPONSE SAVE CHECKLIST: $response");
    } catch (e, st) {
      AppPrint.debugLog("ERROR SAVE CHECKLIST: $e $st");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getMachineProgress({
    required String shiftId,
    required String machineNumber,
    required String period,
  }) async {
    preferences = await SharedPreferences.getInstance();

    DateFormat dateFormat = DateFormat("yyyyMMdd");
    final date = dateFormat.format(DateTime.now());

    try {
      final params = {
        "trlsno": machineNumber,
        "mtmtnm": period,
        "cltrdt": date,
        "Mode": "A",
      };

      AppPrint.debugLog("PARAMS GET MACHINE PROGRESS: $params");

      final httpClientParams = HttpClientParams(
        path: "datadr",
        param: params,
        controller: "CLHEAD",
        subMethod: "LoadData",
      );

      final response =
          await ref.read(httpClientProvider(httpClientParams)).callHttp;

      AppPrint.debugLog("RESPONSE GET MACHINE PROGRESS: $response");

      return response;
    } catch (e) {
      AppPrint.debugLog("ERROR GET MACHINE PROGRESS: $e");
      rethrow;
    }
  }

  Future<List<String>> getImagesChecklist(
      {required List<Map<String, dynamic>> files}) async {
    try {
      List<String> result = [];

      AppPrint.debugLog("FILESS: $files");

      for (int i = 0; i < files.length; i++) {
        AppPrint.debugLog("GET IMAGE");
        final httpClientParams = HttpClientParams(
            path: "datadr",
            controller: "Ajax",
            subMethod: "setFile",
            param: {
              "FileKey": files[i]["cmflk${i + 1}"],
              "FileName": files[i]["cmfln${i + 1}"],
            });

        final response =
            await ref.read(httpClientProvider(httpClientParams)).callHttp;

        AppPrint.debugLog("RESPONSE GET IMAGE: $response");

        final data = response["data"]["File"];

        result.add(data);
      }

      return result;
    } catch (e, st) {
      AppPrint.debugLog("ERROR GET IMAGES CHECKLIST: $e $st");
      rethrow;
    }
  }
}
