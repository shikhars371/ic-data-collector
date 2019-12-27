class SafaiTax {
  String id;
  String pid;
  String year;
  String zonePrice;
  String structurePrice;
  String safaiUnitFee;
  String previousTax;
  String currentTax;
  String totalTax;
  String rebateDate;
  String taxBeforeRebate;
  String createdBy;
  String updatedBy;
  String ip;

  SafaiTax(
      {this.id,
      this.pid,
      this.year,
      this.zonePrice,
      this.structurePrice,
      this.safaiUnitFee,
      this.previousTax,
      this.currentTax,
      this.totalTax,
      this.rebateDate,
      this.taxBeforeRebate,
      this.createdBy,
      this.updatedBy,
      this.ip});

  SafaiTax.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        pid = json['pid'],
        year = json['year'],
        zonePrice = json['zone_price'],
        structurePrice = json['structure_price'],
        safaiUnitFee = json['safai_unit_fee'],
        previousTax = json['previous_tax'],
        currentTax = json['current_tax'],
        totalTax = json['total_tax'],
        rebateDate = json['rebate_date'],
        taxBeforeRebate = json['tax_before_rebate'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'pid': pid,
        'year': year,
        'zone_price': zonePrice,
        'structure_price': structurePrice,
        'safai_unit_fee': safaiUnitFee,
        'previous_tax': previousTax,
        'current_tax': currentTax,
        'total_tax': totalTax,
        'rebate_date': rebateDate,
        'tax_before_rebate': taxBeforeRebate,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
