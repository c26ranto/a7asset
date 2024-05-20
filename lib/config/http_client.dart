import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:assets_mobile/config/constants.dart';
import 'package:assets_mobile/data/models/cutom_error.dart';
import 'package:assets_mobile/data/models/http_client_params.dart';
import 'package:assets_mobile/presentation/splash/provider/splash_provider.dart';
import 'package:assets_mobile/repositories/auth/provider/auth_repository_provider.dart';
import 'package:assets_mobile/utils/app_enums.dart';
import 'package:http_parser/http_parser.dart';
import 'package:assets_mobile/utils/app_error_code.dart';
import 'package:assets_mobile/utils/app_error_message.dart';
import 'package:assets_mobile/utils/app_key.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final httpClientProvider =
    Provider.family((ref, HttpClientParams httpClientParams) {
  return HttpClient(ref: ref, httpClientParams: httpClientParams);
});

class HttpClient {
  final Ref ref;
  final HttpClientParams httpClientParams;

  const HttpClient({required this.ref, required this.httpClientParams});

  Future<Map<String, dynamic>> get callHttp async {
    final prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString(AppKey.username) ?? "";
    String? token = prefs.getString(AppKey.token);

    String? encryptParam;

    if (httpClientParams.token != null) {
      token = httpClientParams.token;
    }

    Map<String, dynamic> param = {};

    // TODO SIMPLIFIED THIS PARAM WITH JUST NECESSARY KEY
    if (httpClientParams.overrideParam != null) {
      param = httpClientParams.overrideParam!;
    } else {
      param = {
        "source": "Flutter",
        "username": "$username-name",
        "date": DateTime.now().toIso8601String(),
        "Date": DateTime.now().toIso8601String(),
        // TODO CHANGE DB DYNAMIC
        // "ApiDB": "dev-a7asset",
      };
    }

    if (httpClientParams.controller != null) {
      param.addAll({"Controller": httpClientParams.controller!});
    }

    if (httpClientParams.subMethod != null) {
      param.addAll({"Method": httpClientParams.subMethod!});
    }

    if (httpClientParams.tipeGrid != null) {
      param.addAll({"tipeGrid": httpClientParams.tipeGrid!});
    }

    if (httpClientParams.filter != null) {
      param.addAll({"filter": httpClientParams.filter!});
    }

    if (httpClientParams.param != null) {
      param.addAll(httpClientParams.param!);
    }

    if (httpClientParams.start != null) {
      param.addAll({"start": httpClientParams.start.toString()});
    }

    if (httpClientParams.limit != null) {
      param.addAll({"limit": httpClientParams.limit.toString()});
    }

    if (httpClientParams.mode != null) {
      param.addAll({"mode": httpClientParams.mode.toString()});
    }

    if (httpClientParams.page != null) {
      param.addAll({"page": httpClientParams.page.toString()});
    }

    if (httpClientParams.perPage != null) {
      param.addAll({"perPage": httpClientParams.perPage.toString()});
    }

    // SEND BODY IF POST METHOD NOT FORMDATA
    // IN CASE LOGIN
    if (httpClientParams.body != null) {
      encryptParam = jsonEncode(httpClientParams.body!);
    } else {
      encryptParam = param.encryptA7;
    }

    final data = {
      "plain_param": param,
      "httpclientparams_param": httpClientParams.param,
      "postRequest": httpClientParams.postRequestType,
      "files": httpClientParams.files?.keys,
      "encrypt_param": encryptParam,
    };

    AppPrint.debugLog("DATA REQUEST: $data");

    if (token != null &&
        token.isNotEmpty &&
        !httpClientParams.path.contains("getConnList")) {
      final checkExpired = token.checkExpiredToken;
      AppPrint.debugLog("CHECK EXPIRED TOKEN: $checkExpired");
      // WHEN EXPIRED
      // CALL REFRESH TOKEN
      if (checkExpired == true) {
        final data = await ref.read(authRepositoryProvider).refreshToken();
        token = data["access_token"];
      }
    }

    ref.read(apiUrlProvider.notifier).update((state) => BaseUrl.ipAddressApi);

    switch (httpClientParams.method.toUpperCase()) {
      case 'GET':
        final response = await _getMethod(ref, httpClientParams, token,
            encryptParam: encryptParam);
        return response;
      case 'POST':
        final response = await _postMethod(
            token, httpClientParams.path, encryptParam,
            isEdit: httpClientParams.isEdit,
            postRequestType: httpClientParams.postRequestType,
            files: httpClientParams.files);
        return response;
      default:
        throw const CustomError(
            errorMessage: 'Unsupported HTTP method',
            errorCode: AppErrorCode.internalServerError);
    }
  }

