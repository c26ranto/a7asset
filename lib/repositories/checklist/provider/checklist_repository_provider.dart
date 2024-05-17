import 'package:assets_mobile/repositories/checklist/checklist_repository.dart';
import 'package:assets_mobile/services/checklist/provider/checklist_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'checklist_repository_provider.g.dart';

@riverpod
ChecklistRepository checklistRepository(ChecklistRepositoryRef ref) {
  return ChecklistRepository(checklistService: ref.watch(checklistServiceProvider));
}
