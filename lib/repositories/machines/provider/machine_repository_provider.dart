import 'package:assets_mobile/repositories/machines/machines_repository.dart';
import 'package:assets_mobile/services/machines/provider/machine_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'machine_repository_provider.g.dart';

@riverpod
MachineRepository machineRepository(MachineRepositoryRef ref) {
  return MachineRepository(machinesService: ref.watch(machineServiceProvider));
}
