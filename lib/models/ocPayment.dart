class OcPayment {
  String id;
  String pid;
  String invoiceNo;
  String bankName;
  String branch;
  String paidAmount;
  String paymentDate;
  String bankTransNo;
  String payeeName;
  String paymentStatus;
  String createdBy;
  String updatedBy;
  String ip;

  OcPayment(
      {this.id,
      this.pid,
      this.invoiceNo,
      this.bankName,
      this.branch,
      this.paidAmount,
      this.paymentDate,
      this.bankTransNo,
      this.payeeName,
      this.paymentStatus,
      this.createdBy,
      this.updatedBy,
      this.ip});

  OcPayment.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        pid = json['pid'],
        invoiceNo = json['invoice_no'],
        bankName = json['bank_name'],
        branch = json['branch'],
        paidAmount = json['paid_amount'],
        paymentDate = json['payment_date'],
        bankTransNo = json['bank_trans_no'],
        payeeName = json['payee_name'],
        paymentStatus = json['payment_status'],
        createdBy = json['created_by'],
        updatedBy = json['upated_by'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'pid': pid,
        'invoice_no': invoiceNo,
        'bank_name': bankName,
        'branch': branch,
        'paid_amount': paidAmount,
        'payment_date': paymentDate,
        'bank_trans_no': bankTransNo,
        'payee_name': payeeName,
        'payment_status': paymentStatus,
        'craeted_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}
