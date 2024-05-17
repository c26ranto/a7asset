import 'package:assets_mobile/data/models/checklist.dart';
import 'package:assets_mobile/data/models/checklist_detail.dart';
import 'package:assets_mobile/data/models/checklist_state.dart';
import 'package:assets_mobile/data/models/cutom_error.dart';
import 'package:assets_mobile/data/models/generate_clhead_state.dart';
import 'package:assets_mobile/data/models/save_checklist_state.dart';
import 'package:assets_mobile/presentation/scan/provider/scan_provider.dart';
import 'package:assets_mobile/presentation/shift/provider/shift_provider.dart';
import 'package:assets_mobile/repositories/checklist/provider/checklist_repository_provider.dart';
import 'package:assets_mobile/repositories/machines/provider/machine_repository_provider.dart';
import 'package:assets_mobile/utils/app_enums.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'checklist_provider.g.dart';

final detailChecklistItemProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final imagesDetailChecklistProvider =
    StateProvider.autoDispose<List<XFile>>((ref) {
  return [];
});

final imagesOnDialogProvider = StateProvider.autoDispose<List<XFile>>((ref) {
  return [];
});

final tssycdProvider = StateProvider.autoDispose<String>((ref) {
  return "";
});

final cdchcdiyProvider = StateProvider<String>((ref) {
  return '';
});

final dataGetChecklistProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final clstatProvider = StateProvider<int>((ref) {
  return -1;
});

final checklistRemarkProvider = StateProvider<String>((ref) {
  return "";
});

final cdcdlniyProvider = StateProvider<String>((ref) {
  return "";
});

final chooseCdcdlniyProvider = StateProvider<int>((ref) {
  return 99;
});

final cdtypeProvider = StateProvider<String>((ref) {
  return "";
});

final cmcmlniyProvider = StateProvider<String>((ref) {
  return "";
});

@riverpod
FutureOr<void> takePicture(TakePictureRef ref,
    {required TakePhotoChecklistType type}) async {
  final ImagePicker picker = ImagePicker();

  final result = await picker.pickImage(source: ImageSource.camera);

  if (result != null) {
    if (type == TakePhotoChecklistType.detail) {
      ref
          .read(imagesDetailChecklistProvider.notifier)
          .update((state) => [...state, result]);
    } else {
      ref
          .read(imagesOnDialogProvider.notifier)
          .update((state) => [...state, result]);
    }
  }
  return;
}

@riverpod
class GenerateClhead extends _$GenerateClhead {
  @override
  GenerateClheadState build() {
    return GenerateClheadState.initial();
  }

  Future callGenerateClhead({
    required String shiftId,
    required String machineNumber,
    required String statusId,
    required String period,
  }) async {
    state = state.copyWith(status: GenerateClheadStatus.loading);
    try {
      await ref.read(checklistRepositoryProvider).generateClhead(
          shiftId: shiftId,
          machineNumber: machineNumber,
          statusId: statusId,
          period: period);
      state = state.copyWith(status: GenerateClheadStatus.success);
    } on CustomError catch (e) {
      state =
          state.copyWith(status: GenerateClheadStatus.failure, customError: e);
    }
  }
}

@riverpod
FutureOr<List<ChecklistDetailModel>> getChecklist(GetChecklistRef ref,
    {required String cdchcdiy}) async {
  final response = await ref
      .read(checklistRepositoryProvider)
      .getChecklist(cdchcdiy: cdchcdiy);
  for (final a in response) {
    ref.read(cdtypeProvider.notifier).update((state) => a.cdtype ?? "");
  }
  return response;
}

@riverpod
class Checklist extends _$Checklist {
  @override
  ChecklistState build() {
    return ChecklistState.initial();
  }

