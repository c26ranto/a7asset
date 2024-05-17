import 'dart:async';

import 'package:assets_mobile/config/http_client_repository.dart';
import 'package:assets_mobile/services/machines/machines_service.dart';

class MachineRepository {
  const MachineRepository({required this.machinesService});

  final MachinesService machinesService;

  Future<List<Map<String, dynamic>>> getAllMachines({required String id, required String type}) async {
    return HttpClientRepository.safeApiCall(() => machinesService.getAllMachines(id: id, type: type));
  }

  Future<List<Map<String, dynamic>>> getMachineData({required String machineId}) async {
    return HttpClientRepository.safeApiCall(() => machinesService.getMachineData(machineId));
  }

  Future<List<Map<String, dynamic>>> getDataChecklist() async {
    return HttpClientRepository.safeApiCall(() => machinesService.getDataChecklist());
  }

  Future<Map<String, dynamic>> getStatusMachine() async {
    return HttpClientRepository.safeApiCall(() => machinesService.getStatusMachine());
  }
}
