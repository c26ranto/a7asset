// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'status_machine.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StatusMachine {
  @JsonKey(name: 'tschdt::date')
  String? get changeDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'tschdt::time::bpchar')
  String? get changeTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'tschid')
  String? get changeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tschno')
  String? get changeNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'tscsdt::bpchar')
  String? get systemChangeDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'tscsid')
  String? get systemChangeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tsremk')
  String? get remark => throw _privateConstructorUsedError;
  @JsonKey(name: 'tsrgdt::date')
  String? get entryDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'tsrgdt::time::bpchar')
  String? get entryTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'tsrgid')
  String? get entryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tssycd')
  int? get systemCode =>
      throw _privateConstructorUsedError; // Perubahan di sini
  @JsonKey(name: 'tssynm')
  String? get systemName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StatusMachineCopyWith<StatusMachine> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusMachineCopyWith<$Res> {
  factory $StatusMachineCopyWith(
          StatusMachine value, $Res Function(StatusMachine) then) =
      _$StatusMachineCopyWithImpl<$Res, StatusMachine>;
  @useResult
  $Res call(
      {@JsonKey(name: 'tschdt::date') String? changeDate,
      @JsonKey(name: 'tschdt::time::bpchar') String? changeTime,
      @JsonKey(name: 'tschid') String? changeId,
      @JsonKey(name: 'tschno') String? changeNo,
      @JsonKey(name: 'tscsdt::bpchar') String? systemChangeDate,
      @JsonKey(name: 'tscsid') String? systemChangeId,
      @JsonKey(name: 'tsremk') String? remark,
      @JsonKey(name: 'tsrgdt::date') String? entryDate,
      @JsonKey(name: 'tsrgdt::time::bpchar') String? entryTime,
      @JsonKey(name: 'tsrgid') String? entryId,
      @JsonKey(name: 'tssycd') int? systemCode,
      @JsonKey(name: 'tssynm') String? systemName});
}

/// @nodoc
class _$StatusMachineCopyWithImpl<$Res, $Val extends StatusMachine>
    implements $StatusMachineCopyWith<$Res> {
  _$StatusMachineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? changeDate = freezed,
    Object? changeTime = freezed,
    Object? changeId = freezed,
    Object? changeNo = freezed,
    Object? systemChangeDate = freezed,
    Object? systemChangeId = freezed,
    Object? remark = freezed,
    Object? entryDate = freezed,
    Object? entryTime = freezed,
    Object? entryId = freezed,
    Object? systemCode = freezed,
    Object? systemName = freezed,
  }) {
    return _then(_value.copyWith(
      changeDate: freezed == changeDate
          ? _value.changeDate
          : changeDate // ignore: cast_nullable_to_non_nullable
              as String?,
      changeTime: freezed == changeTime
          ? _value.changeTime
          : changeTime // ignore: cast_nullable_to_non_nullable
              as String?,
      changeId: freezed == changeId
          ? _value.changeId
          : changeId // ignore: cast_nullable_to_non_nullable
              as String?,
      changeNo: freezed == changeNo
          ? _value.changeNo
          : changeNo // ignore: cast_nullable_to_non_nullable
              as String?,
      systemChangeDate: freezed == systemChangeDate
          ? _value.systemChangeDate
          : systemChangeDate // ignore: cast_nullable_to_non_nullable
              as String?,
      systemChangeId: freezed == systemChangeId
          ? _value.systemChangeId
          : systemChangeId // ignore: cast_nullable_to_non_nullable
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String?,
      entryDate: freezed == entryDate
          ? _value.entryDate
          : entryDate // ignore: cast_nullable_to_non_nullable
              as String?,
      entryTime: freezed == entryTime
          ? _value.entryTime
          : entryTime // ignore: cast_nullable_to_non_nullable
              as String?,
      entryId: freezed == entryId
          ? _value.entryId
          : entryId // ignore: cast_nullable_to_non_nullable
              as String?,
      systemCode: freezed == systemCode
          ? _value.systemCode
          : systemCode // ignore: cast_nullable_to_non_nullable
              as int?,
      systemName: freezed == systemName
          ? _value.systemName
          : systemName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatusMachineImplCopyWith<$Res>
    implements $StatusMachineCopyWith<$Res> {
  factory _$$StatusMachineImplCopyWith(
          _$StatusMachineImpl value, $Res Function(_$StatusMachineImpl) then) =
      __$$StatusMachineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'tschdt::date') String? changeDate,
      @JsonKey(name: 'tschdt::time::bpchar') String? changeTime,
      @JsonKey(name: 'tschid') String? changeId,
      @JsonKey(name: 'tschno') String? changeNo,
      @JsonKey(name: 'tscsdt::bpchar') String? systemChangeDate,
      @JsonKey(name: 'tscsid') String? systemChangeId,
      @JsonKey(name: 'tsremk') String? remark,
      @JsonKey(name: 'tsrgdt::date') String? entryDate,
      @JsonKey(name: 'tsrgdt::time::bpchar') String? entryTime,
      @JsonKey(name: 'tsrgid') String? entryId,
      @JsonKey(name: 'tssycd') int? systemCode,
      @JsonKey(name: 'tssynm') String? systemName});
}