  Future<Map<String, dynamic>> _getMethod(
      Ref ref, HttpClientParams httpClientParams, String? token,
      {required String encryptParam}) async {
    final encrypted = encryptParam.split(",");

    String defaultUrl = "${BaseUrl.ipAddressApi}/${httpClientParams.path}?";
    String url = "";

    if (defaultUrl.contains("adr")) {
      for (final item in encrypted) {
        defaultUrl += "Data=$item&";
      }
      url = defaultUrl;
    } else {
      url = defaultUrl.replaceFirst('?', '');
    }

    AppPrint.debugLog("URL GET: $url");

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token',
    });

    int statusCode = response.statusCode;
    AppPrint.debugLog("GET DATA: ${response.body} --- ${response.statusCode}");

    if (statusCode != 200) {
      throw CustomError(errorCode: statusCode, errorMessage: response.body);
    }

    final decode = jsonDecode(response.body);

    Map<String, dynamic> data = {};

    // FOR GET CON LIST
    if (url.toLowerCase().contains("getcon")) {
      data = {
        "code": response.statusCode,
        "data": decode,
      };
    } else {
      final dataDecode = decode["Data"];

      final decodeData = List<String>.from(dataDecode);
      AppPrint.debugLog("DECODE DATA HTTP CLIENT: $decodeData");
      final decrypt = decodeData.decryptA7;
      AppPrint.debugLog("DECRYPT: $decrypt");
      data = {"code": response.statusCode, "data": decrypt};
    }

    AppPrint.debugLog("DATA HTTP CLIENT GET: $data");

    return data;
  }

  Future<Map<String, dynamic>> _postMethod(
      String? token, String path, String encryptParam,
      {PostRequestType? postRequestType,
      bool? isEdit,
      Map<String, dynamic>? files}) async {
    String method = 'POST';

    Uri uri = Uri.parse("${BaseUrl.ipAddressApi}/$path");

    Map<String, String> headers = {};

    // CASE FOR NOT LOGIN FUNC
    // AND REFRESH TOKEN
    if (token != null || !uri.path.toLowerCase().contains("refreshtoken")) {
      headers['Authorization'] = 'Bearer $token';
    }

    final paramsPost = {
      "encrypt": encryptParam,
      "path": path,
      "token": token,
      "files": files?.keys,
      "requestType": postRequestType,
      "url": uri.path,
    };

    AppPrint.debugLog("Post Method Call: $paramsPost");

    dynamic request;
    dynamic streamedResponse;

    if (postRequestType == PostRequestType.formdata) {
      try {
        request = http.MultipartRequest(method, uri)
          ..fields["Data"] = encryptParam
          ..headers['Content-Type'] = "multipart/form-data"
          ..headers['Content-Type'] = "multipart/form-data"
          ..headers['Authorization'] = "Bearer $token";

        AppPrint.debugLog("FILES FROM HTTPCLIENT: ${files?.keys}");

        if (files != null) {
          for (var entry in files.entries) {
            var key = entry.key;
            var value = entry.value;
            AppPrint.debugLog("KEY FILE: $key");

            var multipartFile = http.MultipartFile.fromBytes(
              key,
              Uint8List.fromList(value),
              filename: "$key.png",
              contentType: MediaType('image', 'png'),
            );

            request.files.add(multipartFile);
          }
        }

        streamedResponse = await request.send();

        if (streamedResponse.statusCode == 200) {
          print("Request berhasil dikirim!");
        } else {
          print("Gagal mengirim request: ${streamedResponse.statusCode}");
        }
      } catch (e) {
        AppPrint.debugLog("ERROR BRO: $e");
      }
    } else if (uri.path.toString().toLowerCase().contains("refreshtoken")) {
      request = http.Request("POST", uri);
      request.body = encryptParam;
      headers['Content-Type'] = 'application/json';
    } else {
      request = http.Request('POST', uri);
      request.body = jsonEncode(encryptParam);
      request.body = jsonEncode({"refresh_token": encryptParam});
      headers['Content-Type'] = 'application/json';
    }

    AppPrint.debugLog("REEEE: $request");

    request.headers.addAll(headers);

    if (isEdit != null && isEdit == false) {
      streamedResponse =
          await request.send().timeout(const Duration(seconds: 7));
    }
    var responseBody = await streamedResponse.stream.bytesToString();
    AppPrint.debugLog("RESPONE BODY: $responseBody");

    // FOR LOGOUT
    // BECAUSE LOGOUT DOESNT RETURN ANYTHING FROM BE
    if (responseBody.isEmpty) return {};

    var decodeData = jsonDecode(responseBody);

    AppPrint.debugLog(
        "RESP POST METHOD: $decodeData ${streamedResponse.statusCode} -- $responseBody");

    if (responseBody is String) {
      if (responseBody.toLowerCase().contains("sukses logout")) {
        return {};
      }
    }

    if (streamedResponse.statusCode != HttpStatus.created &&
        streamedResponse.statusCode != HttpStatus.ok) {
      if (streamedResponse.statusCode == 401) {
        throw CustomError(
            errorCode: streamedResponse.statusCode, errorMessage: responseBody);
      }
      throw CustomError(errorMessage: AppErrorMessage.unknownError);
    }

    return decodeData;
  }
}
