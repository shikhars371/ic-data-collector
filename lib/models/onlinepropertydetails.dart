class OnlinePropertySurvey {
  String sId;
  SurveyorsInfo surveyorsInfo;
  Arguments1 arguments1;
  Arguments2 arguments2;
  PropertyPhysicalCondition propertyPhysicalCondition;
  PropertyPhysicalLocation propertyPhysicalLocation;
  String zones;
  String docPresenceState;
  String documentTypeInfo;
  GovermentalDocSpecification govermentalDocSpecification;
  LocalDocSpecification localDocSpecification;
  String propertyGivenUsageType;
  String propertyOtherUsageType;
  String propertyCurrentUsageType;
  String usageRental;
  String usageBusiness;
  String usageGovermental;
  String usageOther;
  String businessOtherType;
  BusinessLicence businessLicence;
  OwnerOrFirstPartnerInfo ownerOrFirstPartnerInfo;
  TazkiraInformation tazkiraInformation;
  PropertyPartnersInformation propertyPartnersInformation;
  PropertyBoundariesInfo propertyBoundariesInfo;
  ElectricityBillInfo electricityBillInfo;
  SanitationBookletInfo sanitationBookletInfo;
  PropertyUserInfo propertyUserInfo;
  String otherOccupierType;
  BuildingStructureInfo buildingStructureInfo;
  String sketch;
  String houseImage;
  String code;
  UnitsInfo unitsInfo;
  String start;
  String end;
  String today;
  String deviceid;
  Meta meta;
  String importDate;
  bool badHI;
  bool badSK;
  String otherNote;
  bool isCompleted;
  bool isValidated;
  bool isFinalized;
  bool flag;
  bool kMarea;
  String gISmap;
  String lan;
  String lon;
  String checker;
  String extra2;
  String region;
  String key;
  String status;
  String upin;
  String surveyor1Id;
  String surveyor2Id;
  String supportingSurveyorId;
  String authority;

  OnlinePropertySurvey(
      {this.sId,
      this.surveyorsInfo,
      this.arguments1,
      this.arguments2,
      this.propertyPhysicalCondition,
      this.propertyPhysicalLocation,
      this.zones,
      this.docPresenceState,
      this.documentTypeInfo,
      this.govermentalDocSpecification,
      this.localDocSpecification,
      this.propertyGivenUsageType,
      this.propertyOtherUsageType,
      this.propertyCurrentUsageType,
      this.usageRental,
      this.usageBusiness,
      this.usageGovermental,
      this.usageOther,
      this.businessOtherType,
      this.businessLicence,
      this.ownerOrFirstPartnerInfo,
      this.tazkiraInformation,
      this.propertyPartnersInformation,
      this.propertyBoundariesInfo,
      this.electricityBillInfo,
      this.sanitationBookletInfo,
      this.propertyUserInfo,
      this.otherOccupierType,
      this.buildingStructureInfo,
      this.sketch,
      this.houseImage,
      this.code,
      this.unitsInfo,
      this.start,
      this.end,
      this.today,
      this.deviceid,
      this.meta,
      this.importDate,
      this.badHI,
      this.badSK,
      this.otherNote,
      this.isCompleted,
      this.isValidated,
      this.isFinalized,
      this.flag,
      this.kMarea,
      this.gISmap,
      this.lan,
      this.lon,
      this.checker,
      this.extra2,
      this.region,
      this.key,
      this.status,
      this.upin,
      this.surveyor1Id,
      this.surveyor2Id,
      this.supportingSurveyorId,
      this.authority});

  OnlinePropertySurvey.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    surveyorsInfo = json['surveyors_info'] != null
        ? new SurveyorsInfo.fromJson(json['surveyors_info'])
        : null;
    arguments1 = json['arguments_1'] != null
        ? new Arguments1.fromJson(json['arguments_1'])
        : null;
    arguments2 = json['arguments_2'] != null
        ? new Arguments2.fromJson(json['arguments_2'])
        : null;
    propertyPhysicalCondition = json['property_physical_condition'] != null
        ? new PropertyPhysicalCondition.fromJson(
            json['property_physical_condition'])
        : null;
    propertyPhysicalLocation = json['property_physical_location'] != null
        ? new PropertyPhysicalLocation.fromJson(
            json['property_physical_location'])
        : null;
    zones = json['zones'];
    docPresenceState = json['doc_presence_state'];
    documentTypeInfo = json['document_type_info'];
    govermentalDocSpecification = json['govermental_doc_specification'] != null
        ? new GovermentalDocSpecification.fromJson(
            json['govermental_doc_specification'])
        : null;
    localDocSpecification = json['local_doc_specification'] != null
        ? new LocalDocSpecification.fromJson(json['local_doc_specification'])
        : null;
    propertyGivenUsageType = json['property_given_usage_type'];
    propertyOtherUsageType = json['property_other_usage_type'];
    propertyCurrentUsageType = json['property_current_usage_type'];
    usageRental = json['usage_rental'];
    usageBusiness = json['usage_business'];
    usageGovermental = json['usage_govermental'];
    usageOther = json['usage_other'];
    businessOtherType = json['business_other_type'];
    businessLicence = json['business_licence'] != null
        ? new BusinessLicence.fromJson(json['business_licence'])
        : null;
    ownerOrFirstPartnerInfo = json['owner_or_first_partner_info'] != null
        ? new OwnerOrFirstPartnerInfo.fromJson(
            json['owner_or_first_partner_info'])
        : null;
    tazkiraInformation = json['tazkira_information'] != null
        ? new TazkiraInformation.fromJson(json['tazkira_information'])
        : null;
    propertyPartnersInformation = json['property_partners_information'] != null
        ? new PropertyPartnersInformation.fromJson(
            json['property_partners_information'])
        : null;
    propertyBoundariesInfo = json['property_boundaries_info'] != null
        ? new PropertyBoundariesInfo.fromJson(json['property_boundaries_info'])
        : null;
    electricityBillInfo = json['electricity_bill_info'] != null
        ? new ElectricityBillInfo.fromJson(json['electricity_bill_info'])
        : null;
    sanitationBookletInfo = json['sanitation_booklet_info'] != null
        ? new SanitationBookletInfo.fromJson(json['sanitation_booklet_info'])
        : null;
    propertyUserInfo = json['property_user_info'] != null
        ? new PropertyUserInfo.fromJson(json['property_user_info'])
        : null;
    otherOccupierType = json['other_occupier_type'];
    buildingStructureInfo = json['building_structure_info'] != null
        ? new BuildingStructureInfo.fromJson(json['building_structure_info'])
        : null;
    sketch = json['Sketch'];
    houseImage = json['HouseImage'];
    code = json['code'];
    unitsInfo = json['Units_Info'] != null
        ? new UnitsInfo.fromJson(json['Units_Info'])
        : null;
    start = json['start'];
    end = json['end'];
    today = json['Today'];
    deviceid = json['deviceid'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    importDate = json['importDate'];
    badHI = json['badHI'];
    badSK = json['badSK'];
    otherNote = json['otherNote'];
    isCompleted = json['IsCompleted'];
    isValidated = json['IsValidated'];
    isFinalized = json['IsFinalized'];
    flag = json['Flag'];
    kMarea = json['KMarea'];
    gISmap = json['GISmap'];
    lan = json['lan'];
    lon = json['lon'];
    checker = json['checker'];
    extra2 = json['extra2'];
    region = json['region'];
    key = json['key'];
    status = json['status'];
    upin = json['upin'];
    surveyor1Id = json['surveyor1_id'];
    surveyor2Id = json['surveyor2_id'];
    supportingSurveyorId = json['supporting_surveyor_id'];
    authority = json['authority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.surveyorsInfo != null) {
      data['surveyors_info'] = this.surveyorsInfo.toJson();
    }
    if (this.arguments1 != null) {
      data['arguments_1'] = this.arguments1.toJson();
    }
    if (this.arguments2 != null) {
      data['arguments_2'] = this.arguments2.toJson();
    }
    if (this.propertyPhysicalCondition != null) {
      data['property_physical_condition'] =
          this.propertyPhysicalCondition.toJson();
    }
    if (this.propertyPhysicalLocation != null) {
      data['property_physical_location'] =
          this.propertyPhysicalLocation.toJson();
    }
    data['zones'] = this.zones;
    data['doc_presence_state'] = this.docPresenceState;
    data['document_type_info'] = this.documentTypeInfo;
    if (this.govermentalDocSpecification != null) {
      data['govermental_doc_specification'] =
          this.govermentalDocSpecification.toJson();
    }
    if (this.localDocSpecification != null) {
      data['local_doc_specification'] = this.localDocSpecification.toJson();
    }
    data['property_given_usage_type'] = this.propertyGivenUsageType;
    data['property_other_usage_type'] = this.propertyOtherUsageType;
    data['property_current_usage_type'] = this.propertyCurrentUsageType;
    data['usage_rental'] = this.usageRental;
    data['usage_business'] = this.usageBusiness;
    data['usage_govermental'] = this.usageGovermental;
    data['usage_other'] = this.usageOther;
    data['business_other_type'] = this.businessOtherType;
    if (this.businessLicence != null) {
      data['business_licence'] = this.businessLicence.toJson();
    }
    if (this.ownerOrFirstPartnerInfo != null) {
      data['owner_or_first_partner_info'] =
          this.ownerOrFirstPartnerInfo.toJson();
    }
    if (this.tazkiraInformation != null) {
      data['tazkira_information'] = this.tazkiraInformation.toJson();
    }
    if (this.propertyPartnersInformation != null) {
      data['property_partners_information'] =
          this.propertyPartnersInformation.toJson();
    }
    if (this.propertyBoundariesInfo != null) {
      data['property_boundaries_info'] = this.propertyBoundariesInfo.toJson();
    }
    if (this.electricityBillInfo != null) {
      data['electricity_bill_info'] = this.electricityBillInfo.toJson();
    }
    if (this.sanitationBookletInfo != null) {
      data['sanitation_booklet_info'] = this.sanitationBookletInfo.toJson();
    }
    if (this.propertyUserInfo != null) {
      data['property_user_info'] = this.propertyUserInfo.toJson();
    }
    data['other_occupier_type'] = this.otherOccupierType;
    if (this.buildingStructureInfo != null) {
      data['building_structure_info'] = this.buildingStructureInfo.toJson();
    }
    data['Sketch'] = this.sketch;
    data['HouseImage'] = this.houseImage;
    data['code'] = this.code;
    if (this.unitsInfo != null) {
      data['Units_Info'] = this.unitsInfo.toJson();
    }
    data['start'] = this.start;
    data['end'] = this.end;
    data['Today'] = this.today;
    data['deviceid'] = this.deviceid;
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    data['importDate'] = this.importDate;
    data['badHI'] = this.badHI;
    data['badSK'] = this.badSK;
    data['otherNote'] = this.otherNote;
    data['IsCompleted'] = this.isCompleted;
    data['IsValidated'] = this.isValidated;
    data['IsFinalized'] = this.isFinalized;
    data['Flag'] = this.flag;
    data['KMarea'] = this.kMarea;
    data['GISmap'] = this.gISmap;
    data['lan'] = this.lan;
    data['lon'] = this.lon;
    data['checker'] = this.checker;
    data['extra2'] = this.extra2;
    data['region'] = this.region;
    data['key'] = this.key;
    data['status'] = this.status;
    data['upin'] = this.upin;
    data['surveyor1_id'] = this.surveyor1Id;
    data['surveyor2_id'] = this.surveyor2Id;
    data['supporting_surveyor_id'] = this.supportingSurveyorId;
    data['authority'] = this.authority;
    return data;
  }
}

