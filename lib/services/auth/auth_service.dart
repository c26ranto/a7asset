import 'dart:convert';
import 'dart:developer';

import 'package:assets_mobile/config/constants.dart';
import 'package:assets_mobile/config/http_client.dart';
import 'package:assets_mobile/config/shared_preferences_config.dart';
import 'package:assets_mobile/data/models/cutom_error.dart';
import 'package:assets_mobile/data/models/http_client_params.dart';
import 'package:assets_mobile/utils/app_enums.dart';
import 'package:assets_mobile/utils/app_error_code.dart';
import 'package:assets_mobile/utils/app_error_message.dart';
import 'package:assets_mobile/utils/app_key.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final Ref ref;

  AuthService({required this.ref});

  Future<void> signIn(
      {required String username,
      required String password,
      required String database}) async {
    try {
      final params = {
        "Database": database,
        "Password": password,
        "Username": username,
        "Version": dummyApkVersi,
        "Date": DateTime.now().toIso8601String(),
      };

      AppPrint.debugLog("PARAMS LOGIN: $params");

      final httpClientParams = HttpClientParams(
          path: "login",
          param: params,
          method: "POST",
          token: "",
          postRequestType: PostRequestType.formdata);

      final response =
          await ref.read(httpClientProvider(httpClientParams)).callHttp;

      if (!response.containsKey("Data")) {
        throw CustomError(
            errorCode: AppErrorCode.unauthorized,
            errorMessage: AppErrorMessage.internalServerError);
      }

      final decryptData = List<String>.from(response["Data"]).decryptA7;

      final token = {
        "access_token": decryptData["access_token"],
        "refresh_token": decryptData["refresh_token"],
      };

      AppPrint.debugLog("TOKENNNN: $token");

      await SharedPreferencesHelper.saveData({
        AppKey.token: decryptData["access_token"],
        AppKey.refreshToken: decryptData["refresh_token"],
        AppKey.username: username,
        AppKey.appDB: decryptData["db"],
        AppKey.version: dummyApkVersi,
        AppKey.password: password,
      });

      log("DATA SIGN IN: $decryptData");
    } catch (e, st) {
      AppPrint.debugPrint("ERROR SIGN IN: $e $st");
      rethrow;
    }
  }

  Future<void> changePassword({required String newPassword}) async {
    try {
      final username = await SharedPreferencesHelper.getString(AppKey.username);
      final password = await SharedPreferencesHelper.getString(AppKey.password);
      final token = await SharedPreferencesHelper.getString(AppKey.token);

      final params = {
        'tbluph': {
          'tpuser': username,
          'tppswd': newPassword,
          'oldpas': password
        },
        "AppUserName": username,
        "username": username,
        "Mode": "CP22",
        "oldpass": password,
        "source": "Flutter",
        "newpass": newPassword,
      };

      AppPrint.debugLog("PARAMS CHANGE PASSWORD: $params");

      final httpClientParams = HttpClientParams(
          path: "changepassword", param: params, method: "POST", token: token);

      final response =
          await ref.read(httpClientProvider(httpClientParams)).callHttp;

      AppPrint.debugLog("RESPONSE CHANGE PASSWORD: $response");
    } catch (e, st) {
      AppPrint.debugLog("ERROR CHANGE PASS: $e $st");
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      final httpClientParams = HttpClientParams(
        path: "logout",
        method: "POST",
        postRequestType: PostRequestType.formdata,
        controller: "TBLHSL",
        subMethod: "OUT",
      );

      final response =
          await ref.read(httpClientProvider(httpClientParams)).callHttp;

      AppPrint.debugLog("RESPONSE LOGOUT: $response");
    } catch (e, st) {
      AppPrint.debugLog("LOGOUT: $e -- $st");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> refreshToken() async {
    final refreshToken =
        await SharedPreferencesHelper.getString(AppKey.refreshToken);

    try {
      final response =
          await http.post(Uri.parse("${BaseUrl.ipAddressApi}/refreshToken"),
              body: jsonEncode({
                "refresh_token": refreshToken,
              }));

      AppPrint.debugLog("RESP REFRESH: ${response.body}");

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      // final httpClientParams = HttpClientParams(
      //     path: "refreshToken",
      //     method: "POST",
      //     token: "",
      //     postRequestType: PostRequestType.body,
      //     body: {
      //       "refresh_token": refreshToken,
      //     });

      // final response =
      //     await ref.read(httpClientProvider(httpClientParams)).callHttp;

      AppPrint.debugLog("RESPONSE REFRESH: $data");

      await SharedPreferencesHelper.saveData({
        AppKey.token: data["access_token"],
        AppKey.refreshToken: data["refresh_token"]
      });

      return data;
    } catch (e, st) {
      AppPrint.debugLog("ERROR REFRESH TOKEN: $e $st");
      rethrow;
    }
  }
}
