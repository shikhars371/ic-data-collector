class MFineMaster {
  String id;
  String startDay;
  String endDay;
  String fineAmount;
  String startDate;
  String endDate;
  String createdBy;
  String updatedBy;
  String ip;

  MFineMaster(
      {this.id,
      this.startDay,
      this.endDay,
      this.fineAmount,
      this.startDate,
      this.endDate,
      this.createdBy,
      this.updatedBy,
      this.ip});

  MFineMaster.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        startDay = json['start_day'],
        endDay = json['end_day'],
        fineAmount = json['fine_amount'],
        startDate = json['start_date'],
        endDate = json['end_date'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'start_day': startDay,
        'end_day': endDay,
        'fine_amount': fineAmount,
        'start_date': startDate,
        'end_date': endDate,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