class SurveyorsInfo {
  String surveyor1;
  String surveyor2;
  String supportingSurveyor;

  SurveyorsInfo({this.surveyor1, this.surveyor2, this.supportingSurveyor});

  SurveyorsInfo.fromJson(Map<String, dynamic> json) {
    surveyor1 = json['first_surveyor_name'];
    surveyor2 = json['senond_surveyor_name'];
    supportingSurveyor = json['technical_support_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_surveyor_name'] = this.surveyor1;
    data['senond_surveyor_name'] = this.surveyor2;
    data['technical_support_name'] = this.supportingSurveyor;
    return data;
  }
}

class Arguments1 {
  String propertyArgument;
  String humanArgument;
  String tazkiraArgument;

  Arguments1({this.propertyArgument, this.humanArgument, this.tazkiraArgument});

  Arguments1.fromJson(Map<String, dynamic> json) {
    propertyArgument = json['property_dispte_subject_to'];
    humanArgument = json['real_person_status'];
    tazkiraArgument = json['cityzenship_notice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['property_dispte_subject_to'] = this.propertyArgument;
    data['real_person_status'] = this.humanArgument;
    data['cityzenship_notice'] = this.tazkiraArgument;
    return data;
  }
}

class Arguments2 {
  String propertyNote;
  String municipalityRegNo;
  String propertyEndangerment;

