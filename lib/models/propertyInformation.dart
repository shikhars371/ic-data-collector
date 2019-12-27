class PropertyInformation {
  String pid;
  String surveyor1;
  String surveyor2;
  String supportingSurveyor;
  String propertyArgument;
  String humanArgument;
  String tazkiraArgument;
  String propertyNote;
  String municipalityRegNo;
  String propertyEndangerment;
  String plannedUnplanned;
  String formalInformal;
  String regularIrregular;
  String slope;
  String provinceId;
  String municipalityId;
  String nahiaId;
  String guzarId;
  String blockId;
  String parcelNo;
  String unitNo;
  String noUnitInParcel;
  String roadName;
  String historicalValue;
  String parcelArea;
  String ownershipType;
  String zones;
  String docPresenceState;
  String docType;
  String docIssueDate;
  String docIssuePlace;
  String propertyRegNo;
  String docVolumeNo;
  String docPageNo;
  String docRegNo;
  String docPropertyArea;
  String propertyGivenUsageType;
  String propertyOtherUsageType;
  String propertyCurrentUsageType;
  String usageGovermental;
  String usageOther;
  String businessOtherType;
  String unitsWithLicence;
  String unitsWithoutLicence;
  String other;
  String name;
  String surname;
  String fatherName;
  String grandFatherName;
  String gender;
  String phoneNo;
  String email;
  String notePerson;
  String tazkiraSerialNo;
  String tazkiraVolumeNo;
  String tazkiraPageNo;
  String tazkiraRegNo;
  String boundaryNote;
  String east;
  String west;
  String south;
  String north;
  String meterNo;
  String customerName;
  String cuntomerFatherName;
  String custName;
  String custFatherName;
  String sanitationBookletSerialNo;
  String issueDate;
  String ownerOccupier;
  String rentalOccupier;
  String mortagageOccupier;
  String otherOccupier;
  String otherOccupierType;
  String commercialArea;
  String residentialArea;
  String residentialUnitNo;
  String commercialUnitNo;
  String propertyCode;
  String deviceId;
  String lat;
  String long;
  String createdBy;
  String updatedBy;
  String ip;

  PropertyInformation(
      {this.pid,
      this.surveyor1,
      this.surveyor2,
      this.supportingSurveyor,
      this.propertyArgument,
      this.humanArgument,
      this.tazkiraArgument,
      this.propertyNote,
      this.municipalityRegNo,
      this.propertyEndangerment,
      this.plannedUnplanned,
      this.formalInformal,
      this.regularIrregular,
      this.slope,
      this.provinceId,
      this.municipalityId,
      this.nahiaId,
      this.guzarId,
      this.blockId,
      this.parcelNo,
      this.unitNo,
      this.noUnitInParcel,
      this.roadName,
      this.historicalValue,
      this.parcelArea,
      this.ownershipType,
      this.zones,
      this.docPresenceState,
      this.docType,
      this.docIssueDate,
      this.docIssuePlace,
      this.propertyRegNo,
      this.docVolumeNo,
      this.docPageNo,
      this.docRegNo,
      this.docPropertyArea,
      this.propertyGivenUsageType,
      this.propertyOtherUsageType,
      this.propertyCurrentUsageType,
      this.usageGovermental,
      this.usageOther,
      this.businessOtherType,
      this.unitsWithLicence,
      this.unitsWithoutLicence,
      this.other,
      this.name,
      this.surname,
      this.fatherName,
      this.grandFatherName,
      this.gender,
      this.phoneNo,
      this.email,
      this.notePerson,
      this.tazkiraSerialNo,
      this.tazkiraVolumeNo,
      this.tazkiraPageNo,
      this.tazkiraRegNo,
      this.boundaryNote,
      this.east,
      this.west,
      this.south,
      this.north,
      this.meterNo,
      this.customerName,
      this.cuntomerFatherName,
      this.custName,
      this.custFatherName,
      this.sanitationBookletSerialNo,
      this.issueDate,
      this.ownerOccupier,
      this.rentalOccupier,
      this.mortagageOccupier,
      this.otherOccupier,
      this.otherOccupierType,
      this.commercialArea,
      this.residentialArea,
      this.residentialUnitNo,
      this.commercialUnitNo,
      this.propertyCode,
      this.deviceId,
      this.lat,
      this.createdBy,
      this.updatedBy,
      this.ip});

  PropertyInformation.fromJson(Map<String, dynamic> json)
      : pid = json['pid'],
        surveyor1 = json['surveyor_1'],
        surveyor2 = json['surveyor_2'],
        supportingSurveyor = json['supporting_surveyor'],
        propertyArgument = json['property_argument'],
        humanArgument = json['human_argument'],
        tazkiraArgument = json['tazkira_argument'],
        propertyNote = json['property_note'],
        municipalityRegNo = json['municipality_reg_no'],
        propertyEndangerment = json['property_endangerment'],
        plannedUnplanned = json['planned_unplanned'],
        formalInformal = json['formal_informal'],
        regularIrregular = json['regular_irregular'],
        slope = json['slope'],
        provinceId = json['province_id'],
        municipalityId = json['municipality_id'],
        nahiaId = json['nahia_id'],
        guzarId = json['guzar_id'],
        blockId = json['block_id'],
        parcelNo = json['parcel_no'],
        unitNo = json['unit_no'],
        noUnitInParcel = json['no_unit_in_parcel'],
        roadName = json['road_name'],
        historicalValue = json['historical_value'],
        parcelArea = json['parcel_area'],
        ownershipType = json['ownership_type'],
        zones = json['zones'],
        docPresenceState = json['doc_presence_state'],
        docType = json['doc_type'],
        docIssueDate = json['doc_issue_date'],
        docIssuePlace = json['doc_issue_place'],
        propertyRegNo = json['property_reg_no'],
        docVolumeNo = json['doc_volume_no'],
        docPageNo = json['doc_page_no'],
        docRegNo = json['doc_reg_no'],
        docPropertyArea = json['doc_property_area'],
        propertyGivenUsageType = json['property_given_usage_type'],
        propertyOtherUsageType = json['property_other_usage_type'],
        propertyCurrentUsageType = json['property_current_usage_type'],
        usageGovermental = json['usage_govermental'],
        usageOther = json['usage_other'],
        businessOtherType = json['business_other_type'],
        unitsWithLicence = json['units_with_licence'],
        unitsWithoutLicence = json['units_without_licence'],
        other = json['other'],
        name = json['name'],
        surname = json['surname'],
        fatherName = json['father_name'],
        grandFatherName = json['grand_father_name'],
        gender = json['gender'],
        phoneNo = json['phone_no'],
        email = json['email'],
        notePerson = json['note_person'],
        tazkiraSerialNo = json['tazkira_serial_no'],
        tazkiraVolumeNo = json['tazkira_volume_no'],
        tazkiraPageNo = json['tazkira_page_no'],
        tazkiraRegNo = json['tazkira_reg_no'],
        boundaryNote = json['boundary_note'],
        east = json['East'],
        west = json['West'],
        south = json['South'],
        north = json['North'],
        meterNo = json['meter_no'],
        customerName = json['customer_name'],
        cuntomerFatherName = json['cuntomer_father_name'],
        custName = json['cust_name'],
        custFatherName = json['cust_father_name'],
        sanitationBookletSerialNo = json['sanitation_booklet_serial_no'],
        issueDate = json['issue_date'],
        ownerOccupier = json['owner_occupier'],
        rentalOccupier = json['rental_occupier'],
        mortagageOccupier = json['mortagage_occupier'],
        otherOccupier = json['other_occupier'],
        otherOccupierType = json['other_occupier_type'],
        commercialArea = json['commercial_area'],
        residentialArea = json['residential_area'],
        residentialUnitNo = json['residential_unit_no'],
        commercialUnitNo = json['commercial_unit_no'],
        propertyCode = json['property_code'],
        deviceId = json['device_id'],
        lat = json['lat'],
        long = json['long'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        'pid': pid,
        'surveyor_1': surveyor1,
        'surveyor_2': surveyor2,
        'supporting_surveyor': supportingSurveyor,
        'property_argument': propertyArgument,
        'human_argument': humanArgument,
        'tazkira_argument': tazkiraArgument,
        'property_note': propertyNote,
        'municipality_reg_no': municipalityRegNo,
        'property_endangerment': propertyEndangerment,
        'planned_unplanned': plannedUnplanned,
        'formal_informal': formalInformal,
        'regular_irregular': regularIrregular,
        'slope': slope,
        'province_id': provinceId,
        'municipality_id': municipalityId,
        'nahia_id': nahiaId,
        'guzar_id': guzarId,
        'block_id': blockId,
        'parcel_no': parcelNo,
        'unit_no': unitNo,
        'no_unit_in_parcel': noUnitInParcel,
        'road_name': roadName,
        'historical_value': historicalValue,
        'parcel_area': parcelArea,
        'ownership_type': ownershipType,
        'zones': zones,
        'doc_presence_state': docPresenceState,
        'doc_type': docType,
        'doc_issue_date': docIssueDate,
        'doc_issue_place': docIssuePlace,
        'property_reg_no': propertyRegNo,
        'doc_volume_no': docVolumeNo,
        'doc_page_no': docPageNo,
        'doc_reg_no': docRegNo,
        'doc_property_area': docPropertyArea,
        'property_given_usage_type': propertyGivenUsageType,
        'property_other_usage_type': propertyOtherUsageType,
        'property_current_usage_type': propertyCurrentUsageType,
        'usage_govermental': usageGovermental,
        'usage_other': usageOther,
        'business_other_type': businessOtherType,
        'units_with_licence': unitsWithLicence,
        'units_without_licence': unitsWithoutLicence,
        'other': other,
        'name': name,
        'surname': surname,
        'father_name': fatherName,
        'grand_father_name': grandFatherName,
        'gender': gender,
        'phone_no': phoneNo,
        'email': email,
        'note_person': notePerson,
        'tazkira_serial_no': tazkiraSerialNo,
        'tazkira_volume_no': tazkiraVolumeNo,
        'tazkira_page_no': tazkiraPageNo,
        'tazkira_reg_no': tazkiraRegNo,
        'boundary_note': boundaryNote,
        'East': east,
        'West': west,
        'South': south,
        'North': north,
        'meter_no': meterNo,
        'customer_name': customerName,
        'cuntomer_father_name': cuntomerFatherName,
        'cust_name': custName,
        'cust_father_name': custFatherName,
        'sanitation_booklet_serial_no': sanitationBookletSerialNo,
        'issue_date': issueDate,
        'owner_occupier': ownerOccupier,
        'rental_occupier': rentalOccupier,
        'mortagage_occupier': mortagageOccupier,
        'other_occupier': otherOccupier,
        'other_occupier_type': otherOccupierType,
        'commercial_area': commercialArea,
        'residential_area': residentialArea,
        'residential_unit_no': residentialUnitNo,
        'commercial_unit_no': commercialUnitNo,
        'property_code': propertyCode,
        'device_id': deviceId,
        'lat': lat,
        'long': long,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
