class LoginStatus {
  String id;
  String uid;
  String loginTime;
  String loginDate;
  String createdBy;
  String updatedBy;
  String ip;

  LoginStatus(
      {this.id,
      this.uid,
      this.loginTime,
      this.loginDate,
      this.createdBy,
      this.updatedBy,
      this.ip});

  LoginStatus.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        uid = json['uid'],
        loginTime = json['login_time'],
        loginDate = json['login_date'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'login_time': loginTime,
        'login_date': loginDate,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
