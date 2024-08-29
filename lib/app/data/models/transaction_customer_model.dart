class TransactionCustomerModel {
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  int? integration;
  String? domain;
  String? customerCode;
  int? id;
  bool? identified;

  TransactionCustomerModel(
      {this.email,
      this.firstName,
      this.lastName,
      this.phone,
      this.integration,
      this.domain,
      this.customerCode,
      this.id,
      this.identified});

  TransactionCustomerModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    integration = json['integration'];
    domain = json['domain'];
    customerCode = json['customer_code'];
    id = json['id'];
    identified = json['identified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['integration'] = this.integration;
    data['domain'] = this.domain;
    data['customer_code'] = this.customerCode;
    data['id'] = this.id;
    data['identified'] = this.identified;
    return data;
  }
}
