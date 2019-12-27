class MStructurePricePlan {
  String id;
  String structureType;
  String startDate;
  String endDate;
  String price;
  String priceUnit;
  String createdBy;
  String updatedBy;
  String ip;

  MStructurePricePlan(
      {this.id,
      this.structureType,
      this.startDate,
      this.endDate,
      this.price,
      this.priceUnit,
      this.createdBy,
      this.updatedBy,
      this.ip});

  MStructurePricePlan.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        structureType = json['structure_type'],
        startDate = json['start_date'],
        endDate = json['end_date'],
        price = json['price'],
        priceUnit = json['price_unit'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'structure_type': structureType,
        'start_date': startDate,
        'end_date': endDate,
        'price': price,
        'price_unit': priceUnit,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
