class ReworkAssignment {
  String sid;
  String propertyid;
  String upin;
  String surveylead;
  String surveyor1;
  String surveyor2;
  String province;
  String municipality;
  String nahia;
  String gozar;
  String block;
  String unit;
  String parcelno;
  String remarks;
  String reworktype;
  String status;
  String surveystatus;
  int appstatus;//0-not started,1-progress,2-completed,3-synced
  String surveyleadname;
  String surveyoronename;
  String surveyortwoname;
  String createdate;
  String updatedate;

  ReworkAssignment(
      {this.sid,
      this.propertyid,
      this.upin,
      this.surveylead,
      this.surveyor1,
      this.surveyor2,
      this.province,
      this.municipality,
      this.nahia,
      this.gozar,
      this.block,
      this.parcelno,
      this.unit,
      this.remarks,
      this.reworktype,
      this.status,
      this.surveystatus,
      this.appstatus,
      this.surveyleadname,
      this.surveyoronename,
      this.surveyortwoname,
      this.createdate,
      this.updatedate});

  ReworkAssignment.fromJson(Map<String, dynamic> json) {
    sid = json['_id'];
    propertyid = json['property_id'];
    upin = json['upin'];
    surveylead = json['survey_lead'];
    surveyor1 = json['surveyor1'];
    surveyor2 = json['surveyor2'];
    province = json['province'];
    municipality = json['municipality'];
    nahia = json['nahia'];
    gozar = json['gozar'];
    parcelno = json['parcel_no'];
    block = json['block'];
    unit = json['unit'];
    remarks = json['remarks'];
    reworktype = json['rework_type'];
    status = json['status'];
    surveystatus = json['surveystatus'];
    createdate=json['createdAt'];
    updatedate = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sid;
    data['property_id'] = this.propertyid;
    data['upin'] = this.upin;
    data['survey_lead'] = this.surveylead;
    data['surveyor1'] = this.surveyor1;
    data['surveyor2'] = this.surveyor2;
    data['province'] = this.province;
    data['municipality'] = this.municipality;
    data['nahia'] = this.nahia;
    data['gozar'] = this.gozar;
    data['block'] = this.block;
    data['parcel_no'] = this.parcelno;
    data['unit'] = this.unit;
    data['remarks'] = this.remarks;
    data['rework_type'] = this.reworktype;
    data['status'] = this.status;
    data['surveystatus'] = this.surveystatus;
    data['createdAt']= this.createdate;
    data['updatedAt'] = this.updatedate;
    return data;
  }
}
