class OcDistributionStatus {
  String id;
  String pid;
  String ownerStatus;
  String ownerDistributionDate;
  String muncipalOfficeStatus;
  String ocDiroctorates;
  String mudlStatus;
  String mudlDate;
  String muncipalOfficeDate;
  String createdBy;
  String updatedBy;
  String ip;

  OcDistributionStatus(
      {this.id,
      this.pid,
      this.ownerStatus,
      this.ownerDistributionDate,
      this.muncipalOfficeStatus,
      this.ocDiroctorates,
      this.mudlStatus,
      this.mudlDate,
      this.muncipalOfficeDate,
      this.createdBy,
      this.updatedBy,
      this.ip});

  OcDistributionStatus.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        pid = json['pid'],
        ownerStatus = json['owner_status'],
        ownerDistributionDate = json['owner_distribution_date'],
        muncipalOfficeStatus = json['muncipal_office_status'],
        ocDiroctorates = json['oc_diroctorates'],
        mudlStatus = json['MUDL_status'],
        mudlDate = json['MUDL_date'],
        muncipalOfficeDate = json['muncipal_office_date'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'pid': pid,
        'owner_status': ownerStatus,
        'owner_distribution_date': ownerDistributionDate,
        'muncipal_office_status': muncipalOfficeStatus,
        'oc_diroctorates': ocDiroctorates,
        'MUDL_status': mudlStatus,
        'MUDL_date': mudlDate,
        'muncipal_office_date': muncipalOfficeDate,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