  Arguments2(
      {this.propertyNote, this.municipalityRegNo, this.propertyEndangerment});

  Arguments2.fromJson(Map<String, dynamic> json) {
    propertyNote = json['issue_regarding_property'];
    municipalityRegNo = json['municipality_ref_number'];
    propertyEndangerment = json['natural_threaten'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['issue_regarding_property'] = this.propertyNote;
    data['municipality_ref_number'] = this.municipalityRegNo;
    data['natural_threaten'] = this.propertyEndangerment;
    return data;
  }
}

class PropertyPhysicalCondition {
  String plannedUnplanned;
  String formalInformal;
  String regularIrregular;
  String slope;

  PropertyPhysicalCondition(
      {this.plannedUnplanned,
      this.formalInformal,
      this.regularIrregular,
      this.slope});

  PropertyPhysicalCondition.fromJson(Map<String, dynamic> json) {
    plannedUnplanned = json['status_of_area_plan'];
    formalInformal = json['status_of_area_official'];
    regularIrregular = json['status_of_area_regular'];
    slope = json['slope_of_area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_of_area_plan'] = this.plannedUnplanned;
    data['status_of_area_official'] = this.formalInformal;
    data['status_of_area_regular'] = this.regularIrregular;
    data['slope_of_area'] = this.slope;
    return data;
  }
}

class PropertyPhysicalLocation {
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

  PropertyPhysicalLocation(
      {this.provinceId,
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
      this.ownershipType});

  PropertyPhysicalLocation.fromJson(Map<String, dynamic> json) {
    provinceId = json['province'];
    municipalityId = json['city'];
    nahiaId = json['area'];
    guzarId = json['pass'];
    blockId = json['block'];
    parcelNo = json['part_number'];
    unitNo = json['unit_number'];
    noUnitInParcel = json['unit_in_parcel'];
    roadName = json['street_name'];
    historicalValue = json['historic_site_area'];
    parcelArea = json['land_area'];
    ownershipType = json['property_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province'] = this.provinceId;
    data['city'] = this.municipalityId;
    data['area'] = this.nahiaId;
    data['pass'] = this.guzarId;
    data['block'] = this.blockId;
    data['part_number'] = this.parcelNo;
    data['unit_number'] = this.unitNo;
    data['unit_in_parcel'] = this.noUnitInParcel;
    data['street_name'] = this.roadName;
    data['historic_site_area'] = this.historicalValue;
    data['land_area'] = this.parcelArea;
    data['property_type'] = this.ownershipType;
    return data;
  }
}

class GovermentalDocSpecification {
  String docIssueDate;
  String docIssuePlace;
  String propertyRegNo;
  String docVolumeNo;
  String docPageNo;
  String docRegNo;
  String docPropertyArea;
  String docImg1;
  String docImg2;
  String docImg3;
  String docImg4;

  GovermentalDocSpecification(
      {this.docIssueDate,
      this.docIssuePlace,
      this.propertyRegNo,
      this.docVolumeNo,
      this.docPageNo,
      this.docRegNo,
      this.docPropertyArea,
      this.docImg1,
      this.docImg2,
      this.docImg3,
      this.docImg4});

  GovermentalDocSpecification.fromJson(Map<String, dynamic> json) {
    docIssueDate = json['issued_on'];
    docIssuePlace = json['place_of_issue'];
    propertyRegNo = json['property_number'];
    docVolumeNo = json['document_cover'];
    docPageNo = json['document_page'];
    docRegNo = json['doc_reg_number'];
    docPropertyArea = json['land_area_qawwala'];
    docImg1 = json['property_doc_photo_1'];
    docImg2 = json['property_doc_photo_2'];
    docImg3 = json['property_doc_photo_3'];
    docImg4 = json['property_doc_photo_4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['issued_on'] = this.docIssueDate;
    data['place_of_issue'] = this.docIssuePlace;
    data['property_number'] = this.propertyRegNo;
    data['document_cover'] = this.docVolumeNo;
    data['document_page'] = this.docPageNo;
    data['doc_reg_number'] = this.docRegNo;
    data['land_area_qawwala'] = this.docPropertyArea;
    data['property_doc_photo_1'] = this.docImg1;
    data['property_doc_photo_2'] = this.docImg2;
    data['property_doc_photo_3'] = this.docImg3;
    data['property_doc_photo_4'] = this.docImg4;
    return data;
  }
}

class LocalDocSpecification {
  String localDocImg1;
  String localDocImg2;

  LocalDocSpecification({this.localDocImg1, this.localDocImg2});

  LocalDocSpecification.fromJson(Map<String, dynamic> json) {
    localDocImg1 = json['odinary_doc_photo1'];
    localDocImg2 = json['odinary_doc_photo6'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['odinary_doc_photo1'] = this.localDocImg1;
    data['odinary_doc_photo6'] = this.localDocImg2;
    return data;
  }
}

class BusinessLicence {
  String unitsWithLicence;
  String unitsWithoutLicence;
  String other;

