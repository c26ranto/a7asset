import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final startDateProvider = StateProvider<String>((ref) {
  return DateTime.now().formatDate;
});

final endDateProvider = StateProvider<String>((ref) {
  return DateTime.now().formatDate;
});

final typeProvider = StateProvider<String>((ref) {
  return "";
});

final startDateBottomSheetProvider = StateProvider<String>((ref) {
  return DateTime.now().formatDate;
});

final endDateBottomSheetProvider = StateProvider<String>((ref) {
  return DateTime.now().formatDate;
});
