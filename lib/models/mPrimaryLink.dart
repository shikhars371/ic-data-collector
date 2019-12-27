class MPrimaryLink {
  String id;
  String name;
  String link;
  String status;
  String gLinkId;
  String createdBy;
  String updatedBy;
  String ip;

  MPrimaryLink(
      {this.id,
      this.name,
      this.link,
      this.status,
      this.gLinkId,
      this.createdBy,
      this.updatedBy,
      this.ip});

  MPrimaryLink.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        link = json['link'],
        status = json['status'],
        gLinkId = json['g_link_id'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'link': link,
        'status': status,
        'g_link_id': gLinkId,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
