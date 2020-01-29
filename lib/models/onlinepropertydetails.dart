// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

class Client {
    String id;
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
    Map<String, String> propertyPartnersInformation;
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
    DateTime end;
    DateTime today;
    DateTime deviceid;
    Meta meta;
    DateTime importDate;
    bool badHi;
    bool badSk;
    String otherNote;
    bool isCompleted;
    bool isValidated;
    bool isFinalized;
    bool flag;
    bool kMarea;
    String giSmap;
    String lan;
    String lon;
    String checker;
    String extra2;
    String region;
    String key;
    String status;
    String upin;

    Client({
        this.id,
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
        this.badHi,
        this.badSk,
        this.otherNote,
        this.isCompleted,
        this.isValidated,
        this.isFinalized,
        this.flag,
        this.kMarea,
        this.giSmap,
        this.lan,
        this.lon,
        this.checker,
        this.extra2,
        this.region,
        this.key,
        this.status,
        this.upin,
    });

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["_id"],
        surveyorsInfo: SurveyorsInfo.fromJson(json["surveyors_info"]),
        arguments1: Arguments1.fromJson(json["arguments_1"]),
        arguments2: Arguments2.fromJson(json["arguments_2"]),
        propertyPhysicalCondition: PropertyPhysicalCondition.fromJson(json["property_physical_condition"]),
        propertyPhysicalLocation: PropertyPhysicalLocation.fromJson(json["property_physical_location"]),
        zones: json["zones"],
        docPresenceState: json["doc_presence_state"],
        documentTypeInfo: json["document_type_info"],
        govermentalDocSpecification: GovermentalDocSpecification.fromJson(json["govermental_doc_specification"]),
        localDocSpecification: LocalDocSpecification.fromJson(json["local_doc_specification"]),
        propertyGivenUsageType: json["property_given_usage_type"],
        propertyOtherUsageType: json["property_other_usage_type"],
        propertyCurrentUsageType: json["property_current_usage_type"],
        usageRental: json["usage_rental"],
        usageBusiness: json["usage_business"],
        usageGovermental: json["usage_govermental"],
        usageOther: json["usage_other"],
        businessOtherType: json["business_other_type"],
        businessLicence: BusinessLicence.fromJson(json["business_licence"]),
        ownerOrFirstPartnerInfo: OwnerOrFirstPartnerInfo.fromJson(json["owner_or_first_partner_info"]),
        tazkiraInformation: TazkiraInformation.fromJson(json["tazkira_information"]),
        propertyPartnersInformation: Map.from(json["property_partners_information"]).map((k, v) => MapEntry<String, String>(k, v)),
        propertyBoundariesInfo: PropertyBoundariesInfo.fromJson(json["property_boundaries_info"]),
        electricityBillInfo: ElectricityBillInfo.fromJson(json["electricity_bill_info"]),
        sanitationBookletInfo: SanitationBookletInfo.fromJson(json["sanitation_booklet_info"]),
        propertyUserInfo: PropertyUserInfo.fromJson(json["property_user_info"]),
        otherOccupierType: json["other_occupier_type"],
        buildingStructureInfo: BuildingStructureInfo.fromJson(json["building_structure_info"]),
        sketch: json["Sketch"],
        houseImage: json["HouseImage"],
        code: json["code"],
        unitsInfo: UnitsInfo.fromJson(json["Units_Info"]),
        start: json["start"],
        end: DateTime.parse(json["end"]),
        today: DateTime.parse(json["Today"]),
        deviceid: DateTime.parse(json["deviceid"]),
        meta: Meta.fromJson(json["meta"]),
        importDate: DateTime.parse(json["importDate"]),
        badHi: json["badHI"],
        badSk: json["badSK"],
        otherNote: json["otherNote"],
        isCompleted: json["IsCompleted"],
        isValidated: json["IsValidated"],
        isFinalized: json["IsFinalized"],
        flag: json["Flag"],
        kMarea: json["KMarea"],
        giSmap: json["GISmap"],
        lan: json["lan"],
        lon: json["lon"],
        checker: json["checker"],
        extra2: json["extra2"],
        region: json["region"],
        key: json["key"],
        status: json["status"],
        upin: json["upin"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "surveyors_info": surveyorsInfo.toJson(),
        "arguments_1": arguments1.toJson(),
        "arguments_2": arguments2.toJson(),
        "property_physical_condition": propertyPhysicalCondition.toJson(),
        "property_physical_location": propertyPhysicalLocation.toJson(),
        "zones": zones,
        "doc_presence_state": docPresenceState,
        "document_type_info": documentTypeInfo,
        "govermental_doc_specification": govermentalDocSpecification.toJson(),
        "local_doc_specification": localDocSpecification.toJson(),
        "property_given_usage_type": propertyGivenUsageType,
        "property_other_usage_type": propertyOtherUsageType,
        "property_current_usage_type": propertyCurrentUsageType,
        "usage_rental": usageRental,
        "usage_business": usageBusiness,
        "usage_govermental": usageGovermental,
        "usage_other": usageOther,
        "business_other_type": businessOtherType,
        "business_licence": businessLicence.toJson(),
        "owner_or_first_partner_info": ownerOrFirstPartnerInfo.toJson(),
        "tazkira_information": tazkiraInformation.toJson(),
        "property_partners_information": Map.from(propertyPartnersInformation).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "property_boundaries_info": propertyBoundariesInfo.toJson(),
        "electricity_bill_info": electricityBillInfo.toJson(),
        "sanitation_booklet_info": sanitationBookletInfo.toJson(),
        "property_user_info": propertyUserInfo.toJson(),
        "other_occupier_type": otherOccupierType,
        "building_structure_info": buildingStructureInfo.toJson(),
        "Sketch": sketch,
        "HouseImage": houseImage,
        "code": code,
        "Units_Info": unitsInfo.toJson(),
        "start": start,
        "end": end.toIso8601String(),
        "Today": today.toIso8601String(),
        "deviceid": "${deviceid.year.toString().padLeft(4, '0')}-${deviceid.month.toString().padLeft(2, '0')}-${deviceid.day.toString().padLeft(2, '0')}",
        "meta": meta.toJson(),
        "importDate": "${importDate.year.toString().padLeft(4, '0')}-${importDate.month.toString().padLeft(2, '0')}-${importDate.day.toString().padLeft(2, '0')}",
        "badHI": badHi,
        "badSK": badSk,
        "otherNote": otherNote,
        "IsCompleted": isCompleted,
        "IsValidated": isValidated,
        "IsFinalized": isFinalized,
        "Flag": flag,
        "KMarea": kMarea,
        "GISmap": giSmap,
        "lan": lan,
        "lon": lon,
        "checker": checker,
        "extra2": extra2,
        "region": region,
        "key": key,
        "status": status,
        "upin": upin,
    };
}

