class MGlobalLink {
  String id;
  String name;
  String link;
  String status;
  String createdBy;
  String updatedBy;
  String ip;

  MGlobalLink(
      {this.id,
      this.name,
      this.link,
      this.status,
      this.createdBy,
      this.updatedBy,
      this.ip});

  MGlobalLink.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        link = json['link'],
        status = json['status'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'link': link,
        'status': status,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
