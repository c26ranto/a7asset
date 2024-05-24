import 'dart:async';
import 'dart:io';

import 'package:assets_mobile/data/models/cutom_error.dart';
import 'package:assets_mobile/utils/app_error_code.dart';
import 'package:assets_mobile/utils/app_error_message.dart';
import 'package:assets_mobile/utils/app_print.dart';

class HttpClientRepository {
  static Future<T> safeApiCall<T>(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } on SocketException {
      throw CustomError(
          errorCode: AppErrorCode.internalServerError,
          errorMessage: AppErrorMessage.noInternet);
    } on TimeoutException {
      throw const CustomError(
          errorCode: AppErrorCode.requestTimeout,
          errorMessage: AppErrorMessage.timeout);
    } on CustomError catch (e) {
      AppPrint.debugLog("Type Error: ${e is TypeError}");

      String data = AppErrorMessage.internalServerError;

      if (e is TypeError) {
        data = "Terjadi kesalahan tipe data, mohon coba beberapa saat lagi.";
      } else {
        data = "Terjadi kesalahan, mohon coba beberapa saat lagi.";
      }

      throw CustomError(errorCode: e.errorCode, errorMessage: data);
    } catch (e) {
      AppPrint.debugLog("AAAAA: ${e is TypeError}");

      String errorMessage;

      if (e is TypeError) {
        errorMessage =
            "Terjadi kesalahan tipe data, mohon coba beberapa saat lagi.";
      } else {
        errorMessage = "Terjadi kesalahan, mohon coba beberapa saat lagi.";
      }

      throw CustomError(
        errorMessage: errorMessage,
        errorCode: AppErrorCode.internalServerError,
      );
    }
  }
}
