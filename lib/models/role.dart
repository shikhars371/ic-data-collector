class Role {
  String id;
  String name;
  String gLinkId;
  String pLinkId;
  String activeStatus;
  String rwStatus;
  String createdBy;
  String updatedBy;
  String ip;

  Role(
      {this.id,
      this.name,
      this.gLinkId,
      this.pLinkId,
      this.activeStatus,
      this.rwStatus,
      this.createdBy,
      this.updatedBy,
      this.ip});

  Role.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        gLinkId = json['g_link_id'],
        pLinkId = json['p_link_id'],
        activeStatus = json['active_status'],
        rwStatus = json['rw_status'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'g_link_id': gLinkId,
        'p_link_id': pLinkId,
        'active_status': activeStatus,
        'rw_status': rwStatus,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
