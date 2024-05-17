import 'package:assets_mobile/services/machines/machines_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'machine_service_provider.g.dart';

@riverpod
MachinesService machineService(MachineServiceRef ref) {
  return MachinesService(ref: ref);
}
