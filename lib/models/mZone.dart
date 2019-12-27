class MZone {
  String id;
  String name;
  String unitPrice;
  String unitType;
  String stDate;
  String enDate;
  String createdBy;
  String updatedBy;
  String ip;

  MZone(
      {this.id,
      this.name,
      this.unitPrice,
      this.unitType,
      this.stDate,
      this.enDate,
      this.createdBy,
      this.updatedBy,
      this.ip});

  MZone.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        unitPrice = json['unit_price'],
        unitType = json['unit_type'],
        stDate = json['st_date'],
        enDate = json['en_date'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'unit_price': unitPrice,
        'unit_type': unitType,
        'st_date': stDate,
        'en_date': enDate,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
