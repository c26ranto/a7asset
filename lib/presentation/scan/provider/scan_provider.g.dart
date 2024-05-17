// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getDataChecklistHash() => r'0c0b27b25ec0b5b4623a00f94e8db26605a9d818';

/// See also [getDataChecklist].
@ProviderFor(getDataChecklist)
final getDataChecklistProvider =
    AutoDisposeFutureProvider<List<Map<String, dynamic>>>.internal(
  getDataChecklist,
  name: r'getDataChecklistProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getDataChecklistHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetDataChecklistRef
    = AutoDisposeFutureProviderRef<List<Map<String, dynamic>>>;
String _$getMachineStatusHash() => r'b30f5c43d5e12d35f61e21add55916030fbd0d2b';

/// See also [GetMachineStatus].
@ProviderFor(GetMachineStatus)
final getMachineStatusProvider =
    AutoDisposeNotifierProvider<GetMachineStatus, AuthState>.internal(
  GetMachineStatus.new,
  name: r'getMachineStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getMachineStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GetMachineStatus = AutoDisposeNotifier<AuthState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
