class SurveyAssignment {
  String id;
  String teamlead;
  String teamleadname;
  String surveyor1;
  String surveyoronename;
  String surveyor2;
  String surveyortwoname;
  String province;
  String municpality;
  String nahia;
  String gozar;
  String block;
  int property_to_survey;
  String startDate;
  String due_date;
  String taskStatus;
  int isdeleted;
  int issynced;
  int iscompleted;
  int isstatrted;
  String updatedate;
  int noOfCompletedTask;
  String reworkstatus;

  SurveyAssignment(
      {this.id,
      this.teamlead,
      this.teamleadname,
      this.surveyor1,
      this.surveyoronename,
      this.surveyor2,
      this.surveyortwoname,
      this.province,
      this.municpality,
      this.nahia,
      this.gozar,
      this.block,
      this.property_to_survey,
      this.startDate,
      this.due_date,
      this.taskStatus,
      this.isdeleted,
      this.iscompleted,
      this.isstatrted,
      this.issynced,
      this.updatedate,
      this.noOfCompletedTask,
      this.reworkstatus});

  SurveyAssignment.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        teamlead = json['team_lead'],
        surveyor1 = json['surveyor_1'],
        surveyor2 = json['surveyor_2'],
        province = json['province_value'],
        municpality = json['municipality_value'],
        nahia = json['nahia'],
        gozar = json['gozar'],
        block = json['block'],
        property_to_survey = json['property_to_survey'],
        startDate = json['start_date'],
        due_date = json['due_date'],
        taskStatus = json['task_status'],
        updatedate = json['updatedAt'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'team_lead': teamlead,
        'surveyor_1': surveyor1,
        'surveyor_2': surveyor2,
        'province_value': province,
        'municipality_value': municpality,
        'nahia': nahia,
        'gozar': gozar,
        'block': block,
        'property_to_survey': property_to_survey,
        'start_date': startDate,
        'due_date': due_date,
        'task_status': taskStatus,
        'updatedAt': updatedate
      };
}
