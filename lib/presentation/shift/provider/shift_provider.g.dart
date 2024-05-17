// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getShiftHash() => r'1abb6c5b1b3b736e1ea541a794ffc8c884b384e4';

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
String _$getAllMachinesHash() => r'98279a47cab1bbcebc3155a3496fa4a98547d341';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getAllMachines].
@ProviderFor(getAllMachines)
const getAllMachinesProvider = GetAllMachinesFamily();

/// See also [getAllMachines].
class GetAllMachinesFamily
    extends Family<AsyncValue<List<Map<String, dynamic>>>> {
  /// See also [getAllMachines].
  const GetAllMachinesFamily();

  /// See also [getAllMachines].
  GetAllMachinesProvider call({
    required String id,
    required String type,
  }) {
    return GetAllMachinesProvider(
      id: id,
      type: type,
    );
  }

  @override
  GetAllMachinesProvider getProviderOverride(
    covariant GetAllMachinesProvider provider,
  ) {
    return call(
      id: provider.id,
      type: provider.type,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getAllMachinesProvider';
}

/// See also [getAllMachines].
class GetAllMachinesProvider
    extends AutoDisposeFutureProvider<List<Map<String, dynamic>>> {
  /// See also [getAllMachines].
  GetAllMachinesProvider({
    required String id,
    required String type,
  }) : this._internal(
          (ref) => getAllMachines(
            ref as GetAllMachinesRef,
            id: id,
            type: type,
          ),
          from: getAllMachinesProvider,
          name: r'getAllMachinesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAllMachinesHash,
          dependencies: GetAllMachinesFamily._dependencies,
          allTransitiveDependencies:
              GetAllMachinesFamily._allTransitiveDependencies,
          id: id,
          type: type,
        );

  GetAllMachinesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.type,
  }) : super.internal();

  final String id;
  final String type;

  @override
  Override overrideWith(
    FutureOr<List<Map<String, dynamic>>> Function(GetAllMachinesRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetAllMachinesProvider._internal(
        (ref) => create(ref as GetAllMachinesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Map<String, dynamic>>> createElement() {
    return _GetAllMachinesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetAllMachinesProvider &&
        other.id == id &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetAllMachinesRef
    on AutoDisposeFutureProviderRef<List<Map<String, dynamic>>> {
  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `type` of this provider.
  String get type;
}

class _GetAllMachinesProviderElement
    extends AutoDisposeFutureProviderElement<List<Map<String, dynamic>>>
    with GetAllMachinesRef {
  _GetAllMachinesProviderElement(super.provider);

  @override
  String get id => (origin as GetAllMachinesProvider).id;
  @override
  String get type => (origin as GetAllMachinesProvider).type;
}

String _$getStatusMachineHash() => r'554440aaba7cdd63f48800d718d102cd94d8b90a';

/// See also [getStatusMachine].
@ProviderFor(getStatusMachine)
final getStatusMachineProvider = AutoDisposeFutureProvider<AuthState>.internal(
  getStatusMachine,
  name: r'getStatusMachineProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getStatusMachineHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetStatusMachineRef = AutoDisposeFutureProviderRef<AuthState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
