class SurveyAssignment {
  String id;
  String uid;
  String assignedBy;
  String assignedTo;
  String provinceId;
  String municpalityId;
  String nahiaId;
  String gozarId;
  String blockId;
  String startDate;
  int propertyToSurvey;
  int propertySurveyed;
  int propertyVerified;
  int propertyGeoverified;
  String completionDate;
  bool completionStatus;
  int approveStatus;
  String createdBy;
  String updatedBy;
  String ip;
  int isdeleted;
  int issynced;
  int iscompleted;
  int isstatrted;

  SurveyAssignment(
      {this.id,
      this.uid,
      this.assignedBy,
      this.assignedTo,
      this.provinceId,
      this.municpalityId,
      this.nahiaId,
      this.gozarId,
      this.blockId,
      this.startDate,
      this.propertyToSurvey,
      this.propertySurveyed,
      this.propertyVerified,
      this.propertyGeoverified,
      this.completionDate,
      this.completionStatus,
      this.approveStatus,
      this.createdBy,
      this.updatedBy,
      this.ip,
      this.isdeleted,
      this.issynced,
      this.iscompleted,
      this.isstatrted});

  SurveyAssignment.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        uid = json['uid'],
        assignedBy = json['assigned_by'],
        assignedTo = json['assigned_to'],
        provinceId = json['province_id'],
        municpalityId = json['municpality_id'],
        nahiaId = json['nahia_id'],
        gozarId = json['gozar_id'],
        blockId = json['block_id'],
        startDate = json['start_date'],
        propertyToSurvey = json['property_to_survey'],
        propertySurveyed = json['property_surveyed'],
        propertyVerified = json['property_verified'],
        propertyGeoverified = json['property_geoverified'],
        completionDate = json['completion_date'],
        completionStatus = json['completion_status'],
        approveStatus = json['approve_status'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'assigned_by': assignedBy,
        'assigned_to': assignedTo,
        'province_id': provinceId,
        'municpality_id': municpalityId,
        'nahia_id': nahiaId,
        'gozar_id': gozarId,
        'block_id': blockId,
        'current_tax': startDate,
        'property_to_survey': propertyToSurvey,
        'property_surveyed': propertySurveyed,
        'property_verified': propertyVerified,
        'property_geoverified': propertyGeoverified,
        'completion_date': completionDate,
        'completion_status': completionStatus,
        'approve_status': approveStatus,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
