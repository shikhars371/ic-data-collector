class SurveyStatus {
  String id;
  String surveyorStatus;
  String teamLeadStatus;
  String geoVerifierStatus;
  String surveyorApprovalDate;
  String teamLeaderApprovalDate;
  String geoApproverDate;
  String createdBy;
  String updatedBy;
  String ip;

  SurveyStatus(
      {this.id,
      this.surveyorStatus,
      this.teamLeadStatus,
      this.geoVerifierStatus,
      this.surveyorApprovalDate,
      this.teamLeaderApprovalDate,
      this.geoApproverDate,
      this.createdBy,
      this.updatedBy,
      this.ip});

  SurveyStatus.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        surveyorStatus = json['surveyor_status'],
        teamLeadStatus = json['team_lead_status'],
        geoVerifierStatus = json['geo_verifier_status'],
        surveyorApprovalDate = json['surveyor_approval_date'],
        teamLeaderApprovalDate = json['team_leader_approval_date'],
        geoApproverDate = json['geo_approver_date'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'surveyor_status': surveyorStatus,
        'team_lead_status': teamLeadStatus,
        'geo_verifier_status': geoVerifierStatus,
        'surveyor_approval_date': surveyorApprovalDate,
        'team_leader_approval_date': teamLeaderApprovalDate,
        'geo_approver_date': geoApproverDate,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
