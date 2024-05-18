// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checklist_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChecklistState {
  ChecklistStatus get status => throw _privateConstructorUsedError;
  List<Map<String, dynamic>>? get success => throw _privateConstructorUsedError;
  CustomError get customError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChecklistStateCopyWith<ChecklistState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChecklistStateCopyWith<$Res> {
  factory $ChecklistStateCopyWith(
          ChecklistState value, $Res Function(ChecklistState) then) =
      _$ChecklistStateCopyWithImpl<$Res, ChecklistState>;
  @useResult
  $Res call(
      {ChecklistStatus status,
      List<Map<String, dynamic>>? success,
      CustomError customError});

  $CustomErrorCopyWith<$Res> get customError;
}

/// @nodoc
class _$ChecklistStateCopyWithImpl<$Res, $Val extends ChecklistState>
    implements $ChecklistStateCopyWith<$Res> {
  _$ChecklistStateCopyWithImpl(this._value, this._then);

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
              as ChecklistStatus,
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
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
abstract class _$$ChecklistStateImplCopyWith<$Res>
    implements $ChecklistStateCopyWith<$Res> {
  factory _$$ChecklistStateImplCopyWith(_$ChecklistStateImpl value,
          $Res Function(_$ChecklistStateImpl) then) =
      __$$ChecklistStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ChecklistStatus status,
      List<Map<String, dynamic>>? success,
      CustomError customError});

  @override
  $CustomErrorCopyWith<$Res> get customError;
}

/// @nodoc
class __$$ChecklistStateImplCopyWithImpl<$Res>
    extends _$ChecklistStateCopyWithImpl<$Res, _$ChecklistStateImpl>
    implements _$$ChecklistStateImplCopyWith<$Res> {
  __$$ChecklistStateImplCopyWithImpl(
      _$ChecklistStateImpl _value, $Res Function(_$ChecklistStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? success = freezed,
    Object? customError = null,
  }) {
    return _then(_$ChecklistStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ChecklistStatus,
      success: freezed == success
          ? _value._success
          : success // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
      customError: null == customError
          ? _value.customError
          : customError // ignore: cast_nullable_to_non_nullable
              as CustomError,
    ));
  }
}

/// @nodoc

class _$ChecklistStateImpl implements _ChecklistState {
  const _$ChecklistStateImpl(
      {required this.status,
      required final List<Map<String, dynamic>>? success,
      required this.customError})
      : _success = success;

  @override
  final ChecklistStatus status;
  final List<Map<String, dynamic>>? _success;
  @override
  List<Map<String, dynamic>>? get success {
    final value = _success;
    if (value == null) return null;
    if (_success is EqualUnmodifiableListView) return _success;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final CustomError customError;

  @override
  String toString() {
    return 'ChecklistState(status: $status, success: $success, customError: $customError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChecklistStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._success, _success) &&
            (identical(other.customError, customError) ||
                other.customError == customError));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status,
      const DeepCollectionEquality().hash(_success), customError);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChecklistStateImplCopyWith<_$ChecklistStateImpl> get copyWith =>
      __$$ChecklistStateImplCopyWithImpl<_$ChecklistStateImpl>(
          this, _$identity);
}

abstract class _ChecklistState implements ChecklistState {
  const factory _ChecklistState(
      {required final ChecklistStatus status,
      required final List<Map<String, dynamic>>? success,
      required final CustomError customError}) = _$ChecklistStateImpl;

  @override
  ChecklistStatus get status;
  @override
  List<Map<String, dynamic>>? get success;
  @override
  CustomError get customError;
  @override
  @JsonKey(ignore: true)
  _$$ChecklistStateImplCopyWith<_$ChecklistStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
