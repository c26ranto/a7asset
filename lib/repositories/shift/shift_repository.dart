import 'dart:async';

import 'package:assets_mobile/config/http_client_repository.dart';
import 'package:assets_mobile/services/shift/shift_service.dart';

class ShiftRepository {
  ShiftRepository({required this.shiftService});

  final ShiftService shiftService;

  Future<List<Map<String, dynamic>>> getShift() async {
    return HttpClientRepository.safeApiCall(() => shiftService.getShift());
  }

  Future<List<Map<String, dynamic>>> getChecklistPeriod() async {
    return HttpClientRepository.safeApiCall(() => shiftService.getChecklistPeriod());
  }
}
