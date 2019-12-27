class BifStatus {
  String id;
  String pid;
  String status;
  String createdBy;
  String updatedBy;
  String ip;

  BifStatus(
      {this.id,
      this.pid,
      this.status,
      this.createdBy,
      this.updatedBy,
      this.ip});

  BifStatus.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        pid = json['pid'],
        status = json['status'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'pid': pid,
        'status': status,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
