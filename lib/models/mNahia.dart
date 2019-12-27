class MNahia {
  String id;
  String name;
  String provinceId;
  String municiplaityId;
  String createdBy;
  String updatedBy;
  String ip;

  MNahia(
      {this.id,
      this.name,
      this.provinceId,
      this.municiplaityId,
      this.createdBy,
      this.updatedBy,
      this.ip});

  MNahia.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        provinceId = json['province_id'],
        municiplaityId = json['municiplaity_id'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'province_id': provinceId,
        'municiplaity_id': municiplaityId,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
