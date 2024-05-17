import 'package:assets_mobile/repositories/maintenance/maintenance_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'maintenance_repository_provider.g.dart';

@riverpod
MaintenanceRepository maintenanceRepository(MaintenanceRepositoryRef ref) {
  return MaintenanceRepository();
}
