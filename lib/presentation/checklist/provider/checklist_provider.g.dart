// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$takePictureHash() => r'4ef2fcfac6ed2155f0daa55019cf47b4211bfac1';

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

/// See also [takePicture].
@ProviderFor(takePicture)
const takePictureProvider = TakePictureFamily();

/// See also [takePicture].
class TakePictureFamily extends Family<AsyncValue<void>> {
  /// See also [takePicture].
  const TakePictureFamily();

  /// See also [takePicture].
  TakePictureProvider call({
    required TakePhotoChecklistType type,
  }) {
    return TakePictureProvider(
      type: type,
    );
  }

  @override
  TakePictureProvider getProviderOverride(
    covariant TakePictureProvider provider,
  ) {
    return call(
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
  String? get name => r'takePictureProvider';
}

/// See also [takePicture].
class TakePictureProvider extends AutoDisposeFutureProvider<void> {
  /// See also [takePicture].
  TakePictureProvider({
    required TakePhotoChecklistType type,
  }) : this._internal(
          (ref) => takePicture(
            ref as TakePictureRef,
            type: type,
          ),
          from: takePictureProvider,
          name: r'takePictureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$takePictureHash,
          dependencies: TakePictureFamily._dependencies,
          allTransitiveDependencies:
              TakePictureFamily._allTransitiveDependencies,
          type: type,
        );

  TakePictureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final TakePhotoChecklistType type;

  @override
  Override overrideWith(
    FutureOr<void> Function(TakePictureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TakePictureProvider._internal(
        (ref) => create(ref as TakePictureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _TakePictureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TakePictureProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TakePictureRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `type` of this provider.
  TakePhotoChecklistType get type;
}

class _TakePictureProviderElement extends AutoDisposeFutureProviderElement<void>
    with TakePictureRef {
  _TakePictureProviderElement(super.provider);

  @override
  TakePhotoChecklistType get type => (origin as TakePictureProvider).type;
}

String _$getChecklistHash() => r'b3bef6130967a0659247616f1b267d2695af15f8';

/// See also [getChecklist].
@ProviderFor(getChecklist)
const getChecklistProvider = GetChecklistFamily();

/// See also [getChecklist].
class GetChecklistFamily
    extends Family<AsyncValue<List<ChecklistDetailModel>>> {
  /// See also [getChecklist].
  const GetChecklistFamily();

  /// See also [getChecklist].
  GetChecklistProvider call({
    required String cdchcdiy,
  }) {
    return GetChecklistProvider(
      cdchcdiy: cdchcdiy,
    );
  }

  @override
  GetChecklistProvider getProviderOverride(
    covariant GetChecklistProvider provider,
  ) {
    return call(
      cdchcdiy: provider.cdchcdiy,
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
  String? get name => r'getChecklistProvider';
}

/// See also [getChecklist].
class GetChecklistProvider
    extends AutoDisposeFutureProvider<List<ChecklistDetailModel>> {
  /// See also [getChecklist].
  GetChecklistProvider({
    required String cdchcdiy,
  }) : this._internal(
          (ref) => getChecklist(
            ref as GetChecklistRef,
            cdchcdiy: cdchcdiy,
          ),
          from: getChecklistProvider,
          name: r'getChecklistProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getChecklistHash,
          dependencies: GetChecklistFamily._dependencies,
          allTransitiveDependencies:
              GetChecklistFamily._allTransitiveDependencies,
          cdchcdiy: cdchcdiy,
        );

  GetChecklistProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cdchcdiy,
  }) : super.internal();

  final String cdchcdiy;

  @override
  Override overrideWith(
    FutureOr<List<ChecklistDetailModel>> Function(GetChecklistRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetChecklistProvider._internal(
        (ref) => create(ref as GetChecklistRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cdchcdiy: cdchcdiy,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ChecklistDetailModel>> createElement() {
    return _GetChecklistProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetChecklistProvider && other.cdchcdiy == cdchcdiy;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cdchcdiy.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetChecklistRef
    on AutoDisposeFutureProviderRef<List<ChecklistDetailModel>> {
  /// The parameter `cdchcdiy` of this provider.
  String get cdchcdiy;
}

class _GetChecklistProviderElement
    extends AutoDisposeFutureProviderElement<List<ChecklistDetailModel>>
    with GetChecklistRef {
  _GetChecklistProviderElement(super.provider);

  @override
  String get cdchcdiy => (origin as GetChecklistProvider).cdchcdiy;
}

String _$generateClheadHash() => r'3e053a238e0f48e05fb4751ba7f0bc7edac1e9e1';

/// See also [GenerateClhead].
@ProviderFor(GenerateClhead)
final generateClheadProvider =
    AutoDisposeNotifierProvider<GenerateClhead, GenerateClheadState>.internal(
  GenerateClhead.new,
  name: r'generateClheadProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$generateClheadHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GenerateClhead = AutoDisposeNotifier<GenerateClheadState>;
String _$checklistHash() => r'd67e96a49bc800486f9c722238602758a8dd0ed8';

/// See also [Checklist].
@ProviderFor(Checklist)
final checklistProvider =
    AutoDisposeNotifierProvider<Checklist, ChecklistState>.internal(
  Checklist.new,
  name: r'checklistProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$checklistHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Checklist = AutoDisposeNotifier<ChecklistState>;
String _$saveChecklistHash() => r'ba5a0b356fe13ed1774b4f50ac9347f03d544f9d';

/// See also [SaveChecklist].
@ProviderFor(SaveChecklist)
final saveChecklistProvider =
    AutoDisposeNotifierProvider<SaveChecklist, SaveChecklistState>.internal(
  SaveChecklist.new,
  name: r'saveChecklistProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$saveChecklistHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SaveChecklist = AutoDisposeNotifier<SaveChecklistState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
