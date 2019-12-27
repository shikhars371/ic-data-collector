class MBlock {
  String id;
  String name;
  String provinceId;
  String municiplaityId;
  String nahiaId;
  String gozarId;
  String createdBy;
  String updatedBy;
  String ip;

  MBlock(
      {this.id,
      this.name,
      this.provinceId,
      this.municiplaityId,
      this.nahiaId,
      this.gozarId,
      this.createdBy,
      this.updatedBy,
      this.ip});

  MBlock.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        provinceId = json['province_id'],
        municiplaityId = json['municiplaity_id'],
        nahiaId = json['nahia_id'],
        gozarId = json['gozar_id'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'province_id': provinceId,
        'municiplaity_id': municiplaityId,
        'nahia_id': nahiaId,
        'gozar_id': gozarId,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