  BusinessLicence(
      {this.unitsWithLicence, this.unitsWithoutLicence, this.other});

  BusinessLicence.fromJson(Map<String, dynamic> json) {
    unitsWithLicence = json['number_of_business_unit'];
    unitsWithoutLicence = json['business_unit_have_no_license'];
    other = json['business_license_another'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number_of_business_unit'] = this.unitsWithLicence;
    data['business_unit_have_no_license'] = this.unitsWithoutLicence;
    data['business_license_another'] = this.other;
    return data;
  }
}

class OwnerOrFirstPartnerInfo {
  String name;
  String surname;
  String fatherName;
  String grandFatherName;
  String gender;
  String phoneNo;
  String emal;
  String photoPerson;
  String notePerson;

  OwnerOrFirstPartnerInfo(
      {this.name,
      this.surname,
      this.fatherName,
      this.grandFatherName,
      this.gender,
      this.phoneNo,
      this.emal,
      this.photoPerson,
      this.notePerson});

  OwnerOrFirstPartnerInfo.fromJson(Map<String, dynamic> json) {
    name = json['first_partner_name'];
    surname = json['first_partner_surname'];
    fatherName = json['first_partner_boy'];
    grandFatherName = json['first_partner__father'];
    gender = json['first_partner_name_gender'];
    phoneNo = json['first_partner_name_phone'];
    emal = json['first_partner_name_email'];
    photoPerson = json['first_partner_name_property_owner'];
    notePerson = json['first_partner_name_mere_individuals'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_partner_name'] = this.name;
    data['first_partner_surname'] = this.surname;
    data['first_partner_boy'] = this.fatherName;
    data['first_partner__father'] = this.grandFatherName;
    data['first_partner_name_gender'] = this.gender;
    data['first_partner_name_phone'] = this.phoneNo;
    data['first_partner_name_email'] = this.emal;
    data['first_partner_name_property_owner'] = this.photoPerson;
    data['first_partner_name_mere_individuals'] = this.notePerson;
    return data;
  }
}

class TazkiraInformation {
  String tazkiraSerialNo;
  String tazkiraVolumeNo;
  String tazkiraPageNo;
  String tazkiraRegNo;
  String tazkiraImage1;
  String tazkiraImage2;
  String tazkiraImage3;

  TazkiraInformation(
      {this.tazkiraSerialNo,
      this.tazkiraVolumeNo,
      this.tazkiraPageNo,
      this.tazkiraRegNo,
      this.tazkiraImage1,
      this.tazkiraImage2,
      this.tazkiraImage3});

  TazkiraInformation.fromJson(Map<String, dynamic> json) {
    tazkiraSerialNo = json['info_photo_hint_sukuk_number'];
    tazkiraVolumeNo = json['info_photo_hint_cover_note'];
    tazkiraPageNo = json['info_photo_hint_note_page'];
    tazkiraRegNo = json['info_photo_hint_reg_no'];
    tazkiraImage1 = json['info_photo_hint_photo_note1'];
    tazkiraImage2 = json['info_photo_hint_photo_tips1'];
    tazkiraImage3 = json['info_photo_hint_photo_tips2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['info_photo_hint_sukuk_number'] = this.tazkiraSerialNo;
    data['info_photo_hint_cover_note'] = this.tazkiraVolumeNo;
    data['info_photo_hint_note_page'] = this.tazkiraPageNo;
    data['info_photo_hint_reg_no'] = this.tazkiraRegNo;
    data['info_photo_hint_photo_note1'] = this.tazkiraImage1;
    data['info_photo_hint_photo_tips1'] = this.tazkiraImage2;
    data['info_photo_hint_photo_tips2'] = this.tazkiraImage3;
    return data;
  }
}

class PropertyPartnersInformation {
  String secondPartnerInfo;
  String p2Name;
  String p2Surname;
  String p2FatherName;
  String p2GrandFatherName;
  String p2Gender;
  String p2PhoneNo;
  String p2Email;
  String p2Photo;
  String p2TazkiraInfo;
  String p2TazkiraSerialNo;
  String p2TazkiraVolumeNo;
  String p2TazkiraPageNo;
  String p2TazkiraRegNo;
  String p2TazkiraImage1;
  String p2TazkiraImage2;
  String p2TazkiraImage3;
  String thirdPartnerInfo;
  String p3Name;
  String p3Surname;
  String p3FatherName;
  String p3GrandFatherName;
  String p3Gender;
  String p3PhoneNo;
  String p3Email;
  String p3Photo;
  String p3TazkiraInfo;
  String p3TazkiraSerialNo;
  String p3TazkiraVolumeNo;
  String p3TazkiraPageNo;
  String p3TazkiraRegNo;
  String p3TazkiraImage1;
  String p3TazkiraImage2;
  String p3TazkiraImage3;
  String fourthPartnerInfo;
  String p4Name;
  String p4Surname;
  String p4FatherName;
  String p4GrandFatherName;
  String p4Gender;
  String p4PhoneNo;
  String p4Email;
  String p4Photo;
  String p4TazkiraInfo;
  String p4TazkiraSerialNo;
  String p4TazkiraVolumeNo;
  String p4TazkiraPageNo;
  String p4TazkiraRegNo;
  String p4TazkiraImage1;
  String p4TazkiraImage2;
  String p4TazkiraImage3;
  String fifthPartnerInfo;
  String p5Name;
  String p5Surname;
  String p5FatherName;
  String p5GrandFatherName;
  String p5Gender;
  String p5PhoneNo;
  String p5Email;
  String p5Photo;
  String p5TazkiraInfo;
  String p5TazkiraSerialNo;
  String p5TazkiraVolumeNo;
  String p5TazkiraPageNo;
  String p5TazkiraRegNo;
  String p5TazkiraImage1;
  String p5TazkiraImage2;
  String p5TazkiraImage3;
  String partnersNote;

