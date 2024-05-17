import 'package:assets_mobile/data/models/auth_state.dart';
import 'package:assets_mobile/repositories/machines/provider/machine_repository_provider.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart' as qr;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scan_provider.g.dart';

final barcodeProvider = StateProvider.autoDispose<qr.Barcode?>((ref) {
  return null;
});

final qrControllerProvider = StateProvider.autoDispose<qr.QRViewController?>((ref) {
  return null;
});

final mobileScannerControllerProvider = StateProvider.autoDispose<MobileScannerController>((ref) {
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

final doneProvider = StateProvider<String>((ref) {
  return "0";
});

final notDoneProvider = StateProvider<String>((ref) {
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
      final response = await ref.read(machineRepositoryProvider).getStatusMachine();
      AppPrint.debugLog("RESPONSE GET STATUS MACHINE PROVIDER: $response");
      state = state.copyWith(status: AuthStatus.success);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.failure);
    }
  }
}
