class CourtHearingStatus {
  String id;
  String pid;
  String courtName;
  String hearingDate;
  String hearingDetails;
  String createdBy;
  String updatedBy;
  String ip;

  CourtHearingStatus(
      {this.id,
      this.pid,
      this.courtName,
      this.hearingDate,
      this.hearingDetails,
      this.createdBy,
      this.updatedBy,
      this.ip});

  CourtHearingStatus.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        pid = json['pid'],
        courtName = json['court_name'],
        hearingDate = json['hearing_date'],
        hearingDetails = json['hearing_details'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'pid': pid,
        'court_name': courtName,
        'hearing_date': hearingDate,
        'hearing_details': hearingDetails,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