/// @nodoc
class __$$StatusMachineImplCopyWithImpl<$Res>
    extends _$StatusMachineCopyWithImpl<$Res, _$StatusMachineImpl>
    implements _$$StatusMachineImplCopyWith<$Res> {
  __$$StatusMachineImplCopyWithImpl(
      _$StatusMachineImpl _value, $Res Function(_$StatusMachineImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? changeDate = freezed,
    Object? changeTime = freezed,
    Object? changeId = freezed,
    Object? changeNo = freezed,
    Object? systemChangeDate = freezed,
    Object? systemChangeId = freezed,
    Object? remark = freezed,
    Object? entryDate = freezed,
    Object? entryTime = freezed,
    Object? entryId = freezed,
    Object? systemCode = freezed,
    Object? systemName = freezed,
  }) {
    return _then(_$StatusMachineImpl(
      changeDate: freezed == changeDate
          ? _value.changeDate
          : changeDate // ignore: cast_nullable_to_non_nullable
              as String?,
      changeTime: freezed == changeTime
          ? _value.changeTime
          : changeTime // ignore: cast_nullable_to_non_nullable
              as String?,
      changeId: freezed == changeId
          ? _value.changeId
          : changeId // ignore: cast_nullable_to_non_nullable
              as String?,
      changeNo: freezed == changeNo
          ? _value.changeNo
          : changeNo // ignore: cast_nullable_to_non_nullable
              as String?,
      systemChangeDate: freezed == systemChangeDate
          ? _value.systemChangeDate
          : systemChangeDate // ignore: cast_nullable_to_non_nullable
              as String?,
      systemChangeId: freezed == systemChangeId
          ? _value.systemChangeId
          : systemChangeId // ignore: cast_nullable_to_non_nullable
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String?,
      entryDate: freezed == entryDate
          ? _value.entryDate
          : entryDate // ignore: cast_nullable_to_non_nullable
              as String?,
      entryTime: freezed == entryTime
          ? _value.entryTime
          : entryTime // ignore: cast_nullable_to_non_nullable
              as String?,
      entryId: freezed == entryId
          ? _value.entryId
          : entryId // ignore: cast_nullable_to_non_nullable
              as String?,
      systemCode: freezed == systemCode
          ? _value.systemCode
          : systemCode // ignore: cast_nullable_to_non_nullable
              as int?,
      systemName: freezed == systemName
          ? _value.systemName
          : systemName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$StatusMachineImpl implements _StatusMachine {
  const _$StatusMachineImpl(
      {@JsonKey(name: 'tschdt::date') this.changeDate,
      @JsonKey(name: 'tschdt::time::bpchar') this.changeTime,
      @JsonKey(name: 'tschid') this.changeId,
      @JsonKey(name: 'tschno') this.changeNo,
      @JsonKey(name: 'tscsdt::bpchar') this.systemChangeDate,
      @JsonKey(name: 'tscsid') this.systemChangeId,
      @JsonKey(name: 'tsremk') this.remark,
      @JsonKey(name: 'tsrgdt::date') this.entryDate,
      @JsonKey(name: 'tsrgdt::time::bpchar') this.entryTime,
      @JsonKey(name: 'tsrgid') this.entryId,
      @JsonKey(name: 'tssycd') this.systemCode,
      @JsonKey(name: 'tssynm') this.systemName});

  @override
  @JsonKey(name: 'tschdt::date')
  final String? changeDate;
  @override
  @JsonKey(name: 'tschdt::time::bpchar')
  final String? changeTime;
  @override
  @JsonKey(name: 'tschid')
  final String? changeId;
  @override
  @JsonKey(name: 'tschno')
  final String? changeNo;
  @override
  @JsonKey(name: 'tscsdt::bpchar')
  final String? systemChangeDate;
  @override
  @JsonKey(name: 'tscsid')
  final String? systemChangeId;
  @override
  @JsonKey(name: 'tsremk')
  final String? remark;
  @override
  @JsonKey(name: 'tsrgdt::date')
  final String? entryDate;
  @override
  @JsonKey(name: 'tsrgdt::time::bpchar')
  final String? entryTime;
  @override
  @JsonKey(name: 'tsrgid')
  final String? entryId;
  @override
  @JsonKey(name: 'tssycd')
  final int? systemCode;
// Perubahan di sini
  @override
  @JsonKey(name: 'tssynm')
  final String? systemName;

  @override
  String toString() {
    return 'StatusMachine(changeDate: $changeDate, changeTime: $changeTime, changeId: $changeId, changeNo: $changeNo, systemChangeDate: $systemChangeDate, systemChangeId: $systemChangeId, remark: $remark, entryDate: $entryDate, entryTime: $entryTime, entryId: $entryId, systemCode: $systemCode, systemName: $systemName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusMachineImpl &&
            (identical(other.changeDate, changeDate) ||
                other.changeDate == changeDate) &&
            (identical(other.changeTime, changeTime) ||
                other.changeTime == changeTime) &&
            (identical(other.changeId, changeId) ||
                other.changeId == changeId) &&
            (identical(other.changeNo, changeNo) ||
                other.changeNo == changeNo) &&
            (identical(other.systemChangeDate, systemChangeDate) ||
                other.systemChangeDate == systemChangeDate) &&
            (identical(other.systemChangeId, systemChangeId) ||
                other.systemChangeId == systemChangeId) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.entryDate, entryDate) ||
                other.entryDate == entryDate) &&
            (identical(other.entryTime, entryTime) ||
                other.entryTime == entryTime) &&
            (identical(other.entryId, entryId) || other.entryId == entryId) &&
            (identical(other.systemCode, systemCode) ||
                other.systemCode == systemCode) &&
            (identical(other.systemName, systemName) ||
                other.systemName == systemName));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      changeDate,
      changeTime,
      changeId,
      changeNo,
      systemChangeDate,
      systemChangeId,
      remark,
      entryDate,
      entryTime,
      entryId,
      systemCode,
      systemName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusMachineImplCopyWith<_$StatusMachineImpl> get copyWith =>
      __$$StatusMachineImplCopyWithImpl<_$StatusMachineImpl>(this, _$identity);
}

abstract class _StatusMachine implements StatusMachine {
  const factory _StatusMachine(
      {@JsonKey(name: 'tschdt::date') final String? changeDate,
      @JsonKey(name: 'tschdt::time::bpchar') final String? changeTime,
      @JsonKey(name: 'tschid') final String? changeId,
      @JsonKey(name: 'tschno') final String? changeNo,
      @JsonKey(name: 'tscsdt::bpchar') final String? systemChangeDate,
      @JsonKey(name: 'tscsid') final String? systemChangeId,
      @JsonKey(name: 'tsremk') final String? remark,
      @JsonKey(name: 'tsrgdt::date') final String? entryDate,
      @JsonKey(name: 'tsrgdt::time::bpchar') final String? entryTime,
      @JsonKey(name: 'tsrgid') final String? entryId,
      @JsonKey(name: 'tssycd') final int? systemCode,
      @JsonKey(name: 'tssynm') final String? systemName}) = _$StatusMachineImpl;

  @override
  @JsonKey(name: 'tschdt::date')
  String? get changeDate;
  @override
  @JsonKey(name: 'tschdt::time::bpchar')
  String? get changeTime;
  @override
  @JsonKey(name: 'tschid')
  String? get changeId;
  @override
  @JsonKey(name: 'tschno')
  String? get changeNo;
  @override
  @JsonKey(name: 'tscsdt::bpchar')
  String? get systemChangeDate;
  @override
  @JsonKey(name: 'tscsid')
  String? get systemChangeId;
  @override
  @JsonKey(name: 'tsremk')
  String? get remark;
  @override
  @JsonKey(name: 'tsrgdt::date')
  String? get entryDate;
  @override
  @JsonKey(name: 'tsrgdt::time::bpchar')
  String? get entryTime;
  @override
  @JsonKey(name: 'tsrgid')
  String? get entryId;
  @override
  @JsonKey(name: 'tssycd')
  int? get systemCode;
  @override // Perubahan di sini
  @JsonKey(name: 'tssynm')
  String? get systemName;
  @override
  @JsonKey(ignore: true)
  _$$StatusMachineImplCopyWith<_$StatusMachineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