class Arguments1 {
    String propertyArgument;
    String humanArgument;
    String tazkiraArgument;

    Arguments1({
        this.propertyArgument,
        this.humanArgument,
        this.tazkiraArgument,
    });

    factory Arguments1.fromJson(Map<String, dynamic> json) => Arguments1(
        propertyArgument: json["property_argument"],
        humanArgument: json["human_argument"],
        tazkiraArgument: json["tazkira_argument"],
    );

    Map<String, dynamic> toJson() => {
        "property_argument": propertyArgument,
        "human_argument": humanArgument,
        "tazkira_argument": tazkiraArgument,
    };
}

class Arguments2 {
    String propertyNote;
    String municipalityRegNo;
    String propertyEndangerment;

    Arguments2({
        this.propertyNote,
        this.municipalityRegNo,
        this.propertyEndangerment,
    });

    factory Arguments2.fromJson(Map<String, dynamic> json) => Arguments2(
        propertyNote: json["property_note"],
        municipalityRegNo: json["municipality_reg_no"],
        propertyEndangerment: json["property_endangerment"],
    );

    Map<String, dynamic> toJson() => {
        "property_note": propertyNote,
        "municipality_reg_no": municipalityRegNo,
        "property_endangerment": propertyEndangerment,
    };
}

class BuildingStructureInfo {
    BuildingStructure1 buildingStructure1;
    BuildingStructure2 buildingStructure2;
    BuildingStructure3 buildingStructure3;
    BuildingStructure4 buildingStructure4;
    BuildingStructure5 buildingStructure5;