  PropertyPartnersInformation(
      {this.secondPartnerInfo,
      this.p2Name,
      this.p2Surname,
      this.p2FatherName,
      this.p2GrandFatherName,
      this.p2Gender,
      this.p2PhoneNo,
      this.p2Email,
      this.p2Photo,
      this.p2TazkiraInfo,
      this.p2TazkiraSerialNo,
      this.p2TazkiraVolumeNo,
      this.p2TazkiraPageNo,
      this.p2TazkiraRegNo,
      this.p2TazkiraImage1,
      this.p2TazkiraImage2,
      this.p2TazkiraImage3,
      this.thirdPartnerInfo,
      this.p3Name,
      this.p3Surname,
      this.p3FatherName,
      this.p3GrandFatherName,
      this.p3Gender,
      this.p3PhoneNo,
      this.p3Email,
      this.p3Photo,
      this.p3TazkiraInfo,
      this.p3TazkiraSerialNo,
      this.p3TazkiraVolumeNo,
      this.p3TazkiraPageNo,
      this.p3TazkiraRegNo,
      this.p3TazkiraImage1,
      this.p3TazkiraImage2,
      this.p3TazkiraImage3,
      this.fourthPartnerInfo,
      this.p4Name,
      this.p4Surname,
      this.p4FatherName,
      this.p4GrandFatherName,
      this.p4Gender,
      this.p4PhoneNo,
      this.p4Email,
      this.p4Photo,
      this.p4TazkiraInfo,
      this.p4TazkiraSerialNo,
      this.p4TazkiraVolumeNo,
      this.p4TazkiraPageNo,
      this.p4TazkiraRegNo,
      this.p4TazkiraImage1,
      this.p4TazkiraImage2,
      this.p4TazkiraImage3,
      this.fifthPartnerInfo,
      this.p5Name,
      this.p5Surname,
      this.p5FatherName,
      this.p5GrandFatherName,
      this.p5Gender,
      this.p5PhoneNo,
      this.p5Email,
      this.p5Photo,
      this.p5TazkiraInfo,
      this.p5TazkiraSerialNo,
      this.p5TazkiraVolumeNo,
      this.p5TazkiraPageNo,
      this.p5TazkiraRegNo,
      this.p5TazkiraImage1,
      this.p5TazkiraImage2,
      this.p5TazkiraImage3,
      this.partnersNote});

