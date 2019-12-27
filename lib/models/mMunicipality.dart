class MMunicipality {
  String id;
  String name;
  String provinceId;
  String createdBy;
  String updatedBy;
  String ip;

  MMunicipality(
      {this.id,
      this.name,
      this.provinceId,
      this.createdBy,
      this.updatedBy,
      this.ip});

  MMunicipality.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        provinceId = json['province_id'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'province_id': provinceId,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
