import 'dart:async';
import 'dart:convert';

import 'package:assets_mobile/config/http_client_repository.dart';
import 'package:assets_mobile/data/models/cutom_error.dart';
import 'package:assets_mobile/services/auth/auth_service.dart';
import 'package:assets_mobile/utils/app_error_code.dart';
import 'package:assets_mobile/utils/app_error_message.dart';
import 'package:assets_mobile/utils/app_print.dart';

class AuthRepository {
  final AuthService authService;

  const AuthRepository({required this.authService});

  Future<void> signIn(
      {required String username,
      required String password,
      required String database}) async {
    try {
      return await authService.signIn(
          username: username, password: password, database: database);
    } on TimeoutException catch (_) {
      throw const CustomError(
          errorCode: AppErrorCode.requestTimeout,
          errorMessage: AppErrorMessage.timeout);
    } on CustomError catch (e) {
      final decodeData = jsonDecode(e.errorMessage);
      final data = (decodeData as Map).containsKey("Message")
          ? decodeData["Message"]
          : decodeData;
      throw CustomError(errorCode: e.errorCode, errorMessage: data);
    } catch (e) {
      throw CustomError(
          errorMessage: AppErrorMessage.internalServerError,
          errorCode: AppErrorCode.internalServerError);
    }
  }

  Future<void> changePassword({required String newPassword}) async {
    try {
      return await authService.changePassword(newPassword: newPassword);
    } on TimeoutException catch (_) {
      throw const CustomError(
          errorCode: AppErrorCode.requestTimeout,
          errorMessage: AppErrorMessage.timeout);
    } on CustomError catch (e) {
      final decodeData = jsonDecode(e.errorMessage);
      final data = (decodeData as Map).containsKey("Message")
          ? decodeData["Message"]
          : decodeData;
      throw CustomError(errorCode: e.errorCode, errorMessage: data);
    } catch (e) {
      throw CustomError(
          errorMessage: AppErrorMessage.internalServerError,
          errorCode: AppErrorCode.internalServerError);
    }
  }

  Future<void> logout() async {
    try {
      return await authService.logout();
    } on TimeoutException catch (_) {
      throw const CustomError(
          errorCode: AppErrorCode.requestTimeout,
          errorMessage: AppErrorMessage.timeout);
    } on CustomError catch (e) {
      final decodeData = jsonDecode(e.errorMessage);
      final data = decodeData is String
          ? decodeData
          : (decodeData as Map).containsKey("Message")
              ? decodeData["Message"]
              : decodeData;
      throw CustomError(errorCode: e.errorCode, errorMessage: data);
    } catch (e) {
      throw CustomError(
          errorMessage: AppErrorMessage.internalServerError,
          errorCode: AppErrorCode.internalServerError);
    }
  }

  Future refreshToken() async {
    AppPrint.debugLog("REFRESH TOKEN");
    return HttpClientRepository.safeApiCall(() => authService.refreshToken());
  }
}
