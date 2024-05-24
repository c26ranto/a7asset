// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getShiftHash() => r'dee0e3198af8a8b8cc5a8a8e3814c45ef215a48f';

/// See also [getShift].
@ProviderFor(getShift)
final getShiftProvider =
    AutoDisposeFutureProvider<List<Map<String, dynamic>>>.internal(
  getShift,
  name: r'getShiftProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getShiftHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetShiftRef = AutoDisposeFutureProviderRef<List<Map<String, dynamic>>>;
String _$getChecklistPeriodHash() =>
    r'9ef36dec4d6b8026a5a6bb3c0f7c15e221079f57';

/// See also [getChecklistPeriod].
@ProviderFor(getChecklistPeriod)
final getChecklistPeriodProvider =
    AutoDisposeFutureProvider<List<Map<String, dynamic>>>.internal(
  getChecklistPeriod,
  name: r'getChecklistPeriodProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getChecklistPeriodHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetChecklistPeriodRef
    = AutoDisposeFutureProviderRef<List<Map<String, dynamic>>>;
String _$getStatusMachineHash() => r'0caf40851e80ca6a640e8a1f75ae869932d61b45';

/// See also [GetStatusMachine].
@ProviderFor(GetStatusMachine)
final getStatusMachineProvider = AutoDisposeNotifierProvider<GetStatusMachine,
    GetStatusMachineState>.internal(
  GetStatusMachine.new,
  name: r'getStatusMachineProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getStatusMachineHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GetStatusMachine = AutoDisposeNotifier<GetStatusMachineState>;
String _$machinesHash() => r'4fb989052d1ff2320751ad3415ba15d70f46800b';

/// See also [Machines].
@ProviderFor(Machines)
final machinesProvider =
    AutoDisposeNotifierProvider<Machines, SaveChecklistState>.internal(
  Machines.new,
  name: r'machinesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$machinesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Machines = AutoDisposeNotifier<SaveChecklistState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
