import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_machine.freezed.dart';

@freezed
class StatusMachine with _$StatusMachine {
  const factory StatusMachine({
    @JsonKey(name: 'tschdt::date') String? changeDate,
    @JsonKey(name: 'tschdt::time::bpchar') String? changeTime,
    @JsonKey(name: 'tschid') String? changeId,
    @JsonKey(name: 'tschno') String? changeNo,
    @JsonKey(name: 'tscsdt::bpchar') String? systemChangeDate,
    @JsonKey(name: 'tscsid') String? systemChangeId,
    @JsonKey(name: 'tsremk') String? remark,
    @JsonKey(name: 'tsrgdt::date') String? entryDate,
    @JsonKey(name: 'tsrgdt::time::bpchar') String? entryTime,
    @JsonKey(name: 'tsrgid') String? entryId,
    @JsonKey(name: 'tssycd') int? systemCode, // Perubahan di sini
    @JsonKey(name: 'tssynm') String? systemName,
  }) = _StatusMachine;

  factory StatusMachine.fromJson(Map<String, dynamic> json) {
    return StatusMachine(
      changeDate: json['tschdt::date'] as String?,
      changeTime: json['tschdt::time::bpchar'] as String?,
      changeId: json['tschid'] as String?,
      changeNo: json['tschno'] != null ? json["tschno"].toString() : null,
      systemChangeDate: json['tscsdt::bpchar'] as String?,
      systemChangeId: json['tscsid'] as String?,
      remark: json['tsremk'] as String?,
      entryDate: json['tsrgdt::date'] as String?,
      entryTime: json['tsrgdt::time::bpchar'] as String?,
      entryId: json['tsrgid'] as String?,
      systemCode: json['tssycd'] != null ? int.tryParse(json['tssycd'].toString()) : null,
      systemName: json['tssynm'] as String?,
    );
  }
}
