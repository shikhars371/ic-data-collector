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
  String remarks;
  String reworktype;
  String status;
  String surveystatus;
  String prevsurveyor1;
  String prevsurveyor2;
  String createdAt;
  String updatedAt;

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
      this.unit,
      this.remarks,
      this.reworktype,
      this.status,
      this.surveystatus,
      this.prevsurveyor1,
      this.prevsurveyor2,
      this.createdAt,
      this.updatedAt});

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
    block = json['block'];
    unit = json['unit'];
    remarks = json['remarks'];
    reworktype = json['rework_type'];
    status = json['status'];
    surveystatus = json['surveystatus'];
    prevsurveyor1 = json['prev_surveyor1'];
    prevsurveyor2 = json['prev_surveyor2'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    data['unit'] = this.unit;
    data['remarks'] = this.remarks;
    data['rework_type'] = this.reworktype;
    data['status'] = this.status;
    data['surveystatus'] = this.surveystatus;
    data['prev_surveyor1'] = this.prevsurveyor1;
    data['prev_surveyor2'] = this.prevsurveyor2;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
