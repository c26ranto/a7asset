import 'package:assets_mobile/services/shift/shift_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shift_service_provider.g.dart';

@riverpod
ShiftService shiftService(ShiftServiceRef ref) {
  return ShiftService(ref: ref);
}
