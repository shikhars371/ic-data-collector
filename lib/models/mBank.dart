class MBank {
  String id;
  String name;
  String branch;
  String code;
  String phone;
  String address;
  String status;
  String createdBy;
  String updatedBy;
  String ip;

  MBank(
      {this.id,
      this.name,
      this.branch,
      this.code,
      this.phone,
      this.address,
      this.status,
      this.createdBy,
      this.updatedBy,
      this.ip});

  MBank.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        branch = json['branch'],
        code = json['code'],
        phone = json['phone'],
        address = json['address'],
        status = json['status'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'branch': branch,
        'code': code,
        'phone': phone,
        'address': address,
        'status': status,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
