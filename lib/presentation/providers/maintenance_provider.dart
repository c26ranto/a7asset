import 'package:assets_mobile/repositories/maintenance/provider/maintenance_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'maintenance_provider.g.dart';

@riverpod
FutureOr<Map<String, dynamic>> fetchType(FetchTypeRef ref) async {
  final response = await ref.watch(maintenanceRepositoryProvider).fetchType(ref);
  return response;
}
