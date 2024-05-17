import 'dart:developer';

import 'package:assets_mobile/config/constants.dart';
import 'package:assets_mobile/config/http_client.dart';
import 'package:assets_mobile/data/models/cutom_error.dart';
import 'package:assets_mobile/data/models/http_client_params.dart';
import 'package:assets_mobile/utils/app_enums.dart';
import 'package:assets_mobile/utils/app_error_code.dart';
import 'package:assets_mobile/utils/app_error_message.dart';
import 'package:assets_mobile/utils/app_key.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  late SharedPreferences preferences;
  final Ref ref;

  AuthService({required this.ref});

  Future<void> signIn({required String username, required String password, required String database}) async {
    try {
      preferences = await SharedPreferences.getInstance();

      final params = {
        "Database": database,
        "Password": password,
        "Username": username,
        "Version": dummyApkVersi,
        "Date": DateTime.now().toIso8601String(),
      };

      AppPrint.debugLog("PARAMS LOGIN: $params");

      final httpClientParams = HttpClientParams(path: "login", param: params, method: "POST", token: "", postRequestType: PostRequestType.formdata);

      final response = await ref.read(httpClientProvider(httpClientParams)).callHttp;

      if (!response.containsKey("Data")) throw CustomError(errorCode: AppErrorCode.unauthorized, errorMessage: AppErrorMessage.internalServerError);

      final decryptData = List<String>.from(response["Data"]).decryptA7;

      final token = {
        "access_token": decryptData["access_token"],
        "refresh_token": decryptData["refresh_token"],
      };

      AppPrint.debugLog("TOKENNNN: $token");

      preferences.setString(AppKey.token, decryptData["access_token"]);
      preferences.setString(AppKey.refreshToken, decryptData["refresh_token"]);
      preferences.setString(AppKey.username, username);
      preferences.setString(AppKey.appDB, decryptData["db"]);
      preferences.setString(AppKey.version, dummyApkVersi);
      preferences.setString(AppKey.password, password);

      log("DATA SIGN IN: $decryptData");
    } catch (e, st) {
      AppPrint.debugPrint("ERROR SIGN IN: $e $st");
      rethrow;
    }
  }

  Future<void> changePassword({required String newPassword}) async {
    try {
      preferences = await SharedPreferences.getInstance();

      final username = preferences.getString(AppKey.username) ?? "anonymous";
      final password = preferences.getString(AppKey.password);
      final token = preferences.getString(AppKey.token);

      final params = {
        'tbluph': {'tpuser': username, 'tppswd': newPassword, 'oldpas': password},
        "AppUserName": username,
        "username": username,
        "Mode": "CP22",
        "oldpass": password,
        "source": "Flutter",
        "newpass": newPassword,
      };

      AppPrint.debugLog("PARAMS CHANGE PASSWORD: $params");

      final httpClientParams = HttpClientParams(path: "changepassword", param: params, method: "POST", token: token);

      final response = await ref.read(httpClientProvider(httpClientParams)).callHttp;

      AppPrint.debugLog("RESPONSE CHANGE PASSWORD: $response");
    } catch (e, st) {
      AppPrint.debugLog("ERROR CHANGE PASS: $e $st");
      rethrow;
    }
  }

  // TODO LOGOUT
  Future<void> logout() async {
    try {
      final httpClientParams = HttpClientParams(
        path: "logout",
        method: "POST",
        controller: "TBLHSL",
        subMethod: "OUT",
      );

      final response = await ref.read(httpClientProvider(httpClientParams)).callHttp;

      AppPrint.debugLog("RESPONSE LOGOUT: $response");
    } catch (e, st) {
      AppPrint.debugLog("LOGOUT: $e -- $st");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> refreshToken() async {
    preferences = await SharedPreferences.getInstance();

    try {
      final httpClientParams = HttpClientParams(path: "refreshToken", method: "POST", token: "", postRequestType: PostRequestType.body, body: {
        "refresh_token": preferences.getString(AppKey.refreshToken),
      });

      final response = await ref.read(httpClientProvider(httpClientParams)).callHttp;

      AppPrint.debugLog("RESPONSE REFRESH: $response");

      preferences.setString(AppKey.token, response["access_token"]);
      preferences.setString(AppKey.refreshToken, response["refresh_token"]);

      return response;
    } catch (e, st) {
      AppPrint.debugLog("ERROR REFRESH TOKEN: $e $st");
      rethrow;
    }
  }
}