  PropertyPartnersInformation.fromJson(Map<String, dynamic> json) {
    secondPartnerInfo = json['second_partner_info'];
    p2Name = json['second_partner_name'];
    p2Surname = json['second_partner_surname'];
    p2FatherName = json['second_partner_boy'];
    p2GrandFatherName = json['second_partner_father'];
    p2Gender = json['second_partner_gender'];
    p2PhoneNo = json['second_partner_phone'];
    p2Email = json['second_partner_email'];
    p2Photo = json['second_partner_image'];
    p2TazkiraInfo = json[''];
    p2TazkiraSerialNo = json['second_partner_machinegun_no'];
    p2TazkiraVolumeNo = json['second_partner_cover_note'];
    p2TazkiraPageNo = json['second_partner_note_page'];
    p2TazkiraRegNo = json['second_partner_reg_no'];
    p2TazkiraImage1 = json['second_partner_phote_note1'];
    p2TazkiraImage2 = json['second_partner_photo_tips1'];
    p2TazkiraImage3 = json['second_partner_photo_tips2'];
    thirdPartnerInfo = json['third_partner_info'];
    p3Name = json['third_partner_name'];
    p3Surname = json['third_partner_surname'];
    p3FatherName = json['third_partner_boy'];
    p3GrandFatherName = json['third_partner_father'];
    p3Gender = json['third_partner_gender'];
    p3PhoneNo = json['third_partner_phone'];
    p3Email = json['third_partner_email'];
    p3Photo = json['third_partner_image'];
    p3TazkiraInfo = json['p3_tazkira_info'];
    p3TazkiraSerialNo = json['third_partner_machinegun_no'];
    p3TazkiraVolumeNo = json['third_partner_cover_note'];
    p3TazkiraPageNo = json['third_partner_note_page'];
    p3TazkiraRegNo = json['third_partner_reg_no'];
    p3TazkiraImage1 = json['third_partner_phote_note1'];
    p3TazkiraImage2 = json['third_partner_photo_tips1'];
    p3TazkiraImage3 = json['third_partner_photo_tips2'];
    fourthPartnerInfo = json['fourth_partner_info'];
    p4Name = json['fourth_partner_name'];
    p4Surname = json['fourth_partner_surname'];
    p4FatherName = json['fourth_partner_boy'];
    p4GrandFatherName = json['fourth_partner_father'];
    p4Gender = json['fourth_partner_gender'];
    p4PhoneNo = json['fourth_partner_phone'];
    p4Email = json['fourth_partner_email'];
    p4Photo = json['fourth_partner_image'];
    p4TazkiraInfo = json['p4_tazkira_info'];
    p4TazkiraSerialNo = json['fourth_partner_machinegun_no'];
    p4TazkiraVolumeNo = json['fourth_partner_cover_note'];
    p4TazkiraPageNo = json['fourth_partner_note_page'];
    p4TazkiraRegNo = json['fourth_partner_reg_no'];
    p4TazkiraImage1 = json['fourth_partner_phote_note1'];
    p4TazkiraImage2 = json['fourth_partner_photo_tips1'];
    p4TazkiraImage3 = json['fourth_partner_photo_tips2'];
    fifthPartnerInfo = json['fifth_partner_info'];
    p5Name = json['p5_name'];
    p5Surname = json['p5_surname'];
    p5FatherName = json['p5_father_name'];
    p5GrandFatherName = json['p5_grand_father_name'];
    p5Gender = json['p5_gender'];
    p5PhoneNo = json['p5_phone_no'];
    p5Email = json['p5_email'];
    p5Photo = json['p5_photo'];
    p5TazkiraInfo = json['p5_tazkira_info'];
    p5TazkiraSerialNo = json['p5_tazkira_serial_no'];
    p5TazkiraVolumeNo = json['p5_tazkira_volume_no'];
    p5TazkiraPageNo = json['p5_tazkira_page_no'];
    p5TazkiraRegNo = json['p5_tazkira_reg_no'];
    p5TazkiraImage1 = json['p5_tazkira_image_1'];
    p5TazkiraImage2 = json['p5_tazkira_image_2'];
    p5TazkiraImage3 = json['p5_tazkira_image_3'];
    partnersNote = json['partners_note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['second_partner_info'] = this.secondPartnerInfo;
    data['second_partner_name'] = this.p2Name;
    data['second_partner_surname'] = this.p2Surname;
    data['second_partner_boy'] = this.p2FatherName;
    data['second_partner_father'] = this.p2GrandFatherName;
    data['second_partner_gender'] = this.p2Gender;
    data['second_partner_phone'] = this.p2PhoneNo;
    data['second_partner_email'] = this.p2Email;
    data['second_partner_image'] = this.p2Photo;
    data[''] = this.p2TazkiraInfo;
    data['second_partner_machinegun_no'] = this.p2TazkiraSerialNo;
    data['second_partner_cover_note'] = this.p2TazkiraVolumeNo;
    data['second_partner_note_page'] = this.p2TazkiraPageNo;
    data['second_partner_reg_no'] = this.p2TazkiraRegNo;
    data['second_partner_phote_note1'] = this.p2TazkiraImage1;
    data['second_partner_photo_tips1'] = this.p2TazkiraImage2;
    data['second_partner_photo_tips2'] = this.p2TazkiraImage3;
    data['third_partner_info'] = this.thirdPartnerInfo;
    data['third_partner_name'] = this.p3Name;
    data['third_partner_surname'] = this.p3Surname;
    data['third_partner_boy'] = this.p3FatherName;
    data['third_partner_father'] = this.p3GrandFatherName;
    data['third_partner_gender'] = this.p3Gender;
    data['third_partner_phone'] = this.p3PhoneNo;
    data['third_partner_email'] = this.p3Email;
    data['third_partner_image'] = this.p3Photo;
    data['p3_tazkira_info'] = this.p3TazkiraInfo;
    data['third_partner_machinegun_no'] = this.p3TazkiraSerialNo;
    data['third_partner_cover_note'] = this.p3TazkiraVolumeNo;
    data['third_partner_note_page'] = this.p3TazkiraPageNo;
    data['third_partner_reg_no'] = this.p3TazkiraRegNo;
    data['third_partner_phote_note1'] = this.p3TazkiraImage1;
    data['third_partner_photo_tips1'] = this.p3TazkiraImage2;
    data['third_partner_photo_tips2'] = this.p3TazkiraImage3;
    data['fourth_partner_info'] = this.fourthPartnerInfo;
    data['fourth_partner_name'] = this.p4Name;
    data['fourth_partner_surname'] = this.p4Surname;
    data['fourth_partner_boy'] = this.p4FatherName;
    data['fourth_partner_father'] = this.p4GrandFatherName;
    data['fourth_partner_gender'] = this.p4Gender;
    data['fourth_partner_phone'] = this.p4PhoneNo;
    data['fourth_partner_email'] = this.p4Email;
    data['fourth_partner_image'] = this.p4Photo;
    data['p4_tazkira_info'] = this.p4TazkiraInfo;
    data['fourth_partner_machinegun_no'] = this.p4TazkiraSerialNo;
    data['fourth_partner_cover_note'] = this.p4TazkiraVolumeNo;
    data['fourth_partner_note_page'] = this.p4TazkiraPageNo;
    data['fourth_partner_reg_no'] = this.p4TazkiraRegNo;
    data['fourth_partner_phote_note1'] = this.p4TazkiraImage1;
    data['fourth_partner_photo_tips1'] = this.p4TazkiraImage2;
    data['fourth_partner_photo_tips2'] = this.p4TazkiraImage3;
    data['fifth_partner_info'] = this.fifthPartnerInfo;
    data['p5_name'] = this.p5Name;
    data['p5_surname'] = this.p5Surname;
    data['p5_father_name'] = this.p5FatherName;
    data['p5_grand_father_name'] = this.p5GrandFatherName;
    data['p5_gender'] = this.p5Gender;
    data['p5_phone_no'] = this.p5PhoneNo;
    data['p5_email'] = this.p5Email;
    data['p5_photo'] = this.p5Photo;
    data['p5_tazkira_info'] = this.p5TazkiraInfo;
    data['p5_tazkira_serial_no'] = this.p5TazkiraSerialNo;
    data['p5_tazkira_volume_no'] = this.p5TazkiraVolumeNo;
    data['p5_tazkira_page_no'] = this.p5TazkiraPageNo;
    data['p5_tazkira_reg_no'] = this.p5TazkiraRegNo;
    data['p5_tazkira_image_1'] = this.p5TazkiraImage1;
    data['p5_tazkira_image_2'] = this.p5TazkiraImage2;
    data['p5_tazkira_image_3'] = this.p5TazkiraImage3;
    data['partners_note'] = this.partnersNote;
    return data;
  }
}

class PropertyBoundariesInfo {
  String boundaryNote;
  String east;
  String west;
  String south;
  String north;

  PropertyBoundariesInfo(
      {this.boundaryNote, this.east, this.west, this.south, this.north});

  PropertyBoundariesInfo.fromJson(Map<String, dynamic> json) {
    boundaryNote = json['boundary_note'];
    east = json['East'];
    west = json['West'];
    south = json['South'];
    north = json['North'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['boundary_note'] = this.boundaryNote;
    data['East'] = this.east;
    data['West'] = this.west;
    data['South'] = this.south;
    data['North'] = this.north;
    return data;
  }
}

class ElectricityBillInfo {
  String meterNo;
  String customerName;
  String cuntomerFatherName;
  String ebillImg;

  ElectricityBillInfo(
      {this.meterNo,
      this.customerName,
      this.cuntomerFatherName,
      this.ebillImg});

