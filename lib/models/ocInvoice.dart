class OcInvoice {
  String id;
  String pid;
  String invoiceNo;
  String amount;
  String printStatus;
  String ocPaperPrice;
  String bankName;
  String branchName;
  String landZonePrice;
  String createdBy;
  String updatedBy;
  String ip;

  OcInvoice(
      {this.id,
      this.pid,
      this.invoiceNo,
      this.amount,
      this.printStatus,
      this.ocPaperPrice,
      this.bankName,
      this.branchName,
      this.landZonePrice,
      this.createdBy,
      this.updatedBy,
      this.ip});

  OcInvoice.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        pid = json['pid'],
        invoiceNo = json['invoice_no'],
        amount = json['amount'],
        printStatus = json['print_status'],
        ocPaperPrice = json['oc_paper_price'],
        bankName = json['bank_name'],
        branchName = json['branch_name'],
        landZonePrice = json['land_zone_price'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'pid': pid,
        'invoice_no': invoiceNo,
        'amount': amount,
        'print_status': printStatus,
        'oc_paper_price': ocPaperPrice,
        'bank_name': bankName,
        'branch_name': branchName,
        'land_zone_price': landZonePrice,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