    BuildingStructureInfo({
        this.buildingStructure1,
        this.buildingStructure2,
        this.buildingStructure3,
        this.buildingStructure4,
        this.buildingStructure5,
    });

    factory BuildingStructureInfo.fromJson(Map<String, dynamic> json) => BuildingStructureInfo(
        buildingStructure1: BuildingStructure1.fromJson(json["building_structure_1"]),
        buildingStructure2: BuildingStructure2.fromJson(json["building_structure_2"]),
        buildingStructure3: BuildingStructure3.fromJson(json["building_structure_3"]),
        buildingStructure4: BuildingStructure4.fromJson(json["building_structure_4"]),
        buildingStructure5: BuildingStructure5.fromJson(json["building_structure_5"]),
    );

    Map<String, dynamic> toJson() => {
        "building_structure_1": buildingStructure1.toJson(),
        "building_structure_2": buildingStructure2.toJson(),
        "building_structure_3": buildingStructure3.toJson(),
        "building_structure_4": buildingStructure4.toJson(),
        "building_structure_5": buildingStructure5.toJson(),
    };
}

class BuildingStructure1 {
    String buildingStructure1Presence;
    String building1UsageType;
    String building1Category;
    String building1CatOther;
    String building1FloorCount;
    String building1Volume;

    BuildingStructure1({
        this.buildingStructure1Presence,
        this.building1UsageType,
        this.building1Category,
        this.building1CatOther,
        this.building1FloorCount,
        this.building1Volume,
    });

    factory BuildingStructure1.fromJson(Map<String, dynamic> json) => BuildingStructure1(
        buildingStructure1Presence: json["building_structure_1_presence"],
        building1UsageType: json["building_1_usage_type"],
        building1Category: json["building_1_category"],
        building1CatOther: json["building_1_cat_other"],
        building1FloorCount: json["building_1_floor_count"],
        building1Volume: json["building_1_volume"],
    );

    Map<String, dynamic> toJson() => {
        "building_structure_1_presence": buildingStructure1Presence,
        "building_1_usage_type": building1UsageType,
        "building_1_category": building1Category,
        "building_1_cat_other": building1CatOther,
        "building_1_floor_count": building1FloorCount,
        "building_1_volume": building1Volume,
    };
}

class BuildingStructure2 {
    String buildingStructure2Presence;
    String building2UsageType;
    String building2Category;
    String building2CatOther;
    String building2FloorCount;
    String building2Volume;

    BuildingStructure2({
        this.buildingStructure2Presence,
        this.building2UsageType,
        this.building2Category,
        this.building2CatOther,
        this.building2FloorCount,
        this.building2Volume,
    });

    factory BuildingStructure2.fromJson(Map<String, dynamic> json) => BuildingStructure2(
        buildingStructure2Presence: json["building_structure_2_presence"],
        building2UsageType: json["building_2_usage_type"],
        building2Category: json["building_2_category"],
        building2CatOther: json["building_2_cat_other"],
        building2FloorCount: json["building_2_floor_count"],
        building2Volume: json["building_2_volume"],
    );

    Map<String, dynamic> toJson() => {
        "building_structure_2_presence": buildingStructure2Presence,
        "building_2_usage_type": building2UsageType,
        "building_2_category": building2Category,
        "building_2_cat_other": building2CatOther,
        "building_2_floor_count": building2FloorCount,
        "building_2_volume": building2Volume,
    };
}

class BuildingStructure3 {
    String buildingStructure3Presence;
    String building3UsageType;
    String building3Category;
    String building3CatOther;
    String building3FloorCount;
    String building3Volume;

