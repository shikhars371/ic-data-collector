class PropertyPartnerInformation {
  String id;
  String name;
  String surname;
  String fatherName;
  String grandFatherName;
  String gender;
  String phoneNo;
  String email;
  String tazkiraInfo;
  String tazkiraSlno;
  String tazkiraVolNo;
  String tazkiraPageNo;
  String tazkiraRegNo;
  String createdBy;
  String updatedBy;
  String ip;

  PropertyPartnerInformation(
      {this.id,
      this.name,
      this.surname,
      this.fatherName,
      this.grandFatherName,
      this.gender,
      this.phoneNo,
      this.email,
      this.tazkiraInfo,
      this.tazkiraSlno,
      this.tazkiraVolNo,
      this.tazkiraPageNo,
      this.tazkiraRegNo,
      this.createdBy,
      this.updatedBy,
      this.ip});

  PropertyPartnerInformation.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        surname = json['surname'],
        fatherName = json['father_name'],
        grandFatherName = json['grand_father_name'],
        gender = json['gender'],
        phoneNo = json['phone_no'],
        email = json['email'],
        tazkiraInfo = json['tazkira_info'],
        tazkiraSlno = json['tazkira_slno'],
        tazkiraVolNo = json['tazkira_vol_no'],
        tazkiraPageNo = json['tazkira_page_no'],
        tazkiraRegNo = json['tazkira_reg_no'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'surname': surname,
        'father_name': fatherName,
        'grand_father_name': grandFatherName,
        'gender': gender,
        'phone_no': phoneNo,
        'email': email,
        'tazkira_info': tazkiraInfo,
        'tazkira_slno': tazkiraSlno,
        'tazkira_vol_no': tazkiraVolNo,
        'tazkira_page_no': tazkiraPageNo,
        'tazkira_reg_no': tazkiraRegNo,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
