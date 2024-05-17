import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChecklistDetailModel {
  String? cdcdds;
  int? cdcdln;
  int? cdcdlniy;
  int? cdchcdiy;
  DateTime? cdchdtDate;
  String? cdchdtTimeBpchar;
  String? cdchid;
  int? cdchno;
  DateTime? cdcsdtBpchar;
  String? cdcsid;
  int? cdmand;
  String? cdremk;
  DateTime? cdrgdtDate;
  String? cdrgdtTimeBpchar;
  String? cdrgid;
  double? cdrglv;
  double? cdrguv;
  String? cdtype;
  String? cdunms;
  int? cdvalu;
  String? dpfgTssynm;
  String? typeTssycd;
  String? typeTssynm;
  String? unmsTssycd;
  String? unmsTssynm;
  ChecklistDetailModel({
    this.cdcdds,
    this.cdcdln,
    this.cdcdlniy,
    this.cdchcdiy,
    this.cdchdtDate,
    this.cdchdtTimeBpchar,
    this.cdchid,
    this.cdchno,
    this.cdcsdtBpchar,
    this.cdcsid,
    this.cdmand,
    this.cdremk,
    this.cdrgdtDate,
    this.cdrgdtTimeBpchar,
    this.cdrgid,
    this.cdrglv,
    this.cdrguv,
    this.cdtype,
    this.cdunms,
    this.cdvalu,
    this.dpfgTssynm,
    this.typeTssycd,
    this.typeTssynm,
    this.unmsTssycd,
    this.unmsTssynm,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cdcdds': cdcdds,
      'cdcdln': cdcdln,
      'cdcdlniy': cdcdlniy,
      'cdchcdiy': cdchcdiy,
      'cdchdtDate': cdchdtDate?.millisecondsSinceEpoch,
      'cdchdtTimeBpchar': cdchdtTimeBpchar,
      'cdchid': cdchid,
      'cdchno': cdchno,
      'cdcsdtBpchar': cdcsdtBpchar?.millisecondsSinceEpoch,
      'cdcsid': cdcsid,
      'cdmand': cdmand,
      'cdremk': cdremk,
      'cdrgdtDate': cdrgdtDate?.millisecondsSinceEpoch,
      'cdrgdtTimeBpchar': cdrgdtTimeBpchar,
      'cdrgid': cdrgid,
      'cdrglv': cdrglv,
      'cdrguv': cdrguv,
      'cdtype': cdtype,
      'cdunms': cdunms,
      'cdvalu': cdvalu,
      'dpfgTssynm': dpfgTssynm,
      'typeTssycd': typeTssycd,
      'typeTssynm': typeTssynm,
      'unmsTssycd': unmsTssycd,
      'unmsTssynm': unmsTssynm,
    };
  }

  factory ChecklistDetailModel.fromMap(Map<String, dynamic> map) {
    return ChecklistDetailModel(
      cdcdds: map['cdcdds'] != null ? map['cdcdds'] as String : null,
      cdcdln: map['cdcdln'] != null ? map['cdcdln'] as int : null,
      cdcdlniy: map['cdcdlniy'] != null ? map['cdcdlniy'] as int : null,
      cdchcdiy: map['cdchcdiy'] != null ? map['cdchcdiy'] as int : null,
      cdchdtDate: map['cdchdtDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['cdchdtDate'] as int) : null,
      cdchdtTimeBpchar: map['cdchdtTimeBpchar'] != null ? map['cdchdtTimeBpchar'] as String : null,
      cdchid: map['cdchid'] != null ? map['cdchid'] as String : null,
      cdchno: map['cdchno'] != null ? map['cdchno'] as int : null,
      cdcsdtBpchar: map['cdcsdtBpchar'] != null ? DateTime.fromMillisecondsSinceEpoch(map['cdcsdtBpchar'] as int) : null,
      cdcsid: map['cdcsid'] != null ? map['cdcsid'] as String : null,
      cdmand: _toInt(map["cdmand"]),
      cdremk: map['cdremk'] != null ? map['cdremk'] as String : null,
      cdrgdtDate: map['cdrgdtDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['cdrgdtDate'] as int) : null,
      cdrgdtTimeBpchar: map['cdrgdtTimeBpchar'] != null ? map['cdrgdtTimeBpchar'] as String : null,
      cdrgid: map['cdrgid'] != null ? map['cdrgid'] as String : null,
      cdrglv: _toInt(map["cdrglv"])?.toDouble(),
      cdrguv: _toInt(map["cdrguv"])?.toDouble(),
      cdtype: map['cdtype'] != null ? map['cdtype'] as String : null,
      cdunms: map['cdunms'] != null ? map['cdunms'] as String : null,
      cdvalu: _toInt(map["cdvalu"]),
      dpfgTssynm: map['dpfgTssynm'] != null ? map['dpfgTssynm'] as String : null,
      typeTssycd: map['typeTssycd'] != null ? map['typeTssycd'] as String : null,
      typeTssynm: map['typeTssynm'] != null ? map['typeTssynm'] as String : null,
      unmsTssycd: map['unmsTssycd'] != null ? map['unmsTssycd'] as String : null,
      unmsTssynm: map['unmsTssynm'] != null ? map['unmsTssynm'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChecklistDetailModel.fromJson(String source) => ChecklistDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static int? _toInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}
