import 'dart:convert';

import 'package:assets_mobile/data/models/auth_state.dart';
import 'package:assets_mobile/data/models/cutom_error.dart';
import 'package:assets_mobile/data/models/get_status_machine_state.dart';
import 'package:assets_mobile/data/models/save_checklist_state.dart';
import 'package:assets_mobile/data/models/shift_model.dart';
import 'package:assets_mobile/repositories/machines/provider/machine_repository_provider.dart';
import 'package:assets_mobile/repositories/shift/provider/shift_repository_provider.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shift_provider.g.dart';

final shiftDateProvider = StateProvider.autoDispose<String>((ref) {
  final date = DateTime.now().formateDate2;
  return date;
});

final dataTableProvider =
    StateProvider.family<List<Map<String, dynamic>>, Map<String, dynamic>>(
        (ref, data) {
  return [
    {
      "label": "Machine No",
      "value": data["machineId"],
    },
    {
      "label": "Model",
      "value": data["model"],
    },
    {
      "label": "Date",
      "value": data["shift"]["date"],
    },
    {
      "label": "Shift",
      "value": data["shift"]["title"],
    },
  ];
});

final chooseShiftIndexProvider = StateProvider.autoDispose<int>((ref) {
  return -1;
});

final dataShiftProvider = StateProvider.autoDispose<ShiftModel>((ref) {
  return ShiftModel(date: "", id: "", title: "", period: "");
});

final isDefaultShiftProvider = Provider.autoDispose<bool>((ref) {
  final shift = ref.watch(dataShiftProvider);
  return shift.isDefault;
});

final partChecklistDataProvider =
    StateProvider<List<Map<String, dynamic>>>((ref) {
  return [];
});

final statusChecklistProvider =
    StateProvider<List<Map<String, dynamic>>>((ref) {
  return [];
});

final partDataProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final testDataProvider = StateProvider<List<Map<String, dynamic>>>((ref) {
  return [];
});

@riverpod
FutureOr<List<Map<String, dynamic>>> getShift(GetShiftRef ref) async {
  final response = await ref.read(shiftRepositoryProvider).getShift();
  ref.cacheFor(const Duration(minutes: 30));
  return response;
}

@riverpod
FutureOr<List<Map<String, dynamic>>> getChecklistPeriod(
    GetChecklistPeriodRef ref) async {
  final response = await ref.read(shiftRepositoryProvider).getChecklistPeriod();
  return response;
}

@riverpod
class GetStatusMachine extends _$GetStatusMachine {
  @override
  GetStatusMachineState build() {
    return GetStatusMachineState.initial();
  }

  Future getStatusMachine() async {
    state = state.copyWith(status: GetStatusMachineStatus.loading);
    try {
      final response =
          await ref.watch(machineRepositoryProvider).getStatusMachine();

      AppPrint.debugLog("RESPONSE GET STATUS MACHINE PROVIDER: $response");

      List<Map<String, dynamic>> status = [];

      for (final item in response["items"]) {
        status.add({
          "tschid": item["tschid"],
          "tschno": item["tschno"],
          "tscsid": item["tscsid"],
          "tssycd": item["tssycd"],
          "tssynm": item["tssynm"],
        });
      }

      state = state.copyWith(
          status: GetStatusMachineStatus.success,
          success: jsonEncode({"response": response, "status": status}));
    } on CustomError catch (e) {
      state = state.copyWith(
          status: GetStatusMachineStatus.failure, customError: e);
    } catch (e) {
      state = state.copyWith(
          status: GetStatusMachineStatus.failure,
          customError: CustomError(errorMessage: e.toString()));
    }
  }
}

@riverpod
class Machines extends _$Machines {
  @override
  SaveChecklistState build() {
    return SaveChecklistState.initial();
  }

  Future getAllMachines({required String id, required String type}) async {
    state = state.copyWith(status: SaveChecklistStatus.loading);
    try {
      final response = await ref
          .read(machineRepositoryProvider)
          .getAllMachines(id: id, type: type);
      state = state.copyWith(
          status: SaveChecklistStatus.success, success: jsonEncode(response));
    } on CustomError catch (e) {
      state =
          state.copyWith(status: SaveChecklistStatus.failure, customError: e);
    } catch (e) {
      state = state.copyWith(
          status: SaveChecklistStatus.failure,
          customError: CustomError(errorMessage: e.toString()));
    }
  }
}
