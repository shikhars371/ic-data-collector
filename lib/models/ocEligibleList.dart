class OcEligibleList {
  String id;
  String pid;
  String bifStatus;
  String payStatus;
  String ocEligiblityStatus;
  String createdBy;
  String updatedBy;
  String ip;

  OcEligibleList(
      {this.id,
      this.pid,
      this.bifStatus,
      this.payStatus,
      this.ocEligiblityStatus,
      this.createdBy,
      this.updatedBy,
      this.ip});

  OcEligibleList.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        pid = json['pid'],
        bifStatus = json['bif_status'],
        payStatus = json['pay_status'],
        ocEligiblityStatus = json['oc_eligiblity_status'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'pid': pid,
        'bif_status': bifStatus,
        'pay_status': payStatus,
        'oc_eligiblity_status': ocEligiblityStatus,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
