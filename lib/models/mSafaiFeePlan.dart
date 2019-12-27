class MSafaiFeePlan {
  String id;
  String landType;
  String startDate;
  String endDate;
  String price;
  String priceUnit;
  String createdBy;
  String updatedBy;
  String ip;

  MSafaiFeePlan(
      {this.id,
      this.landType,
      this.startDate,
      this.endDate,
      this.price,
      this.priceUnit,
      this.createdBy,
      this.updatedBy,
      this.ip});

  MSafaiFeePlan.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        landType = json['land_type'],
        startDate = json['start_date'],
        endDate = json['end_date'],
        price = json['price'],
        priceUnit = json['price_unit'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'land_type': landType,
        'start_date': startDate,
        'end_date': endDate,
        'price': price,
        'price_unit': priceUnit,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