    BuildingStructure3({
        this.buildingStructure3Presence,
        this.building3UsageType,
        this.building3Category,
        this.building3CatOther,
        this.building3FloorCount,
        this.building3Volume,
    });

    factory BuildingStructure3.fromJson(Map<String, dynamic> json) => BuildingStructure3(
        buildingStructure3Presence: json["building_structure_3_presence"],
        building3UsageType: json["building_3_usage_type"],
        building3Category: json["building_3_category"],
        building3CatOther: json["building_3_cat_other"],
        building3FloorCount: json["building_3_floor_count"],
        building3Volume: json["building_3_volume"],
    );

    Map<String, dynamic> toJson() => {
        "building_structure_3_presence": buildingStructure3Presence,
        "building_3_usage_type": building3UsageType,
        "building_3_category": building3Category,
        "building_3_cat_other": building3CatOther,
        "building_3_floor_count": building3FloorCount,
        "building_3_volume": building3Volume,
    };
}

class BuildingStructure4 {
    String buildingStructure4Presence;
    String building4UsageType;
    String building4Category;
    String building4CatOther;
    String building4FloorCount;
    String building4Volume;

    BuildingStructure4({
        this.buildingStructure4Presence,
        this.building4UsageType,
        this.building4Category,
        this.building4CatOther,
        this.building4FloorCount,
        this.building4Volume,
    });

    factory BuildingStructure4.fromJson(Map<String, dynamic> json) => BuildingStructure4(
        buildingStructure4Presence: json["building_structure_4_presence"],
        building4UsageType: json["building_4_usage_type"],
        building4Category: json["building_4_category"],
        building4CatOther: json["building_4_cat_other"],
        building4FloorCount: json["building_4_floor_count"],
        building4Volume: json["building_4_volume"],
    );

    Map<String, dynamic> toJson() => {
        "building_structure_4_presence": buildingStructure4Presence,
        "building_4_usage_type": building4UsageType,
        "building_4_category": building4Category,
        "building_4_cat_other": building4CatOther,
        "building_4_floor_count": building4FloorCount,
        "building_4_volume": building4Volume,
    };
}

class BuildingStructure5 {
    String buildingStructure5Presence;
    String building5UsageType;
    String building5Category;
    String building5CatOther;
    String building5FloorCount;
    String building5Volume;

    BuildingStructure5({
        this.buildingStructure5Presence,
        this.building5UsageType,
        this.building5Category,
        this.building5CatOther,
        this.building5FloorCount,
        this.building5Volume,
    });

    factory BuildingStructure5.fromJson(Map<String, dynamic> json) => BuildingStructure5(
        buildingStructure5Presence: json["building_structure_5_presence"],
        building5UsageType: json["building_5_usage_type"],
        building5Category: json["building_5_category"],
        building5CatOther: json["building_5_cat_other"],
        building5FloorCount: json["building_5_floor_count"],
        building5Volume: json["building_5_volume"],
    );

    Map<String, dynamic> toJson() => {
        "building_structure_5_presence": buildingStructure5Presence,
        "building_5_usage_type": building5UsageType,
        "building_5_category": building5Category,
        "building_5_cat_other": building5CatOther,
        "building_5_floor_count": building5FloorCount,
        "building_5_volume": building5Volume,
    };
}

class BusinessLicence {
    String unitsWithLicence;
    String unitsWithoutLicence;
    String other;

    BusinessLicence({
        this.unitsWithLicence,
        this.unitsWithoutLicence,
        this.other,
    });

    factory BusinessLicence.fromJson(Map<String, dynamic> json) => BusinessLicence(
        unitsWithLicence: json["units_with_licence"],
        unitsWithoutLicence: json["units_without_licence"],
        other: json["other"],
    );

    Map<String, dynamic> toJson() => {
        "units_with_licence": unitsWithLicence,
        "units_without_licence": unitsWithoutLicence,
        "other": other,
    };
}

class ElectricityBillInfo {
    String meterNo;
    String customerName;
    String cuntomerFatherName;
    String ebillImg;

    ElectricityBillInfo({
        this.meterNo,
        this.customerName,
        this.cuntomerFatherName,
        this.ebillImg,
    });

