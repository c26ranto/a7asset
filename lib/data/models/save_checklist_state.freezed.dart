// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'save_checklist_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SaveChecklistState {
  SaveChecklistStatus get status => throw _privateConstructorUsedError;
  String? get success => throw _privateConstructorUsedError;
  CustomError get customError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SaveChecklistStateCopyWith<SaveChecklistState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaveChecklistStateCopyWith<$Res> {
  factory $SaveChecklistStateCopyWith(
          SaveChecklistState value, $Res Function(SaveChecklistState) then) =
      _$SaveChecklistStateCopyWithImpl<$Res, SaveChecklistState>;
  @useResult
  $Res call(
      {SaveChecklistStatus status, String? success, CustomError customError});

  $CustomErrorCopyWith<$Res> get customError;
}

/// @nodoc
class _$SaveChecklistStateCopyWithImpl<$Res, $Val extends SaveChecklistState>
    implements $SaveChecklistStateCopyWith<$Res> {
  _$SaveChecklistStateCopyWithImpl(this._value, this._then);

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
              as SaveChecklistStatus,
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
abstract class _$$SaveChecklistStateImplCopyWith<$Res>
    implements $SaveChecklistStateCopyWith<$Res> {
  factory _$$SaveChecklistStateImplCopyWith(_$SaveChecklistStateImpl value,
          $Res Function(_$SaveChecklistStateImpl) then) =
      __$$SaveChecklistStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SaveChecklistStatus status, String? success, CustomError customError});

  @override
  $CustomErrorCopyWith<$Res> get customError;
}

/// @nodoc
class __$$SaveChecklistStateImplCopyWithImpl<$Res>
    extends _$SaveChecklistStateCopyWithImpl<$Res, _$SaveChecklistStateImpl>
    implements _$$SaveChecklistStateImplCopyWith<$Res> {
  __$$SaveChecklistStateImplCopyWithImpl(_$SaveChecklistStateImpl _value,
      $Res Function(_$SaveChecklistStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? success = freezed,
    Object? customError = null,
  }) {
    return _then(_$SaveChecklistStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SaveChecklistStatus,
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

class _$SaveChecklistStateImpl implements _SaveChecklistState {
  const _$SaveChecklistStateImpl(
      {required this.status, required this.success, required this.customError});

  @override
  final SaveChecklistStatus status;
  @override
  final String? success;
  @override
  final CustomError customError;

  @override
  String toString() {
    return 'SaveChecklistState(status: $status, success: $success, customError: $customError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveChecklistStateImpl &&
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
  _$$SaveChecklistStateImplCopyWith<_$SaveChecklistStateImpl> get copyWith =>
      __$$SaveChecklistStateImplCopyWithImpl<_$SaveChecklistStateImpl>(
          this, _$identity);
}

abstract class _SaveChecklistState implements SaveChecklistState {
  const factory _SaveChecklistState(
      {required final SaveChecklistStatus status,
      required final String? success,
      required final CustomError customError}) = _$SaveChecklistStateImpl;

  @override
  SaveChecklistStatus get status;
  @override
  String? get success;
  @override
  CustomError get customError;
  @override
  @JsonKey(ignore: true)
  _$$SaveChecklistStateImplCopyWith<_$SaveChecklistStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
