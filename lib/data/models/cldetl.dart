// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CldetlModel {
  String? cdcdds;
  String? cdcdln;
  String? cdcdlniy;
  String? cdchcdiy;
  String? cdmand;
  String? cdrglv;
  String? cdrguv;
  String? cdtype;
  String? cdunms;
  String? cdvalu;
  String? chcatg;
  String? chchcd;
  int? chchcdiy;
  String? chchnm;
  int? ckcknoiy;
  int? ckclnoiy;
  String? ckflk1;
  String? ckflk2;
  String? ckflk3;
  String? ckflk4;
  String? ckflk5;
  String? ckfln1;
  String? ckfln2;
  String? ckfln3;
  String? ckfln4;
  String? ckfln5;
  int? ckmgcdiy;
  String? clclno;
  int? clclnoiy;
  int? cllsnoiy;
  int? clmtcdiy;
  int? clshft;
  String? clstat;
  String? clstsm;
  String? cltrdt;
  String? cmacvl;
  String? cmcdlniy;
  int? cmchcdiy;
  int? cmcknoiy;
  int? cmcmlniy;
  String? cmflk1;
  String? cmflk2;
  String? cmflk3;
  String? cmflk4;
  String? cmflk5;
  String? cmfln1;
  String? cmfln2;
  String? cmfln3;
  String? cmfln4;
  String? cmfln5;
  int? cmrlcdiy;
  String? mgmgcd;
  int? mgmgcdiy;
  String? mgmgnm;
  int? mgmicdiy;
  int? mgmpcdiy;
  String? mimicd;
  int? mimicdiy;
  String? miminm;
  String? mpmpcd;
  int? mpmpcdiy;
  String? mpmpnm;
  int? mrchcdiy;
  int? mrmgcdiy;
  String? mrmrcd;
  String? mrmrnm;
  int? mrrlcdiy;
  String? mtacdt;
  int? mtancd;
  int? mtdays;
  String? mtmtcd;
  int? mtmtcdiy;
  String? mtmtnm;
  String? trlsno;
  String? cmremk;
  CldetlModel({
    this.cdcdds,
    this.cdcdln,
    this.cdcdlniy,
    this.cdchcdiy,
    this.cdmand,
    this.cdrglv,
    this.cdrguv,
    this.cdtype,
    this.cdunms,
    this.cdvalu,
    this.chcatg,
    this.chchcd,
    this.chchcdiy,
    this.chchnm,
    this.ckcknoiy,
    this.ckclnoiy,
    this.ckflk1,
    this.ckflk2,
    this.ckflk3,
    this.ckflk4,
    this.ckflk5,
    this.ckfln1,
    this.ckfln2,
    this.ckfln3,
    this.ckfln4,
    this.ckfln5,
    this.ckmgcdiy,
    this.clclno,
    this.clclnoiy,
    this.cllsnoiy,
    this.clmtcdiy,
    this.clshft,
    this.clstat,
    this.clstsm,
    this.cltrdt,
    this.cmacvl,
    this.cmcdlniy,
    this.cmchcdiy,
    this.cmcknoiy,
    this.cmcmlniy,
    this.cmflk1,
    this.cmflk2,
    this.cmflk3,
    this.cmflk4,
    this.cmflk5,
    this.cmfln1,
    this.cmfln2,
    this.cmfln3,
    this.cmfln4,
    this.cmfln5,
    this.cmrlcdiy,
    this.mgmgcd,
    this.mgmgcdiy,
    this.mgmgnm,
    this.mgmicdiy,
    this.mgmpcdiy,
    this.mimicd,
    this.mimicdiy,
    this.miminm,
    this.mpmpcd,
    this.mpmpcdiy,
    this.mpmpnm,
    this.mrchcdiy,
    this.mrmgcdiy,
    this.mrmrcd,
    this.mrmrnm,
    this.mrrlcdiy,
    this.mtacdt,
    this.mtancd,
    this.mtdays,
    this.mtmtcd,
    this.mtmtcdiy,
    this.mtmtnm,
    this.trlsno,
    this.cmremk,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cdcdds': cdcdds,
      'cdcdln': cdcdln,
      'cdcdlniy': cdcdlniy,
      'cdchcdiy': cdchcdiy,
      'cdmand': cdmand,
      'cdrglv': cdrglv,
      'cdrguv': cdrguv,
      'cdtype': cdtype,
      'cdunms': cdunms,
      'cdvalu': cdvalu,
      'chcatg': chcatg,
      'chchcd': chchcd,
      'chchcdiy': chchcdiy,
      'chchnm': chchnm,
      'ckcknoiy': ckcknoiy,
      'ckclnoiy': ckclnoiy,
      'ckflk1': ckflk1,
      'ckflk2': ckflk2,
      'ckflk3': ckflk3,
      'ckflk4': ckflk4,
      'ckflk5': ckflk5,
      'ckfln1': ckfln1,
      'ckfln2': ckfln2,
      'ckfln3': ckfln3,
      'ckfln4': ckfln4,
      'ckfln5': ckfln5,
      'ckmgcdiy': ckmgcdiy,
      'clclno': clclno,
      'clclnoiy': clclnoiy,
      'cllsnoiy': cllsnoiy,
      'clmtcdiy': clmtcdiy,
      'clshft': clshft,
      'clstat': clstat,
      'clstsm': clstsm,
      'cltrdt': cltrdt,
      'cmacvl': cmacvl,
      'cmcdlniy': cmcdlniy,
      'cmchcdiy': cmchcdiy,
      'cmcknoiy': cmcknoiy,
      'cmcmlniy': cmcmlniy,
      'cmflk1': cmflk1,
      'cmflk2': cmflk2,
      'cmflk3': cmflk3,
      'cmflk4': cmflk4,
      'cmflk5': cmflk5,
      'cmfln1': cmfln1,
      'cmfln2': cmfln2,
      'cmfln3': cmfln3,
      'cmfln4': cmfln4,
      'cmfln5': cmfln5,
      'cmrlcdiy': cmrlcdiy,
      'mgmgcd': mgmgcd,
      'mgmgcdiy': mgmgcdiy,
      'mgmgnm': mgmgnm,
      'mgmicdiy': mgmicdiy,
      'mgmpcdiy': mgmpcdiy,
      'mimicd': mimicd,
      'mimicdiy': mimicdiy,
      'miminm': miminm,
      'mpmpcd': mpmpcd,
      'mpmpcdiy': mpmpcdiy,
      'mpmpnm': mpmpnm,
      'mrchcdiy': mrchcdiy,
      'mrmgcdiy': mrmgcdiy,
      'mrmrcd': mrmrcd,
      'mrmrnm': mrmrnm,
      'mrrlcdiy': mrrlcdiy,
      'mtacdt': mtacdt,
      'mtancd': mtancd,
      'mtdays': mtdays,
      'mtmtcd': mtmtcd,
      'mtmtcdiy': mtmtcdiy,
      'mtmtnm': mtmtnm,
      'trlsno': trlsno,
      'cmremk': cmremk,
    };
  }

  factory CldetlModel.fromMap(Map<String, dynamic> map) {
    return CldetlModel(
      cdcdds: map['cdcdds'] != null ? (map['cdcdds'] as String).trim() : null,
      cdcdln: intToString(map['cdcdln']),
      cdcdlniy: intToString(map['cdcdlniy']),
      cdchcdiy: intToString(map['cdchcdiy']),
      cdmand: map['cdmand'] != null ? (map['cdmand'] as String).trim() : null,
      cdrglv: intToString(map['cdrglv']),
      cdrguv: intToString(map['cdrguv']),
      cdtype: map['cdtype'] != null ? (map['cdtype'] as String).trim() : null,
      cdunms: map['cdunms'] != null ? (map['cdunms'] as String).trim() : null,
      cdvalu: map['cdvalu'] != null ? (map['cdvalu'] as String).trim() : null,
      chcatg: map['chcatg'] != null ? (map['chcatg'] as String).trim() : null,
      chchcd: map['chchcd'] != null ? (map['chchcd'] as String).trim() : null,
      chchcdiy: stringToInt(map['chchcdiy']),
      chchnm: map['chchnm'] != null ? (map['chchnm'] as String).trim() : null,
      ckcknoiy: stringToInt(map['ckcknoiy']),
      ckclnoiy: stringToInt(map['ckclnoiy']),
      ckflk1: map['ckflk1'] != null ? (map['ckflk1'] as String).trim() : null,
      ckflk2: map['ckflk2'] != null ? (map['ckflk2'] as String).trim() : null,
      ckflk3: map['ckflk3'] != null ? (map['ckflk3'] as String).trim() : null,
      ckflk4: map['ckflk4'] != null ? (map['ckflk4'] as String).trim() : null,
      ckflk5: map['ckflk5'] != null ? (map['ckflk5'] as String).trim() : null,
      ckfln1: map['ckfln1'] != null ? (map['ckfln1'] as String).trim() : null,
      ckfln2: map['ckfln2'] != null ? (map['ckfln2'] as String).trim() : null,
      ckfln3: map['ckfln3'] != null ? (map['ckfln3'] as String).trim() : null,
      ckfln4: map['ckfln4'] != null ? (map['ckfln4'] as String).trim() : null,
      ckfln5: map['ckfln5'] != null ? (map['ckfln5'] as String).trim() : null,
      ckmgcdiy: stringToInt(map['ckmgcdiy']),
      clclno: map['clclno'] != null ? (map['clclno'] as String).trim() : null,
      clclnoiy: stringToInt(map['clclnoiy']),
      cllsnoiy: stringToInt(map['cllsnoiy']),
      clmtcdiy: map['clmtcdiy'] != null ? map['clmtcdiy'] as int : null,
      clshft: map['clshft'] != null
          ? map['clshft'] is String
              ? int.tryParse(map['clshft'].toString()) ?? 0
              : map['clshft'] as int
          : null,
      clstat: map['clstat'] != null ? (map['clstat'] as String).trim() : null,
      clstsm: map['clstsm'] != null ? (map['clstsm'] as String).trim() : null,
      cltrdt: map['cltrdt'] != null ? (map['cltrdt'] as String).trim() : null,
      cmacvl: map['cmacvl'] != null ? (map['cmacvl'] as String).trim() : null,
      cmcdlniy: intToString(map["cmcdlniy"]),
      cmchcdiy: map['cmchcdiy'] != null ? map['cmchcdiy'] as int : null,
      cmcknoiy: map['cmcknoiy'] != null ? map['cmcknoiy'] as int : null,
      cmcmlniy: map['cmcmlniy'] != null ? map['cmcmlniy'] as int : null,
      cmflk1: map['cmflk1'] != null ? (map['cmflk1'] as String).trim() : null,
      cmflk2: map['cmflk2'] != null ? (map['cmflk2'] as String).trim() : null,
      cmflk3: map['cmflk3'] != null ? (map['cmflk3'] as String).trim() : null,
      cmflk4: map['cmflk4'] != null ? (map['cmflk4'] as String).trim() : null,
      cmflk5: map['cmflk5'] != null ? (map['cmflk5'] as String).trim() : null,
      cmfln1: map['cmfln1'] != null ? (map['cmfln1'] as String).trim() : null,
      cmfln2: map['cmfln2'] != null ? (map['cmfln2'] as String).trim() : null,
      cmfln3: map['cmfln3'] != null ? (map['cmfln3'] as String).trim() : null,
      cmfln4: map['cmfln4'] != null ? (map['cmfln4'] as String).trim() : null,
      cmfln5: map['cmfln5'] != null ? (map['cmfln5'] as String).trim() : null,
      cmrlcdiy: map['cmrlcdiy'] != null ? map['cmrlcdiy'] as int : null,
      mgmgcd: map['mgmgcd'] != null ? (map['mgmgcd'] as String).trim() : null,
      mgmgcdiy: map['mgmgcdiy'] != null ? map['mgmgcdiy'] as int : null,
      mgmgnm: map['mgmgnm'] != null ? (map['mgmgnm'] as String).trim() : null,
      mgmicdiy: map['mgmicdiy'] != null ? map['mgmicdiy'] as int : null,
      mgmpcdiy: map['mgmpcdiy'] != null ? map['mgmpcdiy'] as int : null,
      mimicd: map['mimicd'] != null ? (map['mimicd'] as String).trim() : null,
      mimicdiy: map['mimicdiy'] != null ? map['mimicdiy'] as int : null,
      miminm: map['miminm'] != null ? (map['miminm'] as String).trim() : null,
      mpmpcd: map['mpmpcd'] != null ? (map['mpmpcd'] as String).trim() : null,
      mpmpcdiy: map['mpmpcdiy'] != null ? map['mpmpcdiy'] as int : null,
      mpmpnm: map['mpmpnm'] != null ? (map['mpmpnm'] as String).trim() : null,
      mrchcdiy: map['mrchcdiy'] != null ? map['mrchcdiy'] as int : null,
      mrmgcdiy: map['mrmgcdiy'] != null ? map['mrmgcdiy'] as int : null,
      mrmrcd: map['mrmrcd'] != null ? (map['mrmrcd'] as String).trim() : null,
      mrmrnm: map['mrmrnm'] != null ? (map['mrmrnm'] as String).trim() : null,
      mrrlcdiy: map['mrrlcdiy'] != null ? map['mrrlcdiy'] as int : null,
      mtacdt: map['mtacdt'] != null ? (map['mtacdt'] as String).trim() : null,
      mtancd: map['mtancd'] != null
          ? map['mtancd'] is String
              ? int.tryParse(map['mtancd'].toString()) ?? 0
              : map['mtancd'] as int
          : null,
      mtdays: map['mtdays'] != null
          ? map['mtdays'] is String
              ? int.tryParse(map['mtdays'].toString()) ?? 0
              : map['mtdays'] as int
          : null,
      mtmtcd: map['mtmtcd'] != null ? (map['mtmtcd'] as String).trim() : null,
      mtmtcdiy: map['mtmtcdiy'] != null ? map['mtmtcdiy'] as int : null,
      mtmtnm: map['mtmtnm'] != null ? (map['mtmtnm'] as String).trim() : null,
      trlsno: map['trlsno'] != null ? (map['trlsno'] as String).trim() : null,
      cmremk: map['cmremk'] != null ? (map['cmremk'] as String).trim() : null,
    );
  }

  static String? intToString(dynamic value) {
    if (value != null) {
      if (value is int) {
        return value.toString();
      } else if (value is String) {
        return value;
      }
    }
    return null;
  }

  static int? stringToInt(dynamic value) {
    if (value != null) {
      if (value is String) {
        return int.tryParse(value);
      } else if (value is int) {
        return value;
      }
    }
    return null;
  }

  String toJson() => json.encode(toMap());

  factory CldetlModel.fromJson(String source) =>
      CldetlModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