  ElectricityBillInfo.fromJson(Map<String, dynamic> json) {
    meterNo = json['meter_no'];
    customerName = json['customer_name'];
    cuntomerFatherName = json['cuntomer_father_name'];
    ebillImg = json['ebill_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meter_no'] = this.meterNo;
    data['customer_name'] = this.customerName;
    data['cuntomer_father_name'] = this.cuntomerFatherName;
    data['ebill_img'] = this.ebillImg;
    return data;
  }
}

class SanitationBookletInfo {
  String custName;
  String custFatherName;
  String sanitationBookletSerialNo;
  String issueDate;
  String sanitationBookletImg;

  SanitationBookletInfo(
      {this.custName,
      this.custFatherName,
      this.sanitationBookletSerialNo,
      this.issueDate,
      this.sanitationBookletImg});

  SanitationBookletInfo.fromJson(Map<String, dynamic> json) {
    custName = json['cust_name'];
    custFatherName = json['cust_father_name'];
    sanitationBookletSerialNo = json['sanitation_booklet_serial_no'];
    issueDate = json['issue_date'];
    sanitationBookletImg = json['sanitation_booklet_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cust_name'] = this.custName;
    data['cust_father_name'] = this.custFatherName;
    data['sanitation_booklet_serial_no'] = this.sanitationBookletSerialNo;
    data['issue_date'] = this.issueDate;
    data['sanitation_booklet_img'] = this.sanitationBookletImg;
    return data;
  }
}

class PropertyUserInfo {
  String ownerOccupier;
  String rentalOccupier;
  String mortagageOccupier;
  String otherOccupier;

  PropertyUserInfo(
      {this.ownerOccupier,
      this.rentalOccupier,
      this.mortagageOccupier,
      this.otherOccupier});

  PropertyUserInfo.fromJson(Map<String, dynamic> json) {
    ownerOccupier = json['owner_occupier'];
    rentalOccupier = json['rental_occupier'];
    mortagageOccupier = json['mortagage_occupier'];
    otherOccupier = json['other_occupier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['owner_occupier'] = this.ownerOccupier;
    data['rental_occupier'] = this.rentalOccupier;
    data['mortagage_occupier'] = this.mortagageOccupier;
    data['other_occupier'] = this.otherOccupier;
    return data;
  }
}

class BuildingStructureInfo {
  BuildingStructure1 buildingStructure1;
  BuildingStructure2 buildingStructure2;
  BuildingStructure3 buildingStructure3;
  BuildingStructure4 buildingStructure4;
  BuildingStructure5 buildingStructure5;

  BuildingStructureInfo(
      {this.buildingStructure1,
      this.buildingStructure2,
      this.buildingStructure3,
      this.buildingStructure4,
      this.buildingStructure5});

  BuildingStructureInfo.fromJson(Map<String, dynamic> json) {
    buildingStructure1 = json['building_structure_1'] != null
        ? new BuildingStructure1.fromJson(json['building_structure_1'])
        : null;
    buildingStructure2 = json['building_structure_2'] != null
        ? new BuildingStructure2.fromJson(json['building_structure_2'])
        : null;
    buildingStructure3 = json['building_structure_3'] != null
        ? new BuildingStructure3.fromJson(json['building_structure_3'])
        : null;
    buildingStructure4 = json['building_structure_4'] != null
        ? new BuildingStructure4.fromJson(json['building_structure_4'])
        : null;
    buildingStructure5 = json['building_structure_5'] != null
        ? new BuildingStructure5.fromJson(json['building_structure_5'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.buildingStructure1 != null) {
      data['building_structure_1'] = this.buildingStructure1.toJson();
    }
    if (this.buildingStructure2 != null) {
      data['building_structure_2'] = this.buildingStructure2.toJson();
    }
    if (this.buildingStructure3 != null) {
      data['building_structure_3'] = this.buildingStructure3.toJson();
    }
    if (this.buildingStructure4 != null) {
      data['building_structure_4'] = this.buildingStructure4.toJson();
    }
    if (this.buildingStructure5 != null) {
      data['building_structure_5'] = this.buildingStructure5.toJson();
    }
    return data;
  }
}

class BuildingStructure1 {
  String buildingStructure1Presence;
  String building1UsageType;
  String building1Category;
  String building1CatOther;
  String building1FloorCount;
  String building1Volume;

  BuildingStructure1(
      {this.buildingStructure1Presence,
      this.building1UsageType,
      this.building1Category,
      this.building1CatOther,
      this.building1FloorCount,
      this.building1Volume});

  BuildingStructure1.fromJson(Map<String, dynamic> json) {
    buildingStructure1Presence = json['building_structure_1_presence'];
    building1UsageType = json['building_1_usage_type'];
    building1Category = json['building_1_category'];
    building1CatOther = json['building_1_cat_other'];
    building1FloorCount = json['building_1_floor_count'];
    building1Volume = json['building_1_volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['building_structure_1_presence'] = this.buildingStructure1Presence;
    data['building_1_usage_type'] = this.building1UsageType;
    data['building_1_category'] = this.building1Category;
    data['building_1_cat_other'] = this.building1CatOther;
    data['building_1_floor_count'] = this.building1FloorCount;
    data['building_1_volume'] = this.building1Volume;
    return data;
  }
}

class BuildingStructure2 {
  String buildingStructure2Presence;
  String building2UsageType;
  String building2Category;
  String building2CatOther;
  String building2FloorCount;
  String building2Volume;

  BuildingStructure2(
      {this.buildingStructure2Presence,
      this.building2UsageType,
      this.building2Category,
      this.building2CatOther,
      this.building2FloorCount,
      this.building2Volume});

