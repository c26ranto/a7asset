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
import 'package:assets_mobile/utils/extenstion.dart';
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

final statusChecklistItemProvider =
    StateProvider<List<Map<String, dynamic>>>((ref) {
  return [];
});

final tssycdProvider = StateProvider<String>((ref) {
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

final cdvaluProvider = StateProvider<String>((ref) {
  return "";
});

final noteDialogProvider = StateProvider<String>((ref) {
  return "";
});

final ckcknoiyProvider = StateProvider<String>((ref) {
  return "";
});

final ckflkFilesProvider = StateProvider<List<Map<String, dynamic>>>((ref) {
  return [];
});

final cmflkFilesProvider = StateProvider<List<Map<String, dynamic>>>((ref) {
  return [];
});

final cmcdlniyProvider = StateProvider<String>((ref) {
  return "";
});

final cmremkProvider = StateProvider<String>((ref) {
  return "";
});

final cmremkItemProvider = StateProvider<String>((ref) {
  return "";
});

final cmacvlProvider = StateProvider<String>((ref) {
  return "";
});

@riverpod
FutureOr<void> takePicture(TakePictureRef ref,
    {required TakePhotoChecklistType type}) async {
  final ImagePicker picker = ImagePicker();

  final result = await picker.pickImage(
      source: ImageSource.camera, maxHeight: 720, maxWidth: 720);

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
            item.where((element) => element["cdcdlniy"] != null).length;
        tempTotalChecklist += item.length;

        for (final a in item) {
          final detail = List.from(a["detailItemChecklist"]);

          int doneItemsInCurrentDetail = detail.where((element) {
            return element["cdcdlniy"] != null;
          }).length;

          doneChecklistItem += doneItemsInCurrentDetail;
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
    } catch (e, st) {
      AppPrint.debugLog("Error call checklist provider: $e $st");
      state = state.copyWith(
          status: ChecklistStatus.failure,
          customError: const CustomError(
              errorMessage: "Data tidak ditemukan, silahkan coba lagi!"));
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
    required SaveChecklistType saveChecklistType,
    String? ckcknoiy,
    String? note,
    List<Uint8List>? files,
  }) async {
    AppPrint.debugLog(
        "CMCMLNIY: $cmcmlniy -- CMACVL: $cmacvl -- CDCDLNIY: $cdcdlniy -- CKCKNOIY: $ckcknoiy");
    state = state.copyWith(status: SaveChecklistStatus.loading);
    final machineId = ref.watch(idQrCodeProvider);
    final shift = ref.watch(dataShiftProvider);
    final tssycd = ref.watch(tssycdProvider);

    try {
      await ref.read(checklistRepositoryProvider).saveChecklist(
          cmcmlniy: cmcmlniy,
          cmacvl: cmacvl,
          cdcdlniy: cdcdlniy,
          note: note,
          saveChecklistType: saveChecklistType,
          ckcknoiy: ckcknoiy,
          files: files);

      await ref.read(checklistProvider.notifier).callChecklist(
          id: machineId,
          shiftId: shift.id,
          statusId: tssycd,
          period: shift.period);

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
    ref.invalidate(ckflkFilesProvider);
    ref.invalidate(cmflkFilesProvider);

    try {
      for (final item in mergedList) {
        final mpmpcdiy = item.mpmpcdiy.toString();
        final mimicdiy = item.mimicdiy;
        final miminm = item.miminm;
        final chchcdiy = item.chchcdiy;

        final filesChecklist = [
          {
            "cmflk1": item.cmflk1,
            "cmfln1": item.cmfln1,
          },
          {
            "cmflk2": item.cmflk2,
            "cmfln2": item.cmfln2,
          },
          {
            "cmflk3": item.cmflk3,
            "cmfln3": item.cmfln3,
          },
          {
            "cmflk4": item.cmflk4,
            "cmfln4": item.cmfln4,
          },
          {
            "cmflk5": item.cmflk5,
            "cmfln5": item.cmfln5,
          },
        ]
            .where((map) =>
                map.values.any((value) => value != null && value.isNotEmpty))
            .toList();

        final filesItem = [
          {
            "ckflk1": item.ckflk1,
            "ckfln1": item.ckfln1,
          },
          {
            "ckflk2": item.ckflk2,
            "ckfln2": item.ckfln2,
          },
          {
            "ckflk3": item.ckflk3,
            "ckfln3": item.ckfln3,
          },
          {
            "ckflk4": item.ckflk4,
            "ckfln4": item.ckfln4,
          },
          {
            "ckflk5": item.ckflk5,
            "ckfln5": item.ckfln5,
          },
        ]
            .where((map) =>
                map.values.any((value) => value != null && value.isNotEmpty))
            .toList();

        final detailItemChecklist = {
          ...item.toMap(),
          "filesChecklist": filesChecklist.isEmpty ? [] : filesChecklist,
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
              "files": filesItem.isEmpty ? [] : filesItem,
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

@riverpod
FutureOr<List<String>> getImagesChecklist(GetImagesChecklistRef ref,
    {required List<Map<String, dynamic>> files}) async {
  if (files.isEmpty) return [];
  final response = await ref
      .read(checklistRepositoryProvider)
      .getImagesChecklist(files: files);
  ref.cacheFor(const Duration(minutes: 2));
  return response;
}
