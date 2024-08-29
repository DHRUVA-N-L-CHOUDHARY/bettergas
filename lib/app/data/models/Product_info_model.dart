class ProductInfoModel {
  String? variationId;
  String? displayPrice;
  String? weight;

  ProductInfoModel({this.variationId, this.displayPrice, this.weight});

 ProductInfoModel.fromJson(Map<String, dynamic> json) {
    variationId = json['variation_id'];
    displayPrice = json['display_price'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variation_id'] = this.variationId;
    data['display_price'] = this.displayPrice;
    data['weight'] = this.weight;
    return data;
  }
}