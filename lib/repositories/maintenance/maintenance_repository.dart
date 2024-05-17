import 'dart:async';

import 'package:assets_mobile/data/models/cutom_error.dart';
import 'package:assets_mobile/services/maintenance/maintenance_service.dart';
import 'package:assets_mobile/services/maintenance/provider/maintenance_service_provider.dart';
import 'package:assets_mobile/utils/app_error_code.dart';
import 'package:assets_mobile/utils/app_error_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MaintenanceRepository {
  late MaintenanceServices maintenanceServices;

  Future<Map<String, dynamic>> fetchType(Ref ref) async {
    maintenanceServices = ref.read(maintenanceServicesProvider);
    try {
      return await maintenanceServices.fetchType();
    } on TimeoutException catch (_) {
      throw const CustomError(errorCode: AppErrorCode.requestTimeout, errorMessage: AppErrorMessage.timeout);
    } on CustomError catch (e) {
      throw CustomError(errorCode: e.errorCode, errorMessage: e.errorMessage);
    } catch (e) {
      throw CustomError(errorMessage: e.toString(), errorCode: AppErrorCode.internalServerError);
    }
  }
}
