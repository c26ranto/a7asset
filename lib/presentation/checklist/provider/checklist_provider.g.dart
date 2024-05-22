// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$takePictureHash() => r'642b48f68aa359178eb2d9721f3356dad7bcfb23';

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

String _$getImagesChecklistHash() =>
    r'94b27a354f1c3a3bb4fed2edcf342eb1245a147b';

/// See also [getImagesChecklist].
@ProviderFor(getImagesChecklist)
const getImagesChecklistProvider = GetImagesChecklistFamily();

/// See also [getImagesChecklist].
class GetImagesChecklistFamily extends Family<AsyncValue> {
  /// See also [getImagesChecklist].
  const GetImagesChecklistFamily();

  /// See also [getImagesChecklist].
  GetImagesChecklistProvider call({
    required String fileKey,
    required String fileName,
  }) {
    return GetImagesChecklistProvider(
      fileKey: fileKey,
      fileName: fileName,
    );
  }

  @override
  GetImagesChecklistProvider getProviderOverride(
    covariant GetImagesChecklistProvider provider,
  ) {
    return call(
      fileKey: provider.fileKey,
      fileName: provider.fileName,
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
  String? get name => r'getImagesChecklistProvider';
}

/// See also [getImagesChecklist].
class GetImagesChecklistProvider extends AutoDisposeFutureProvider<Object?> {
  /// See also [getImagesChecklist].
  GetImagesChecklistProvider({
    required String fileKey,
    required String fileName,
  }) : this._internal(
          (ref) => getImagesChecklist(
            ref as GetImagesChecklistRef,
            fileKey: fileKey,
            fileName: fileName,
          ),
          from: getImagesChecklistProvider,
          name: r'getImagesChecklistProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getImagesChecklistHash,
          dependencies: GetImagesChecklistFamily._dependencies,
          allTransitiveDependencies:
              GetImagesChecklistFamily._allTransitiveDependencies,
          fileKey: fileKey,
          fileName: fileName,
        );

  GetImagesChecklistProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.fileKey,
    required this.fileName,
  }) : super.internal();

  final String fileKey;
  final String fileName;

  @override
  Override overrideWith(
    FutureOr<Object?> Function(GetImagesChecklistRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetImagesChecklistProvider._internal(
        (ref) => create(ref as GetImagesChecklistRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        fileKey: fileKey,
        fileName: fileName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Object?> createElement() {
    return _GetImagesChecklistProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetImagesChecklistProvider &&
        other.fileKey == fileKey &&
        other.fileName == fileName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, fileKey.hashCode);
    hash = _SystemHash.combine(hash, fileName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetImagesChecklistRef on AutoDisposeFutureProviderRef<Object?> {
  /// The parameter `fileKey` of this provider.
  String get fileKey;

  /// The parameter `fileName` of this provider.
  String get fileName;
}

class _GetImagesChecklistProviderElement
    extends AutoDisposeFutureProviderElement<Object?>
    with GetImagesChecklistRef {
  _GetImagesChecklistProviderElement(super.provider);

  @override
  String get fileKey => (origin as GetImagesChecklistProvider).fileKey;
  @override
  String get fileName => (origin as GetImagesChecklistProvider).fileName;
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
String _$checklistHash() => r'0b83b72d60bf68b04a6e8d44400fbbd9eb04a0fa';

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
String _$saveChecklistHash() => r'3a7bdb5b7e455a0f3e3df7625a15481d8b23dbef';

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
String _$checklistControllerHash() =>
    r'ec6a714c74c8c7f194813ca759c46f23b1529635';

/// See also [ChecklistController].
@ProviderFor(ChecklistController)
final checklistControllerProvider =
    AutoDisposeNotifierProvider<ChecklistController, void>.internal(
  ChecklistController.new,
  name: r'checklistControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$checklistControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChecklistController = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
