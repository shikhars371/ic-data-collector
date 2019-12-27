class OcDespatchStatus {
  String id;
  String uid;
  String printStatus;
  String despatchNo;
  String despatchDate;
  String createdBy;
  String updatedBy;
  String ip;

  OcDespatchStatus(
      {this.id,
      this.uid,
      this.printStatus,
      this.despatchNo,
      this.despatchDate,
      this.createdBy,
      this.updatedBy,
      this.ip});

  OcDespatchStatus.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        uid = json['uid'],
        printStatus = json['print_status'],
        despatchNo = json['despatch_no'],
        despatchDate = json['despatch_date'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'print_status': printStatus,
        'despatch_no': despatchNo,
        'despatch_date': despatchDate,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
