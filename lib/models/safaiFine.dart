class SafaiFine {
  String id;
  String pid;
  String date;
  String fineAmount;
  String createdBy;
  String updatedBy;
  String ip;
  SafaiFine(
      {this.id,
      this.pid,
      this.date,
      this.fineAmount,
      this.createdBy,
      this.updatedBy,
      this.ip
      });

  SafaiFine.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        pid = json['pid'],
        date = json['date'],
        fineAmount = json['fine_amount'],
        createdBy = json['created_by'],
        updatedBy = json['updated_by'],
        ip = json['ip'];
  Map<String, dynamic> toJson() => {
        '_id': id,
        'pid': pid,
        'date': date,
        'fine_amount': fineAmount,
        'created_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
