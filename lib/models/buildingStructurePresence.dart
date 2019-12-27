class BuildingStructurePresence {
  String id;
  String usageType;
  String catagory;
  String catOther;
  String floorCount;
  String volume;
  String createdBy;
  String updatedBy;
  String ip;

  BuildingStructurePresence(
      {this.id,
      this.usageType,
      this.catagory,
      this.catOther,
      this.floorCount,
      this.volume,
      this.createdBy,
      this.updatedBy,
      this.ip});

  BuildingStructurePresence.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        usageType = json['usage_type'],
        catagory = json['catagory'],
        catOther = json['cat_other'],
        floorCount = json['floor_count'],
        volume = json['volume'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'usage_type': usageType,
        'catagory': catagory,
        'cat_other': catOther,
        'floor_count': floorCount,
        'volume': volume,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
