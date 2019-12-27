class SurveyAssignment {
  String id;
  String pid;
  String provinceId;
  String municpalityId;
  String nahiaId;
  String gozarId;
  String blockId;
  String startDate;
  String completionDate;
  String completionStatus;
  String createdBy;
  String updatedBy;
  String ip;

  SurveyAssignment(
      {this.id,
      this.pid,
      this.provinceId,
      this.municpalityId,
      this.nahiaId,
      this.gozarId,
      this.blockId,
      this.startDate,
      this.completionDate,
      this.completionStatus,
      this.createdBy,
      this.updatedBy,
      this.ip});

  SurveyAssignment.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        pid = json['pid'],
        provinceId = json['province_id'],
        municpalityId = json['municpality_id'],
        nahiaId = json['nahia_id'],
        gozarId = json['gozar_id'],
        blockId = json['block_id'],
        startDate = json['start_date'],
        completionDate = json['completion_date'],
        completionStatus = json['completion_status'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'pid': pid,
        'province_id': provinceId,
        'municpality_id': municpalityId,
        'nahia_id': nahiaId,
        'gozar_id': gozarId,
        'block_id': blockId,
        'current_tax': startDate,
        'completion_date': completionDate,
        'completion_status': completionStatus,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
