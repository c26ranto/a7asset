import 'dart:io';

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
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'checklist_provider.g.dart';

final detailChecklistItemProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final detailChecklistItemTestProvider =
    StateProvider<Map<String, dynamic>>((ref) {
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

final filesProvider = StateProvider<List<Uint8List>>((ref) {
  return [];
});

@riverpod
FutureOr<void> takePicture(TakePictureRef ref,
    {required TakePhotoChecklistType type}) async {
  final ImagePicker picker = ImagePicker();

  final result = await picker.pickImage(source: ImageSource.camera);

  if (result != null) {
    final bytes = await result.readAsBytes();
    ref.read(filesProvider.notifier).update(
          (state) => [...state, bytes],
        );

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
      // CALCULATE CHECKLIST STATUS
      int doneChecklist = 0;
      int tempTotalChecklist = 0;

      int doneChecklistItem = 0;
      int tempTotalChecklistItem = 0;
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

      final checklistModel = resp.map((e) => ChecklistModel.fromMap(e.toMap()));
      final tempp = response.map((e) => ChecklistModel.fromMap(e));

      final mergedList = [...checklistModel, ...tempp];

      final groupingItem =
          ref.read(checklistControllerProvider.notifier).mergeData(mergedList);

      AppPrint.debugLog("GROUPIN PART: $groupingItem");

      for (int i = 0; i < groupingItem.length; i++) {
        final item =
            List.from(groupingItem[i][groupingItem[i]["tempId"]]["item"]);

        doneChecklist =
            item.where((element) => element["cdvalu"] != null).length;
        tempTotalChecklist += item.length;

        for (final a in item) {
          final detail = List.from(a["detailItemChecklist"]);

          doneChecklistItem =
              detail.where((element) => element["cdvalu"] != null).length;
          tempTotalChecklistItem += detail.length;
        }
      }

      final undone = tempTotalChecklist - doneChecklist;
      final undoneItem = tempTotalChecklistItem - doneChecklistItem;

      AppPrint.debugLog("DONE CHECKLIST: $doneChecklist");
      AppPrint.debugLog("TEMP TOTAL CHECKLIST: $tempTotalChecklist");
      AppPrint.debugLog("UN DONE CHECKLIST: $undone");

      AppPrint.debugLog("DONE CHECKLIST ITEM: $doneChecklistItem");
      AppPrint.debugLog("TEMP TOTAL CHECKLIST ITEM: $tempTotalChecklistItem");

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

      ref.read(statusChecklistItemProvider.notifier).update((state) => [
            {
              "label": "Total Checklist",
              "value": "$tempTotalChecklistItem",
              "type": CardStatusType.total,
            },
            {
              "label": "Done",
              "value": doneChecklistItem,
              "type": CardStatusType.done,
            },
            {
              "label": "Not Done",
              "value": "$undoneItem",
              "type": CardStatusType.notDone,
            },
          ]);

      ref
          .read(partChecklistDataProvider.notifier)
          .update((state) => groupingItem);

      ref.read(modelProvider.notifier).update((state) => response[0]["trlsnm"]);

      state = state.copyWith(
          status: ChecklistStatus.success, success: groupingItem);
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

  Future callSaveChecklist({
    required String cmcmlniy,
    required String cmacvl,
    required String cdcdlniy,
    Uint8List? file1,
    Uint8List? file2,
    Uint8List? file3,
    Uint8List? file4,
  }) async {
    state = state.copyWith(status: SaveChecklistStatus.loading);
    try {
      await ref.read(checklistRepositoryProvider).saveChecklist(
          cmcmlniy: cmcmlniy,
          cmacvl: cmacvl,
          cdcdlniy: cdcdlniy,
          file1: file1,
          file2: file2,
          file3: file3,
          file4: file4);
      state = state.copyWith(
          status: SaveChecklistStatus.success, success: "Success");
    } on CustomError catch (e) {
      state =
          state.copyWith(status: SaveChecklistStatus.failure, customError: e);
    }
  }
}

@riverpod
class ChecklistController extends _$ChecklistController {
  @override
  void build() {
    return;
  }

  List<Map<String, dynamic>> mergeData(List<ChecklistModel> mergedList) {
    List<Map<String, dynamic>> groupingPart = [];

    try {
      for (final item in mergedList) {
        final mpmpcdiy = item.mpmpcdiy.toString();
        final mimicdiy = item.mimicdiy;
        final miminm = item.miminm;
        final mrrlcdiy = item.mrrlcdiy;
        final mrmrnm = item.mrmrnm;
        final chchcdiy = item.chchcdiy;
        final cdtype = item.cdtype;
        final cmcmlniy = item.cmcmlniy;
        final cmacvl = item.cmacvl;
        final cmcdlniy = item.cmcdlniy;
        final cdcdds = item.cdcdds;
        final cdvalu = item.cdvalu;
        final cdrguv = item.cdrguv;
        final cdunms = item.cdunms;
        final chchnm = item.chchnm;

        final detailItemChecklist = {
          "mrmrnm": mrmrnm,
          "mrrlcdiy": mrrlcdiy,
          "chchcdiy": chchcdiy,
          "cdtype": cdtype,
          "cmcmlniy": cmcmlniy,
          "cmacvl": cmacvl,
          "cmcdlniy": cmcdlniy,
          "cdcdds": cdcdds,
          "cdrguv": cdrguv,
          "chchnm": chchnm,
          "cdvalu": cdvalu,
          "cdunms": cdunms,
        };

        if (!groupingPart.any((element) => element.containsKey(mpmpcdiy))) {
          groupingPart.add({
            "tempId": mpmpcdiy,
            "trlsnm": item.trlsnm.toString().trim(),
            mpmpcdiy: {
              "mpmpnm": item.mpmpnm,
              "cmcmlniy": item.cmcmlniy,
              "cmacvl": item.cmacvl,
              "cdcdlniy": item.cdcdlniy,
              "item": [
                {
                  "id": mimicdiy,
                  "value": miminm.toString().trim(),
                  "detailItemChecklist": [detailItemChecklist],
                  ...item.toMap(),
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
            items.add({
              "id": mimicdiy,
              "value": miminm.toString().trim(),
              "detailItemChecklist": [detailItemChecklist],
              ...item.toMap(),
            });
          } else {
            final existingItem = items[existingItemIndex];
            var existingDetailChecklist = existingItem["detailItemChecklist"];

            if (existingDetailChecklist is List) {
              final findUniqueId = existingDetailChecklist
                  .indexWhere((element) => element["chchcdiy"] == chchcdiy);

              if (findUniqueId == -1) {
                existingDetailChecklist.add(detailItemChecklist);
              }
            } else {
              existingDetailChecklist = [
                existingDetailChecklist,
                detailItemChecklist
              ];
            }

            existingItem["detailItemChecklist"] = existingDetailChecklist;
            items[existingItemIndex] = existingItem;
          }

          groupingPart[index][mpmpcdiy]["item"] = items;
        }
      }
    } catch (e, st) {
      AppPrint.debugLog("ERRROR YA: $e $st");
    }

    return groupingPart;
  }
}
