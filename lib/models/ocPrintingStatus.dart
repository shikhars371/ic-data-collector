class OcPrintingStatus {
  String id;
  String pid;
  String printingApprovalStatus;
  String printStatus;
  String printDate;
  String createdBy;
  String updatedBy;
  String ip;

  OcPrintingStatus(
      {this.id,
      this.pid,
      this.printingApprovalStatus,
      this.printStatus,
      this.printDate,
      this.createdBy,
      this.updatedBy,
      this.ip});

  OcPrintingStatus.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        pid = json['pid'],
        printingApprovalStatus = json['printing_approval_status'],
        printStatus = json['print_status'],
        printDate = json['print_date'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'pid': pid,
        'printing_approval_status': printingApprovalStatus,
        'print_status': printStatus,
        'print_date': printDate,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
