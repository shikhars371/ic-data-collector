class MOcPaperPrice {
  String id;
  String price;
  String stDate;
  String enDate;
  String status;
  String createdBy;
  String updatedBy;
  String ip;

  MOcPaperPrice(
      {this.id,
      this.price,
      this.stDate,
      this.enDate,
      this.status,
      this.createdBy,
      this.updatedBy,
      this.ip});

  MOcPaperPrice.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        price = json['price'],
        stDate = json['st_date'],
        enDate = json['en_date'],
        status = json['status'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'price': price,
        'st_date': stDate,
        'en_date': enDate,
        'status': status,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
