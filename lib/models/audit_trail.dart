class AuditTrail {
  String id;
  String uid;
  String changeDetails;
  String changeType;
  String tableName;
  String fieldName;
  String changeDate;
  String timeStamp;
  String createdBy;
  String updatedBy;
  String ip;
  AuditTrail(
      {this.id,
      this.uid,
      this.changeDetails,
      this.changeType,
      this.tableName,
      this.fieldName,
      this.changeDate,
      this.timeStamp,
      this.createdBy,
      this.updatedBy,
      this.ip});

  AuditTrail.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        uid = json['uid'],
        changeDetails = json['change_details'],
        changeType = json['change_type'],
        tableName = json['table_name'],
        fieldName = json['field_name'],
        changeDate = json['change_date'],
        timeStamp = json['time_stamp'],
        createdBy = json['created_by'],
        updatedBy = json['updated_by'],
        ip = json['ip'];
  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'change_details': changeDetails,
        'change_type': changeType,
        'table_name': tableName,
        'field_name': fieldName,
        'change_date': changeDate,
        'time_stamp': timeStamp,
        'created_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
