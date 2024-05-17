import 'package:assets_mobile/services/maintenance/maintenance_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'maintenance_service_provider.g.dart';

@riverpod
MaintenanceServices maintenanceServices(MaintenanceServicesRef ref) {
  return MaintenanceServices(ref: ref);
}