  Future<void> callChecklist({
    required String id,
    required String shiftId,
    required String statusId,
    required String period,
  }) async {
    state = state.copyWith(
      status: ChecklistStatus.loading,
    );
    try {
      List<Map<String, dynamic>> groupingPart = [];

      // CALCULATE CHECKLIST STATUS
      int doneChecklist = 0;
      int tempTotalChecklist = 0;

      List<ChecklistModel> mergedList = [];

      final resp = await ref
          .read(checklistRepositoryProvider)
          .getGenerateCldetl(
              shiftId: shiftId,
              machineNumber: id,
              statusId: statusId,
              period: period);
      final response = await ref.read(machineRepositoryProvider).getMachineData(
            machineId: id,
          );

      for (final a in resp) {
        AppPrint.debugLog('CLDETL PROVIDER: ${a.toMap()}');
      }

      final checklistModel = resp.map((e) => ChecklistModel.fromMap(e.toMap()));
      final tempp = response.map((e) => ChecklistModel.fromMap(e));

      for (final a in checklistModel) {
        AppPrint.debugLog("HELLLO: ${a.toMap()}");
      }

      for (final b in tempp) {
        AppPrint.debugLog("AFTER THAT: ${b.toMap()}");
      }

      mergedList = [...checklistModel, ...tempp];

      for (final a in mergedList) {
        AppPrint.debugLog("Hello from part ${a.toMap()}");
      }

      for (int i = 0; i < mergedList.length; i++) {
        final mpmpcdiy = mergedList[i].mpmpcdiy.toString();
        final mimicdiy = mergedList[i].mimicdiy;
        final miminm = mergedList[i].miminm;

        if (!groupingPart.any((element) => element.containsKey(mpmpcdiy))) {
          groupingPart.add({
            "tempId": mpmpcdiy,
            "trlsnm": mergedList[i].trlsnm.toString().trim(),
            mpmpcdiy: {
              "mpmpnm": mergedList[i].mpmpnm,
              "cmcmlniy": mergedList[i].cmcmlniy,
              "cmacvl": mergedList[i].cmacvl,
              "cdcdlniy": mergedList[i].cdcdlniy,
              // ...temp[i].toMap(),
              "item": [
                {
                  "id": mimicdiy,
                  "value": miminm.toString().trim(),
                  ...mergedList[i].toMap(),
                }
              ],
            },
          });
        } else {
          final index = groupingPart
              .indexWhere((element) => element.containsKey(mpmpcdiy));
          final items = groupingPart[index][mpmpcdiy]["item"]
              as List<Map<String, dynamic>>;
          final existingItemIndex =
              items.indexWhere((item) => item["id"] == mimicdiy);

          if (existingItemIndex == -1) {
            // Add new item
            items.add({
              "id": mimicdiy,
              "value": miminm.toString().trim(),
              ...mergedList[i].toMap(),
            });
          } else {
            items[existingItemIndex] = {
              "id": mimicdiy,
              "value": miminm.toString().trim(),
              ...mergedList[i].toMap(),
            };
          }

          groupingPart[index][mpmpcdiy]["item"] = items;
        }
      }

      for (final a in groupingPart) {
        AppPrint.debugLog("DATA BARU: $a");
      }

      for (int i = 0; i < groupingPart.length; i++) {
        doneChecklist =
            List.from(groupingPart[i][groupingPart[i]["tempId"]]["item"])
                .where((element) => element["cdvalu"] != null)
                .length;
        tempTotalChecklist +=
            List.from(groupingPart[i][groupingPart[i]["tempId"]]["item"])
                .length;
      }

      final undone = tempTotalChecklist - doneChecklist;

      ref.read(statusChecklistProvider.notifier).update((state) => [
            {
              "label": "Total Checklist",
              "value": "$tempTotalChecklist",
              "type": CardStatusType.total,
            },
            {
              "label": "Done",
              "value": doneChecklist,
              "type": CardStatusType.done,
            },
            {
              "label": "Not Done",
              "value": "$undone",
              "type": CardStatusType.notDone,
            },
          ]);

      ref
          .read(partChecklistDataProvider.notifier)
          .update((state) => groupingPart);

      ref.read(modelProvider.notifier).update((state) => response[0]["trlsnm"]);

      state =
          state.copyWith(status: ChecklistStatus.success, success: mergedList);
    } on CustomError catch (e) {
      AppPrint.debugLog("ERROR BRO: $e");
      state = state.copyWith(
        status: ChecklistStatus.failure,
        success: null,
        customError: e,
      );
    }
  }
}

@riverpod
class SaveChecklist extends _$SaveChecklist {
  @override
  SaveChecklistState build() {
    return SaveChecklistState.initial();
  }

  Future callSaveChecklist(
      {required String cmcmlniy,
      required String cmacvl,
      required String cdcdlniy}) async {
    state = state.copyWith(status: SaveChecklistStatus.loading);
    try {
      await ref.read(checklistRepositoryProvider).saveChecklist(
          cmcmlniy: cmcmlniy, cmacvl: cmacvl, cdcdlniy: cdcdlniy);
      state = state.copyWith(
          status: SaveChecklistStatus.success, success: "Success");
    } on CustomError catch (e) {
      state =
          state.copyWith(status: SaveChecklistStatus.failure, customError: e);
    }
  }
}
