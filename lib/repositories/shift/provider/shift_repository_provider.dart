import 'package:assets_mobile/repositories/shift/shift_repository.dart';
import 'package:assets_mobile/services/shift/provider/shift_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shift_repository_provider.g.dart';

@riverpod
ShiftRepository shiftRepository(ShiftRepositoryRef ref) {
  return ShiftRepository(shiftService: ref.watch(shiftServiceProvider));
}
