// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generate_clhead_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GenerateClheadState {
  GenerateClheadStatus get status => throw _privateConstructorUsedError;
  String? get success => throw _privateConstructorUsedError;
  CustomError get customError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GenerateClheadStateCopyWith<GenerateClheadState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenerateClheadStateCopyWith<$Res> {
  factory $GenerateClheadStateCopyWith(
          GenerateClheadState value, $Res Function(GenerateClheadState) then) =
      _$GenerateClheadStateCopyWithImpl<$Res, GenerateClheadState>;
  @useResult
  $Res call(
      {GenerateClheadStatus status, String? success, CustomError customError});

  $CustomErrorCopyWith<$Res> get customError;
}

/// @nodoc
class _$GenerateClheadStateCopyWithImpl<$Res, $Val extends GenerateClheadState>
    implements $GenerateClheadStateCopyWith<$Res> {
  _$GenerateClheadStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? success = freezed,
    Object? customError = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GenerateClheadStatus,
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as String?,
      customError: null == customError
          ? _value.customError
          : customError // ignore: cast_nullable_to_non_nullable
              as CustomError,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CustomErrorCopyWith<$Res> get customError {
    return $CustomErrorCopyWith<$Res>(_value.customError, (value) {
      return _then(_value.copyWith(customError: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GenerateClheadStateImplCopyWith<$Res>
    implements $GenerateClheadStateCopyWith<$Res> {
  factory _$$GenerateClheadStateImplCopyWith(_$GenerateClheadStateImpl value,
          $Res Function(_$GenerateClheadStateImpl) then) =
      __$$GenerateClheadStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GenerateClheadStatus status, String? success, CustomError customError});

  @override
  $CustomErrorCopyWith<$Res> get customError;
}

/// @nodoc
class __$$GenerateClheadStateImplCopyWithImpl<$Res>
    extends _$GenerateClheadStateCopyWithImpl<$Res, _$GenerateClheadStateImpl>
    implements _$$GenerateClheadStateImplCopyWith<$Res> {
  __$$GenerateClheadStateImplCopyWithImpl(_$GenerateClheadStateImpl _value,
      $Res Function(_$GenerateClheadStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? success = freezed,
    Object? customError = null,
  }) {
    return _then(_$GenerateClheadStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GenerateClheadStatus,
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as String?,
      customError: null == customError
          ? _value.customError
          : customError // ignore: cast_nullable_to_non_nullable
              as CustomError,
    ));
  }
}

/// @nodoc

class _$GenerateClheadStateImpl implements _GenerateClheadState {
  const _$GenerateClheadStateImpl(
      {required this.status, required this.success, required this.customError});

  @override
  final GenerateClheadStatus status;
  @override
  final String? success;
  @override
  final CustomError customError;

  @override
  String toString() {
    return 'GenerateClheadState(status: $status, success: $success, customError: $customError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenerateClheadStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.customError, customError) ||
                other.customError == customError));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, success, customError);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GenerateClheadStateImplCopyWith<_$GenerateClheadStateImpl> get copyWith =>
      __$$GenerateClheadStateImplCopyWithImpl<_$GenerateClheadStateImpl>(
          this, _$identity);
}

abstract class _GenerateClheadState implements GenerateClheadState {
  const factory _GenerateClheadState(
      {required final GenerateClheadStatus status,
      required final String? success,
      required final CustomError customError}) = _$GenerateClheadStateImpl;

  @override
  GenerateClheadStatus get status;
  @override
  String? get success;
  @override
  CustomError get customError;
  @override
  @JsonKey(ignore: true)
  _$$GenerateClheadStateImplCopyWith<_$GenerateClheadStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
