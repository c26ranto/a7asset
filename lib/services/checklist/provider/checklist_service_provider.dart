import 'package:assets_mobile/services/checklist/checklist_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'checklist_service_provider.g.dart';

@riverpod
ChecklistService checklistService(ChecklistServiceRef ref) {
  return ChecklistService(ref: ref);
}