    factory ElectricityBillInfo.fromJson(Map<String, dynamic> json) => ElectricityBillInfo(
        meterNo: json["meter_no"],
        customerName: json["customer_name"],
        cuntomerFatherName: json["cuntomer_father_name"],
        ebillImg: json["ebill_img"],
    );

    Map<String, dynamic> toJson() => {
        "meter_no": meterNo,
        "customer_name": customerName,
        "cuntomer_father_name": cuntomerFatherName,
        "ebill_img": ebillImg,
    };
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

    GovermentalDocSpecification({
        this.docIssueDate,
        this.docIssuePlace,
        this.propertyRegNo,
        this.docVolumeNo,
        this.docPageNo,
        this.docRegNo,
        this.docPropertyArea,
        this.docImg1,
        this.docImg2,
        this.docImg3,
        this.docImg4,
    });

    factory GovermentalDocSpecification.fromJson(Map<String, dynamic> json) => GovermentalDocSpecification(
        docIssueDate: json["doc_issue_date"],
        docIssuePlace: json["doc_issue_place"],
        propertyRegNo: json["property_reg_no"],
        docVolumeNo: json["doc_volume_no"],
        docPageNo: json["doc_page_no"],
        docRegNo: json["doc_reg_no"],
        docPropertyArea: json["doc_property_area"],
        docImg1: json["doc_img_1"],
        docImg2: json["doc_img_2"],
        docImg3: json["doc_img_3"],
        docImg4: json["doc_img_4"],
    );

    Map<String, dynamic> toJson() => {
        "doc_issue_date": docIssueDate,
        "doc_issue_place": docIssuePlace,
        "property_reg_no": propertyRegNo,
        "doc_volume_no": docVolumeNo,
        "doc_page_no": docPageNo,
        "doc_reg_no": docRegNo,
        "doc_property_area": docPropertyArea,
        "doc_img_1": docImg1,
        "doc_img_2": docImg2,
        "doc_img_3": docImg3,
        "doc_img_4": docImg4,
    };
}

class LocalDocSpecification {
    String localDocImg1;
    String localDocImg2;

    LocalDocSpecification({
        this.localDocImg1,
        this.localDocImg2,
    });

    factory LocalDocSpecification.fromJson(Map<String, dynamic> json) => LocalDocSpecification(
        localDocImg1: json["local_doc_img_1"],
        localDocImg2: json["local_doc_img_2"],
    );

    Map<String, dynamic> toJson() => {
        "local_doc_img_1": localDocImg1,
        "local_doc_img_2": localDocImg2,
    };
}

class Meta {
    String instanceId;
    String id;
    String uuid;
    String submissionTime;
    String index;
    String parentTableName;
    String parentIndex;
    String tags;
    String notes;

