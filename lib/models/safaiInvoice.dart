class SafaiInvoice {
  String id;
  String pid;
  String invoiceNo;
  String printStatus;
  String bankName;
  String branchName;
  String invDate;
  String createdBy;
  String updatedBy;
  String ip;

  SafaiInvoice(
      {this.id,
      this.pid,
      this.invoiceNo,
      this.printStatus,
      this.bankName,
      this.branchName,
      this.invDate,
      this.createdBy,
      this.updatedBy,
      this.ip});

  SafaiInvoice.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        pid = json['pid'],
        invoiceNo = json['invoice_no'],
        printStatus = json['print_status'],
        bankName = json['bank_name'],
        branchName = json['branch_name'],
        invDate = json['inv_date'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'pid': pid,
        'invoice_no': invoiceNo,
        'print_status': printStatus,
        'bank_name': bankName,
        'branch_name': branchName,
        'inv_date': invDate,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
