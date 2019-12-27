class User {
  String id;
  String firstName;
  String lastName;
  String departmentId;
  String designation;
  String phone;
  String email;
  String userName;
  String password;
  String confirmPassword;
  String address;
  String activeStatus;
  String roleId;
  String deviceName;
  String deviceModelNo;
  String deviceStatus;
  String deviceAllocationDate;
  String provinceId;
  String municiplaityId;
  String nahiaId;
  String gozarId;
  String createdBy;
  String updatedBy;
  String ip;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.departmentId,
      this.designation,
      this.phone,
      this.email,
      this.userName,
      this.password,
      this.confirmPassword,
      this.address,
      this.activeStatus,
      this.roleId,
      this.deviceName,
      this.deviceModelNo,
      this.deviceStatus,
      this.deviceAllocationDate,
      this.provinceId,
      this.municiplaityId,
      this.nahiaId,
      this.gozarId,
      this.createdBy,
      this.updatedBy,
      this.ip});

  User.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        departmentId = json['department_id'],
        designation = json['designation'],
        phone = json['phone'],
        email = json['email'],
        userName = json['user_name'],
        password = json['password'],
        confirmPassword = json['confirm_password'],
        address = json['address'],
        activeStatus = json['active_status'],
        roleId = json['role_id'],
        deviceName = json['decvice_name'],
        deviceModelNo = json['device_model_no'],
        deviceStatus = json['device_status'],
        deviceAllocationDate = json['device_allocation_date'],
        provinceId = json['province_id'],
        municiplaityId = json['municiplaity_id'],
        nahiaId = json['nahia_id'],
        gozarId = json['gozar_id'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'first_name': firstName,
        'last_name': lastName,
        'department_id': departmentId,
        'designation': designation,
        'phone': phone,
        'email': email,
        'user_name': userName,
        'password': password,
        'confirm_password': confirmPassword,
        'address': address,
        'active_status': activeStatus,
        'role_id': roleId,
        'decvice_name': deviceName,
        'device_model_no': deviceModelNo,
        'device_status': deviceStatus,
        'device_allocation_date': deviceAllocationDate,
        'province_id': provinceId,
        'municiplaity_id': municiplaityId,
        'nahia_id': nahiaId,
        'gozar_id': gozarId,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