    Meta({
        this.instanceId,
        this.id,
        this.uuid,
        this.submissionTime,
        this.index,
        this.parentTableName,
        this.parentIndex,
        this.tags,
        this.notes,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        instanceId: json["instanceID"],
        id: json["_id"],
        uuid: json["_uuid"],
        submissionTime: json["_submission_time"],
        index: json["_index"],
        parentTableName: json["_parent_table_name"],
        parentIndex: json["_parent_index"],
        tags: json["_tags"],
        notes: json["_notes"],
    );

    Map<String, dynamic> toJson() => {
        "instanceID": instanceId,
        "_id": id,
        "_uuid": uuid,
        "_submission_time": submissionTime,
        "_index": index,
        "_parent_table_name": parentTableName,
        "_parent_index": parentIndex,
        "_tags": tags,
        "_notes": notes,
    };
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

    OwnerOrFirstPartnerInfo({
        this.name,
        this.surname,
        this.fatherName,
        this.grandFatherName,
        this.gender,
        this.phoneNo,
        this.emal,
        this.photoPerson,
        this.notePerson,
    });

    factory OwnerOrFirstPartnerInfo.fromJson(Map<String, dynamic> json) => OwnerOrFirstPartnerInfo(
        name: json["name"],
        surname: json["surname"],
        fatherName: json["father_name"],
        grandFatherName: json["grand_father_name"],
        gender: json["gender"],
        phoneNo: json["phone_no"],
        emal: json["emal"],
        photoPerson: json["photo_person"],
        notePerson: json["note_person"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "father_name": fatherName,
        "grand_father_name": grandFatherName,
        "gender": gender,
        "phone_no": phoneNo,
        "emal": emal,
        "photo_person": photoPerson,
        "note_person": notePerson,
    };
}

class PropertyBoundariesInfo {
    String boundaryNote;
    String east;
    String west;
    String south;
    String north;

    PropertyBoundariesInfo({
        this.boundaryNote,
        this.east,
        this.west,
        this.south,
        this.north,
    });

    factory PropertyBoundariesInfo.fromJson(Map<String, dynamic> json) => PropertyBoundariesInfo(
        boundaryNote: json["boundary_note"],
        east: json["East"],
        west: json["West"],
        south: json["South"],
        north: json["North"],
    );

    Map<String, dynamic> toJson() => {
        "boundary_note": boundaryNote,
        "East": east,
        "West": west,
        "South": south,
        "North": north,
    };
}

class PropertyPhysicalCondition {
    String plannedUnplanned;
    String formalInformal;
    String regularIrregular;
    String slope;

    PropertyPhysicalCondition({
        this.plannedUnplanned,
        this.formalInformal,
        this.regularIrregular,
        this.slope,
    });

    factory PropertyPhysicalCondition.fromJson(Map<String, dynamic> json) => PropertyPhysicalCondition(
        plannedUnplanned: json["planned_unplanned"],
        formalInformal: json["formal_informal"],
        regularIrregular: json["regular_irregular"],
        slope: json["slope"],
    );

    Map<String, dynamic> toJson() => {
        "planned_unplanned": plannedUnplanned,
        "formal_informal": formalInformal,
        "regular_irregular": regularIrregular,
        "slope": slope,
    };
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

    PropertyPhysicalLocation({
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
    });

    factory PropertyPhysicalLocation.fromJson(Map<String, dynamic> json) => PropertyPhysicalLocation(
        provinceId: json["province_id"],
        municipalityId: json["municipality_id"],
        nahiaId: json["nahia_id"],
        guzarId: json["guzar_id"],
        blockId: json["block_id"],
        parcelNo: json["parcel_no"],
        unitNo: json["unit_no"],
        noUnitInParcel: json["no_unit_in_parcel"],
        roadName: json["road_name"],
        historicalValue: json["historical_value"],
        parcelArea: json["parcel_area"],
        ownershipType: json["ownership_type"],
    );

    Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "municipality_id": municipalityId,
        "nahia_id": nahiaId,
        "guzar_id": guzarId,
        "block_id": blockId,
        "parcel_no": parcelNo,
        "unit_no": unitNo,
        "no_unit_in_parcel": noUnitInParcel,
        "road_name": roadName,
        "historical_value": historicalValue,
        "parcel_area": parcelArea,
        "ownership_type": ownershipType,
    };
}

class PropertyUserInfo {
    String ownerOccupier;
    String rentalOccupier;
    String mortagageOccupier;
    String otherOccupier;

    PropertyUserInfo({
        this.ownerOccupier,
        this.rentalOccupier,
        this.mortagageOccupier,
        this.otherOccupier,
    });

    factory PropertyUserInfo.fromJson(Map<String, dynamic> json) => PropertyUserInfo(
        ownerOccupier: json["owner_occupier"],
        rentalOccupier: json["rental_occupier"],
        mortagageOccupier: json["mortagage_occupier"],
        otherOccupier: json["other_occupier"],
    );

    Map<String, dynamic> toJson() => {
        "owner_occupier": ownerOccupier,
        "rental_occupier": rentalOccupier,
        "mortagage_occupier": mortagageOccupier,
        "other_occupier": otherOccupier,
    };
}

class SanitationBookletInfo {
    String custName;
    String custFatherName;
    String sanitationBookletSerialNo;
    String issueDate;
    String sanitationBookletImg;

