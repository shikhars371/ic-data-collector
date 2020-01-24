class SurveyAssignment {
  String id;
  String teamlead;
  String province;
  String municpality;
  String nahia;
  String gozar;
  int property_to_survey;
  String startDate;
  String due_date;
  int isdeleted;
  int issynced;
  int iscompleted;
  int isstatrted;

  SurveyAssignment(
      {this.id,
      this.teamlead,
      this.province,
      this.municpality,
      this.nahia,
      this.gozar,
      this.property_to_survey,
      this.startDate,
      this.due_date,
      this.isdeleted,
      this.iscompleted,
      this.isstatrted,
      this.issynced});

  SurveyAssignment.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        teamlead = json['teamlead'],
        province = json['province'],
        municpality = json['municipality'],
        nahia = json['nahia'],
        gozar = json['gozar'],
        property_to_survey = json['property_to_survey'],
        startDate = json['start_date'],
        due_date = json['due_date'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'teamlead': teamlead,
        'province': province,
        'municipality': municpality,
        'nahia': nahia,
        'gozar': gozar,
        'property_to_survey': property_to_survey,
        'start_date': startDate,
        'due_date': due_date
      };
}
