class PayStackAuthModel {
  String? authorizationUrl;
  String? accessCode;
  String? reference;

  PayStackAuthModel({this.authorizationUrl, this.accessCode, this.reference});

  PayStackAuthModel.fromJson(Map<String, dynamic> json) {
    authorizationUrl = json['authorization_url'];
    accessCode = json['access_code'];
    reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authorization_url'] = this.authorizationUrl;
    data['access_code'] = this.accessCode;
    data['reference'] = this.reference;
    return data;
  }
}
