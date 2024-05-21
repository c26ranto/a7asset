import 'dart:async';

import 'package:assets_mobile/config/http_client_repository.dart';
import 'package:assets_mobile/data/models/checklist_detail.dart';
import 'package:assets_mobile/data/models/cldetl.dart';
import 'package:assets_mobile/services/checklist/checklist_service.dart';
import 'package:flutter/foundation.dart';

class ChecklistRepository {
  final ChecklistService checklistService;

  const ChecklistRepository({required this.checklistService});

  Future<void> generateClhead({
    required String shiftId,
    required String machineNumber,
    required String statusId,
    required String period,
  }) async {
    return HttpClientRepository.safeApiCall(() =>
        checklistService.generateClhead(
            shiftId: shiftId,
            machineNumber: machineNumber,
            statusId: statusId,
            period: period));
  }

  Future<List<CldetlModel>> getGenerateCldetl({
    required String shiftId,
    required String machineNumber,
    required String statusId,
    required String period,
  }) async {
    return HttpClientRepository.safeApiCall(() =>
        checklistService.getGenerateCldetl(
            shiftId: shiftId,
            machineNumber: machineNumber,
            statusId: statusId,
            period: period));
  }

  Future<List<ChecklistDetailModel>> getChecklist(
      {required String cdchcdiy}) async {
    return HttpClientRepository.safeApiCall(
        () => checklistService.getChecklist(cdchcdiy: cdchcdiy));
  }

  Future saveChecklist({
    required String cmcmlniy,
    required String cmacvl,
    required String cdcdlniy,
    String? note,
    List<Uint8List>? files,
  }) async {
    return HttpClientRepository.safeApiCall(() =>
        checklistService.saveChecklist(
            cmcmlniy: cmcmlniy,
            cmacvl: cmacvl,
            cdcdlniy: cdcdlniy,
            note: note,
            files: files));
  }

  Future<Map<String, dynamic>> getMachineProgress({
    required String shiftId,
    required String machineNumber,
    required String statusId,
    required String period,
  }) async {
    return HttpClientRepository.safeApiCall(
      () => checklistService.getMachineProgress(
          shiftId: shiftId,
          machineNumber: machineNumber,
          statusId: statusId,
          period: period),
    );
  }
}
