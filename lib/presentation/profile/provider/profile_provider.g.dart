// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$changePasswordHash() => r'c344c72ee8347860f7082bde14f44c372eb0555b';

/// See also [ChangePassword].
@ProviderFor(ChangePassword)
final changePasswordProvider =
    AutoDisposeNotifierProvider<ChangePassword, AuthState>.internal(
  ChangePassword.new,
  name: r'changePasswordProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$changePasswordHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChangePassword = AutoDisposeNotifier<AuthState>;
String _$logoutHash() => r'a1bf6db5c89e56edf87c43db162fd1171fbee360';

/// See also [Logout].
@ProviderFor(Logout)
final logoutProvider = AutoDisposeNotifierProvider<Logout, AuthState>.internal(
  Logout.new,
  name: r'logoutProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$logoutHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Logout = AutoDisposeNotifier<AuthState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