    SanitationBookletInfo({
        this.custName,
        this.custFatherName,
        this.sanitationBookletSerialNo,
        this.issueDate,
        this.sanitationBookletImg,
    });

    factory SanitationBookletInfo.fromJson(Map<String, dynamic> json) => SanitationBookletInfo(
        custName: json["cust_name"],
        custFatherName: json["cust_father_name"],
        sanitationBookletSerialNo: json["sanitation_booklet_serial_no"],
        issueDate: json["issue_date"],
        sanitationBookletImg: json["sanitation_booklet_img"],
    );

    Map<String, dynamic> toJson() => {
        "cust_name": custName,
        "cust_father_name": custFatherName,
        "sanitation_booklet_serial_no": sanitationBookletSerialNo,
        "issue_date": issueDate,
        "sanitation_booklet_img": sanitationBookletImg,
    };
}

class SurveyorsInfo {
    String surveyor1;
    String surveyor2;
    String supportingSurveyor;

    SurveyorsInfo({
        this.surveyor1,
        this.surveyor2,
        this.supportingSurveyor,
    });

    factory SurveyorsInfo.fromJson(Map<String, dynamic> json) => SurveyorsInfo(
        surveyor1: json["surveyor_1"],
        surveyor2: json["surveyor_2"],
        supportingSurveyor: json["supporting_surveyor"],
    );

    Map<String, dynamic> toJson() => {
        "surveyor_1": surveyor1,
        "surveyor_2": surveyor2,
        "supporting_surveyor": supportingSurveyor,
    };
}

class TazkiraInformation {
    String tazkiraSerialNo;
    String tazkiraVolumeNo;
    String tazkiraPageNo;
    String tazkiraRegNo;
    String tazkiraImage1;
    String tazkiraImage2;
    String tazkiraImage3;

    TazkiraInformation({
        this.tazkiraSerialNo,
        this.tazkiraVolumeNo,
        this.tazkiraPageNo,
        this.tazkiraRegNo,
        this.tazkiraImage1,
        this.tazkiraImage2,
        this.tazkiraImage3,
    });

    factory TazkiraInformation.fromJson(Map<String, dynamic> json) => TazkiraInformation(
        tazkiraSerialNo: json["tazkira_serial_no"],
        tazkiraVolumeNo: json["tazkira_volume_no"],
        tazkiraPageNo: json["tazkira_page_no"],
        tazkiraRegNo: json["tazkira_reg_no"],
        tazkiraImage1: json["tazkira_image_1"],
        tazkiraImage2: json["tazkira_image_2"],
        tazkiraImage3: json["tazkira_image_3"],
    );

    Map<String, dynamic> toJson() => {
        "tazkira_serial_no": tazkiraSerialNo,
        "tazkira_volume_no": tazkiraVolumeNo,
        "tazkira_page_no": tazkiraPageNo,
        "tazkira_reg_no": tazkiraRegNo,
        "tazkira_image_1": tazkiraImage1,
        "tazkira_image_2": tazkiraImage2,
        "tazkira_image_3": tazkiraImage3,
    };
}

class UnitsInfo {
    String residentialArea;
    String commercialArea;
    String totalResidentialUnits;
    String totalCommercialUnits;

    UnitsInfo({
        this.residentialArea,
        this.commercialArea,
        this.totalResidentialUnits,
        this.totalCommercialUnits,
    });

    factory UnitsInfo.fromJson(Map<String, dynamic> json) => UnitsInfo(
        residentialArea: json["Residential_Area"],
        commercialArea: json["Commercial_Area"],
        totalResidentialUnits: json["Total_Residential_Units"],
        totalCommercialUnits: json["Total_Commercial_Units"],
    );

    Map<String, dynamic> toJson() => {
        "Residential_Area": residentialArea,
        "Commercial_Area": commercialArea,
        "Total_Residential_Units": totalResidentialUnits,
        "Total_Commercial_Units": totalCommercialUnits,
    };
}
