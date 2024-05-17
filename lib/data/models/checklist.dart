import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ChecklistModel {
  String? chchcd;
  String? tempId;
  int? chchcdiy;
  String? chchnm;
  DateTime? cochdt;
  String? cochid;
  int? cochno;
  int? cocoln;
  ChecklistModel? data;
  int? cocolniy;
  DateTime? cocsdt;
  String? cocsid;
  int? codpfg;
  int? comctniy;
  String? coremk;
  DateTime? corgdt;
  String? corgid;
  int? corlcdiy;
  String? cousrm;
  int? cplsnoiy;
  int? cpmctniy;
  int? cpmtcdiy;
  String? mgmgcd;
  int? mgmgcdiy;
  List<ChecklistModel>? item;
  String? mgmgnm;
  String? mimicd;
  int? mimicdiy;
  String? miminm;
  String? mpmpcd;
  int? mpmpcdiy;
  String? mpmpnm;
  String? mrmrcd;
  String? mrmrnm;
  String? trlsnm;
  String? trlsno;
  String? cdcdds;
  int? cdcdln;
  int? cdcdlniy;
  int? cdchcdiy;
  int? cdmand;
  double? cdrglv;
  double? cdrguv;
  String? cdtype;
  String? cdunms;
  int? cdvalu;
  String? chcatg;
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
  DateTime? cltrdt;
  String? cmacvl;
  int? cmcdlniy;
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
  int? mgmicdiy;
  int? mgmpcdiy;
  int? mrchcdiy;
  int? mrmgcdiy;
  int? mrrlcdiy;
  DateTime? mtacdt;
  int? mtancd;
  int? mtdays;
  String? mtmtcd;
  int? mtmtcdiy;
  dynamic mtmtnm;
  ChecklistModel({
    this.chchcd,
    this.chchcdiy,
    this.chchnm,
    this.cochdt,
    this.cochid,
    this.cochno,
    this.cocoln,
    this.cocolniy,
    this.cocsdt,
    this.cocsid,
    this.codpfg,
    this.comctniy,
    this.coremk,
    this.corgdt,
    this.corgid,
    this.corlcdiy,
    this.cousrm,
    this.cplsnoiy,
    this.cpmctniy,
    this.cpmtcdiy,
    this.mgmgcd,
    this.mgmgcdiy,
    this.mgmgnm,
    this.mimicd,
    this.mimicdiy,
    this.miminm,
    this.mpmpcd,
    this.mpmpcdiy,
    this.mpmpnm,
    this.data,
    this.mrmrcd,
    this.mrmrnm,
    this.item,
    this.trlsnm,
    this.trlsno,
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
    this.mgmicdiy,
    this.mgmpcdiy,
    this.mrchcdiy,
    this.mrmgcdiy,
    this.mrrlcdiy,
    this.mtacdt,
    this.mtancd,
    this.mtdays,
    this.mtmtcd,
    this.mtmtcdiy,
    this.mtmtnm,
    this.tempId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "tempId": tempId,
      'chchcd': chchcd,
      'chchcdiy': chchcdiy,
      'chchnm': chchnm,
      'cochdt': cochdt?.millisecondsSinceEpoch,
      'cochid': cochid,
      'cochno': cochno,
      'cocoln': cocoln,
      'cocolniy': cocolniy,
      'cocsdt': cocsdt?.millisecondsSinceEpoch,
      'cocsid': cocsid,
      'codpfg': codpfg,
      'comctniy': comctniy,
      'coremk': coremk,
      'corgdt': corgdt?.millisecondsSinceEpoch,
      'corgid': corgid,
      'corlcdiy': corlcdiy,
      'cousrm': cousrm,
      'cplsnoiy': cplsnoiy,
      'cpmctniy': cpmctniy,
      'cpmtcdiy': cpmtcdiy,
      'mgmgcd': mgmgcd,
      'mgmgcdiy': mgmgcdiy,
      'mgmgnm': mgmgnm,
      'mimicd': mimicd,
      'mimicdiy': mimicdiy,
      'miminm': miminm,
      'mpmpcd': mpmpcd,
      'mpmpcdiy': mpmpcdiy,
      'mpmpnm': mpmpnm,
      'mrmrcd': mrmrcd,
      'mrmrnm': mrmrnm,
      "data": data?.toMap(),
      'trlsnm': trlsnm,
      'trlsno': trlsno,
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
      'cltrdt': cltrdt?.millisecondsSinceEpoch,
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
      'mgmicdiy': mgmicdiy,
      'mgmpcdiy': mgmpcdiy,
      'mrchcdiy': mrchcdiy,
      'mrmgcdiy': mrmgcdiy,
      'mrrlcdiy': mrrlcdiy,
      'mtacdt': mtacdt?.millisecondsSinceEpoch,
      'mtancd': mtancd,
      'mtdays': mtdays,
      'mtmtcd': mtmtcd,
      'mtmtcdiy': mtmtcdiy,
      'mtmtnm': mtmtnm,
      "item": item,
    };
  }

  factory ChecklistModel.fromMap(Map<String, dynamic> map) {
    return ChecklistModel(
        chchcd: map['chchcd'] != null ? (map['chchcd'] as String).trim() : null,
        chchcdiy: map['chchcdiy'] != null ? map['chchcdiy'] as int : null,
        chchnm: map['chchnm'] != null ? (map['chchnm'] as String).trim() : null,
        cochdt: map['cochdt'] != null ? DateTime.fromMillisecondsSinceEpoch(_toInt(map["cochdt"]) ?? 0) : null,
        cochid: map['cochid'] != null ? (map['cochid'] as String).trim() : null,
        cochno: map['cochno'] != null ? map['cochno'] as int : null,
        cocoln: map['cocoln'] != null ? map['cocoln'] as int : null,
        tempId: map["tempId"],
        cocolniy: map['cocolniy'] != null ? map['cocolniy'] as int : null,
        cocsdt: map['cocsdt'] != null ? DateTime.fromMillisecondsSinceEpoch(_toInt(map["cocsdt"]) ?? 0) : null,
        cocsid: map['cocsid'] != null ? (map['cocsid'] as String).trim() : null,
        codpfg: _toInt(map['codpfg']) ?? 0,
        comctniy: _toInt(map["comctniy"]) ?? 0,
        coremk: map['coremk'] != null ? (map['coremk'] as String).trim() : null,
        corgdt: map['corgdt'] != null ? DateTime.fromMillisecondsSinceEpoch(_toInt(map["corgdt"]) ?? 0) : null,
        corgid: map['corgid'] != null ? (map['corgid'] as String).trim() : null,
        corlcdiy: map['corlcdiy'] != null ? _toInt(map["corlcdiy"]) ?? 0 : null,
        cousrm: map['cousrm'] != null ? (map['cousrm'] as String).trim() : null,
        cplsnoiy: _toInt(map["cplsnoiy"]) ?? 0,
        cpmctniy: map['cpmctniy'] != null ? map['cpmctniy'] as int : null,
        cpmtcdiy: map['cpmtcdiy'] != null ? map['cpmtcdiy'] as int : null,
        mgmgcd: map['mgmgcd'] != null ? (map['mgmgcd'] as String).trim() : null,
        mgmgcdiy: map['mgmgcdiy'] != null ? map['mgmgcdiy'] as int : null,
        mgmgnm: map['mgmgnm'] != null ? (map['mgmgnm'] as String).trim() : null,
        mimicd: map['mimicd'] != null ? (map['mimicd'] as String).trim() : null,
        mimicdiy: map['mimicdiy'] != null ? map['mimicdiy'] as int : null,
        miminm: map['miminm'] != null ? (map['miminm'] as String).trim() : null,
        mpmpcd: map['mpmpcd'] != null ? (map['mpmpcd'] as String).trim() : null,
        mpmpcdiy: map['mpmpcdiy'] != null ? map['mpmpcdiy'] as int : null,
        mpmpnm: map['mpmpnm'] != null ? (map['mpmpnm'] as String).trim() : null,
        mrmrcd: map['mrmrcd'] != null ? (map['mrmrcd'] as String).trim() : null,
        mrmrnm: map['mrmrnm'] != null ? (map['mrmrnm'] as String).trim() : null,
        trlsnm: map['trlsnm'] != null ? (map['trlsnm'] as String).trim() : null,
        trlsno: map['trlsno'] != null ? (map['trlsno'] as String).trim() : null,
        cdcdds: map['cdcdds'] != null ? (map['cdcdds'] as String).trim() : null,
        cdcdln: map['cdcdln'] != null ? map['cdcdln'] as int : null,
        cdcdlniy: map['cdcdlniy'] != null ? map['cdcdlniy'] as int : null,
        cdchcdiy: map['cdchcdiy'] != null ? map['cdchcdiy'] as int : null,
        cdmand: _toInt(map['cdmand']),
        cdrglv: _toInt(map["cdrglv"])?.toDouble(),
        cdrguv: _toInt(map["cdrguv"])?.toDouble(),
        cdtype: map['cdtype'] != null ? (map['cdtype'] as String).trim() : null,
        cdunms: map['cdunms'] != null ? (map['cdunms'] as String).trim() : null,
        cdvalu: _toInt(map["cdvalu"]),
        chcatg: map['chcatg'] != null ? (map['chcatg'] as String).trim() : null,
        ckcknoiy: _toInt(map["ckcknoiy"]),
        ckclnoiy: _toInt(map["ckclnoiy"]),
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
        ckmgcdiy: _toInt(map["ckmgcdiy"]),
        clclno: map['clclno'] != null ? (map['clclno'] as String).trim() : null,
        clclnoiy: _toInt(map["clclnoiy"]),
        cllsnoiy: _toInt(map["cllsnoiy"]),
        clmtcdiy: _toInt(map["clmtcdiy"]),
        clshft: _toInt(map["clshft"]),
        clstat: map['clstat'] != null ? (map['clstat'] as String).trim() : null,
        clstsm: map['clstsm'] != null ? (map['clstsm'] as String).trim() : null,
        cltrdt: map['cltrdt'] != null ? DateTime.fromMillisecondsSinceEpoch(_toInt(map["cltrdt"]) ?? 0) : null,
        cmacvl: map['cmacvl'] != null ? (map['cmacvl'] as String).trim() : null,
        cmcdlniy: _toInt(map["cmcdlniy"]),
        cmchcdiy: _toInt(map["cmchcdiy"]),
        cmcknoiy: _toInt(map["cmcknoiy"]),
        cmcmlniy: map["cmcmlniy"],
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
        cmrlcdiy: _toInt(map["cmrlcdiy"]),
        mgmicdiy: _toInt(map["mgmicdiy"]),
        mgmpcdiy: _toInt(map["mgmpcdiy"]),
        mrchcdiy: _toInt(map["mrchcdiy"]),
        mrmgcdiy: _toInt(map["mrmgcdiy"]),
        mrrlcdiy: _toInt(map["mrrlcdiy"]) ?? 0,
        mtacdt: map['mtacdt'] != null ? DateTime.fromMillisecondsSinceEpoch(_toInt(map["mtacdt"]) ?? 0) : null,
        mtancd: _toInt(map["mtancd"]),
        mtdays: _toInt(map["mtdays"]),
        mtmtcd: map['mtmtcd'] != null ? (map['mtmtcd'] as String).trim() : null,
        mtmtcdiy: _toInt(map["mtmtcdiy"]),
        mtmtnm: map['mtmtnm'] != null ? (map['mtmtnm'] as String).trim() : null,
        item: map["item"]?.map((e) => ChecklistModel.fromMap(e)));
  }

  String toJson() => json.encode(toMap());

  factory ChecklistModel.fromJson(String source) => ChecklistModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static int? _toInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  ChecklistModel copyWith({
    String? chchcd,
    String? tempId,
    int? chchcdiy,
    String? chchnm,
    DateTime? cochdt,
    String? cochid,
    int? cochno,
    int? cocoln,
    int? cocolniy,
    DateTime? cocsdt,
    String? cocsid,
    int? codpfg,
    int? comctniy,
    String? coremk,
    DateTime? corgdt,
    String? corgid,
    int? corlcdiy,
    String? cousrm,
    int? cplsnoiy,
    int? cpmctniy,
    int? cpmtcdiy,
    String? mgmgcd,
    int? mgmgcdiy,
    List<ChecklistModel>? item,
    String? mgmgnm,
    String? mimicd,
    int? mimicdiy,
    String? miminm,
    String? mpmpcd,
    int? mpmpcdiy,
    String? mpmpnm,
    String? mrmrcd,
    String? mrmrnm,
    String? trlsnm,
    String? trlsno,
    String? cdcdds,
    int? cdcdln,
    int? cdcdlniy,
    int? cdchcdiy,
    int? cdmand,
    double? cdrglv,
    double? cdrguv,
    String? cdtype,
    String? cdunms,
    int? cdvalu,
    String? chcatg,
    int? ckcknoiy,
    int? ckclnoiy,
    String? ckflk1,
    String? ckflk2,
    String? ckflk3,
    String? ckflk4,
    String? ckflk5,
    String? ckfln1,
    String? ckfln2,
    String? ckfln3,
    String? ckfln4,
    String? ckfln5,
    int? ckmgcdiy,
    String? clclno,
    int? clclnoiy,
    int? cllsnoiy,
    int? clmtcdiy,
    int? clshft,
    String? clstat,
    String? clstsm,
    DateTime? cltrdt,
    String? cmacvl,
    int? cmcdlniy,
    int? cmchcdiy,
    int? cmcknoiy,
    int? cmcmlniy,
    String? cmflk1,
    String? cmflk2,
    String? cmflk3,
    String? cmflk4,
    String? cmflk5,
    String? cmfln1,
    String? cmfln2,
    String? cmfln3,
    String? cmfln4,
    String? cmfln5,
    int? cmrlcdiy,
    int? mgmicdiy,
    int? mgmpcdiy,
    int? mrchcdiy,
    int? mrmgcdiy,
    int? mrrlcdiy,
    DateTime? mtacdt,
    int? mtancd,
    int? mtdays,
    String? mtmtcd,
    int? mtmtcdiy,
    dynamic mtmtnm,
  }) {
    return ChecklistModel(
      chchcd: chchcd ?? this.chchcd,
      tempId: tempId ?? this.tempId,
      chchcdiy: chchcdiy ?? this.chchcdiy,
      chchnm: chchnm ?? this.chchnm,
      cochdt: cochdt ?? this.cochdt,
      cochid: cochid ?? this.cochid,
      cochno: cochno ?? this.cochno,
      cocoln: cocoln ?? this.cocoln,
      cocolniy: cocolniy ?? this.cocolniy,
      cocsdt: cocsdt ?? this.cocsdt,
      cocsid: cocsid ?? this.cocsid,
      codpfg: codpfg ?? this.codpfg,
      comctniy: comctniy ?? this.comctniy,
      coremk: coremk ?? this.coremk,
      corgdt: corgdt ?? this.corgdt,
      corgid: corgid ?? this.corgid,
      corlcdiy: corlcdiy ?? this.corlcdiy,
      cousrm: cousrm ?? this.cousrm,
      cplsnoiy: cplsnoiy ?? this.cplsnoiy,
      cpmctniy: cpmctniy ?? this.cpmctniy,
      cpmtcdiy: cpmtcdiy ?? this.cpmtcdiy,
      mgmgcd: mgmgcd ?? this.mgmgcd,
      mgmgcdiy: mgmgcdiy ?? this.mgmgcdiy,
      item: item ?? this.item,
      mgmgnm: mgmgnm ?? this.mgmgnm,
      mimicd: mimicd ?? this.mimicd,
      mimicdiy: mimicdiy ?? this.mimicdiy,
      miminm: miminm ?? this.miminm,
      mpmpcd: mpmpcd ?? this.mpmpcd,
      mpmpcdiy: mpmpcdiy ?? this.mpmpcdiy,
      mpmpnm: mpmpnm ?? this.mpmpnm,
      mrmrcd: mrmrcd ?? this.mrmrcd,
      mrmrnm: mrmrnm ?? this.mrmrnm,
      trlsnm: trlsnm ?? this.trlsnm,
      trlsno: trlsno ?? this.trlsno,
      cdcdds: cdcdds ?? this.cdcdds,
      cdcdln: cdcdln ?? this.cdcdln,
      cdcdlniy: cdcdlniy ?? this.cdcdlniy,
      cdchcdiy: cdchcdiy ?? this.cdchcdiy,
      cdmand: cdmand ?? this.cdmand,
      cdrglv: cdrglv ?? this.cdrglv,
      cdrguv: cdrguv ?? this.cdrguv,
      cdtype: cdtype ?? this.cdtype,
      cdunms: cdunms ?? this.cdunms,
      cdvalu: cdvalu ?? this.cdvalu,
      chcatg: chcatg ?? this.chcatg,
      ckcknoiy: ckcknoiy ?? this.ckcknoiy,
      ckclnoiy: ckclnoiy ?? this.ckclnoiy,
      ckflk1: ckflk1 ?? this.ckflk1,
      ckflk2: ckflk2 ?? this.ckflk2,
      ckflk3: ckflk3 ?? this.ckflk3,
      ckflk4: ckflk4 ?? this.ckflk4,
      ckflk5: ckflk5 ?? this.ckflk5,
      ckfln1: ckfln1 ?? this.ckfln1,
      ckfln2: ckfln2 ?? this.ckfln2,
      ckfln3: ckfln3 ?? this.ckfln3,
      ckfln4: ckfln4 ?? this.ckfln4,
      ckfln5: ckfln5 ?? this.ckfln5,
      ckmgcdiy: ckmgcdiy ?? this.ckmgcdiy,
      clclno: clclno ?? this.clclno,
      clclnoiy: clclnoiy ?? this.clclnoiy,
      cllsnoiy: cllsnoiy ?? this.cllsnoiy,
      clmtcdiy: clmtcdiy ?? this.clmtcdiy,
      clshft: clshft ?? this.clshft,
      clstat: clstat ?? this.clstat,
      clstsm: clstsm ?? this.clstsm,
      cltrdt: cltrdt ?? this.cltrdt,
      cmacvl: cmacvl ?? this.cmacvl,
      cmcdlniy: cmcdlniy ?? this.cmcdlniy,
      cmchcdiy: cmchcdiy ?? this.cmchcdiy,
      cmcknoiy: cmcknoiy ?? this.cmcknoiy,
      cmcmlniy: cmcmlniy ?? this.cmcmlniy,
      cmflk1: cmflk1 ?? this.cmflk1,
      cmflk2: cmflk2 ?? this.cmflk2,
      cmflk3: cmflk3 ?? this.cmflk3,
      cmflk4: cmflk4 ?? this.cmflk4,
      cmflk5: cmflk5 ?? this.cmflk5,
      cmfln1: cmfln1 ?? this.cmfln1,
      cmfln2: cmfln2 ?? this.cmfln2,
      cmfln3: cmfln3 ?? this.cmfln3,
      cmfln4: cmfln4 ?? this.cmfln4,
      cmfln5: cmfln5 ?? this.cmfln5,
      cmrlcdiy: cmrlcdiy ?? this.cmrlcdiy,
      mgmicdiy: mgmicdiy ?? this.mgmicdiy,
      mgmpcdiy: mgmpcdiy ?? this.mgmpcdiy,
      mrchcdiy: mrchcdiy ?? this.mrchcdiy,
      mrmgcdiy: mrmgcdiy ?? this.mrmgcdiy,
      mrrlcdiy: mrrlcdiy ?? this.mrrlcdiy,
      mtacdt: mtacdt ?? this.mtacdt,
      mtancd: mtancd ?? this.mtancd,
      mtdays: mtdays ?? this.mtdays,
      mtmtcd: mtmtcd ?? this.mtmtcd,
      mtmtcdiy: mtmtcdiy ?? this.mtmtcdiy,
      mtmtnm: mtmtnm ?? this.mtmtnm,
    );
  }
}