  BuildingStructure2.fromJson(Map<String, dynamic> json) {
    buildingStructure2Presence = json['building_structure_2_presence'];
    building2UsageType = json['building_2_usage_type'];
    building2Category = json['building_2_category'];
    building2CatOther = json['building_2_cat_other'];
    building2FloorCount = json['building_2_floor_count'];
    building2Volume = json['building_2_volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['building_structure_2_presence'] = this.buildingStructure2Presence;
    data['building_2_usage_type'] = this.building2UsageType;
    data['building_2_category'] = this.building2Category;
    data['building_2_cat_other'] = this.building2CatOther;
    data['building_2_floor_count'] = this.building2FloorCount;
    data['building_2_volume'] = this.building2Volume;
    return data;
  }
}

class BuildingStructure3 {
  String buildingStructure3Presence;
  String building3UsageType;
  String building3Category;
  String building3CatOther;
  String building3FloorCount;
  String building3Volume;

  BuildingStructure3(
      {this.buildingStructure3Presence,
      this.building3UsageType,
      this.building3Category,
      this.building3CatOther,
      this.building3FloorCount,
      this.building3Volume});

  BuildingStructure3.fromJson(Map<String, dynamic> json) {
    buildingStructure3Presence = json['building_structure_3_presence'];
    building3UsageType = json['building_3_usage_type'];
    building3Category = json['building_3_category'];
    building3CatOther = json['building_3_cat_other'];
    building3FloorCount = json['building_3_floor_count'];
    building3Volume = json['building_3_volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['building_structure_3_presence'] = this.buildingStructure3Presence;
    data['building_3_usage_type'] = this.building3UsageType;
    data['building_3_category'] = this.building3Category;
    data['building_3_cat_other'] = this.building3CatOther;
    data['building_3_floor_count'] = this.building3FloorCount;
    data['building_3_volume'] = this.building3Volume;
    return data;
  }
}

class BuildingStructure4 {
  String buildingStructure4Presence;
  String building4UsageType;
  String building4Category;
  String building4CatOther;
  String building4FloorCount;
  String building4Volume;

  BuildingStructure4(
      {this.buildingStructure4Presence,
      this.building4UsageType,
      this.building4Category,
      this.building4CatOther,
      this.building4FloorCount,
      this.building4Volume});

  BuildingStructure4.fromJson(Map<String, dynamic> json) {
    buildingStructure4Presence = json['building_structure_4_presence'];
    building4UsageType = json['building_4_usage_type'];
    building4Category = json['building_4_category'];
    building4CatOther = json['building_4_cat_other'];
    building4FloorCount = json['building_4_floor_count'];
    building4Volume = json['building_4_volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['building_structure_4_presence'] = this.buildingStructure4Presence;
    data['building_4_usage_type'] = this.building4UsageType;
    data['building_4_category'] = this.building4Category;
    data['building_4_cat_other'] = this.building4CatOther;
    data['building_4_floor_count'] = this.building4FloorCount;
    data['building_4_volume'] = this.building4Volume;
    return data;
  }
}

class BuildingStructure5 {
  String buildingStructure5Presence;
  String building5UsageType;
  String building5Category;
  String building5CatOther;
  String building5FloorCount;
  String building5Volume;

  BuildingStructure5(
      {this.buildingStructure5Presence,
      this.building5UsageType,
      this.building5Category,
      this.building5CatOther,
      this.building5FloorCount,
      this.building5Volume});

  BuildingStructure5.fromJson(Map<String, dynamic> json) {
    buildingStructure5Presence = json['building_structure_5_presence'];
    building5UsageType = json['building_5_usage_type'];
    building5Category = json['building_5_category'];
    building5CatOther = json['building_5_cat_other'];
    building5FloorCount = json['building_5_floor_count'];
    building5Volume = json['building_5_volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['building_structure_5_presence'] = this.buildingStructure5Presence;
    data['building_5_usage_type'] = this.building5UsageType;
    data['building_5_category'] = this.building5Category;
    data['building_5_cat_other'] = this.building5CatOther;
    data['building_5_floor_count'] = this.building5FloorCount;
    data['building_5_volume'] = this.building5Volume;
    return data;
  }
}

class UnitsInfo {
  String residentialArea;
  String commercialArea;
  String totalResidentialUnits;
  String totalCommercialUnits;

  UnitsInfo(
      {this.residentialArea,
      this.commercialArea,
      this.totalResidentialUnits,
      this.totalCommercialUnits});

  UnitsInfo.fromJson(Map<String, dynamic> json) {
    residentialArea = json['Residential_Area'];
    commercialArea = json['Commercial_Area'];
    totalResidentialUnits = json['Total_Residential_Units'];
    totalCommercialUnits = json['Total_Commercial_Units'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Residential_Area'] = this.residentialArea;
    data['Commercial_Area'] = this.commercialArea;
    data['Total_Residential_Units'] = this.totalResidentialUnits;
    data['Total_Commercial_Units'] = this.totalCommercialUnits;
    return data;
  }
}

class Meta {
  String instanceID;
  String sId;
  String sUuid;
  String sSubmissionTime;
  String sIndex;
  String sParentTableName;
  String sParentIndex;
  String sTags;
  String sNotes;

  Meta(
      {this.instanceID,
      this.sId,
      this.sUuid,
      this.sSubmissionTime,
      this.sIndex,
      this.sParentTableName,
      this.sParentIndex,
      this.sTags,
      this.sNotes});

  Meta.fromJson(Map<String, dynamic> json) {
    instanceID = json['instanceID'];
    sId = json['_id'];
    sUuid = json['_uuid'];
    sSubmissionTime = json['_submission_time'];
    sIndex = json['_index'];
    sParentTableName = json['_parent_table_name'];
    sParentIndex = json['_parent_index'];
    sTags = json['_tags'];
    sNotes = json['_notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instanceID'] = this.instanceID;
    data['_id'] = this.sId;
    data['_uuid'] = this.sUuid;
    data['_submission_time'] = this.sSubmissionTime;
    data['_index'] = this.sIndex;
    data['_parent_table_name'] = this.sParentTableName;
    data['_parent_index'] = this.sParentIndex;
    data['_tags'] = this.sTags;
    data['_notes'] = this.sNotes;
    return data;
  }
}