import 'dart:convert';

import 'package:assets_mobile/data/models/auth_state.dart';
import 'package:assets_mobile/data/models/cutom_error.dart';
import 'package:assets_mobile/data/models/get_machine_progress_state.dart';
import 'package:assets_mobile/repositories/checklist/provider/checklist_repository_provider.dart';
import 'package:assets_mobile/repositories/machines/provider/machine_repository_provider.dart';
import 'package:assets_mobile/utils/app_error_code.dart';
import 'package:assets_mobile/utils/app_error_message.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart' as qr;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scan_provider.g.dart';

final barcodeProvider = StateProvider.autoDispose<qr.Barcode?>((ref) {
  return null;
});

final qrControllerProvider =
    StateProvider.autoDispose<qr.QRViewController?>((ref) {
  return null;
});

final mobileScannerControllerProvider =
    StateProvider.autoDispose<MobileScannerController>((ref) {
  return MobileScannerController();
});

final idQrCodeProvider = StateProvider<String>((ref) {
  return "";
});

final modelProvider = StateProvider<String>((ref) {
  return "";
});

final totalChecklistProvider = StateProvider<String>((ref) {
  return "0";
});

@riverpod
FutureOr<List<Map<String, dynamic>>> getDataChecklist(Ref ref) async {
  final response = await ref.read(machineRepositoryProvider).getDataChecklist();
  AppPrint.debugLog("GET DATA CHECK LIST PROVIDER: $response");
  return response;
}

@riverpod
class GetMachineStatus extends _$GetMachineStatus {
  @override
  AuthState build() {
    return AuthState.initial();
  }

  Future call() async {
    state = state.copyWith(
      status: AuthStatus.loading,
    );

    try {
      final response =
          await ref.read(machineRepositoryProvider).getStatusMachine();
      AppPrint.debugLog("RESPONSE GET STATUS MACHINE PROVIDER: $response");
      state = state.copyWith(status: AuthStatus.success);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.failure);
    }
  }
}

@riverpod
class GetMachineProgress extends _$GetMachineProgress {
  @override
  GetMachineProgressState build() {
    return GetMachineProgressState.initial();
  }

  Future<void> call({
    required String shiftId,
    required String machineNumber,
    required String period,
  }) async {
    state = state.copyWith(status: GetMachineProgressStatus.loading);
    try {
      final result = await ref
          .read(checklistRepositoryProvider)
          .getMachineProgress(
              shiftId: shiftId, machineNumber: machineNumber, period: period);
      AppPrint.debugLog("GET MACHINE PROGRESS STATUS PROVIDER: $result");

      if (result.containsKey("data")) {
        if (result["data"]["Data"] is String) {
          AppPrint.debugLog("NO DATA");
          state = state.copyWith(
              status: GetMachineProgressStatus.failure,
              customError: const CustomError(
                  errorMessage: "Data tidak ditemukan.",
                  errorCode: AppErrorCode.internalServerError));
        } else {
          state = state.copyWith(
              status: GetMachineProgressStatus.success,
              success: jsonEncode(result));
        }
      }
    } on CustomError catch (e) {
      state = state.copyWith(
          status: GetMachineProgressStatus.failure, customError: e);
    } catch (e) {
      state = state.copyWith(
          status: GetMachineProgressStatus.failure,
          customError: CustomError(
              errorCode: AppErrorCode.internalServerError,
              errorMessage: AppErrorMessage.internalServerError));
    }
  }
}
