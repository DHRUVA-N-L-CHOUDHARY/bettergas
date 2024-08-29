class OrdersModel {
  int? totalOrders;
  int? maxPages;
  String? currentPage;
  List<Data>? data;

  OrdersModel({this.totalOrders, this.maxPages, this.currentPage, this.data});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    totalOrders = json["total_orders"];
    maxPages = json["max_pages"];
    currentPage = json["current_page"];
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["total_orders"] = totalOrders;
    _data["max_pages"] = maxPages;
    _data["current_page"] = currentPage;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Data {
  int? id;
  int? parentId;
  String? status;
  String? currency;
  String? version;
  bool? pricesIncludeTax;
  DateCreated? dateCreated;
  DateModified? dateModified;
  String? discountTotal;
  String? discountTax;
  String? shippingTotal;
  String? shippingTax;
  String? cartTax;
  String? total;
  String? totalTax;
  int? customerId;
  String? orderKey;
  Billing? billing;
  Shipping? shipping;
  String? paymentMethod;
  String? paymentMethodTitle;
  String? transactionId;
  String? customerIpAddress;
  String? customerUserAgent;
  String? createdVia;
  String? customerNote;
  DateCompleted? dateCompleted;
  DatePaid? datePaid;
  String? cartHash;
  bool? orderStockReduced;
  bool? downloadPermissionsGranted;
  bool? newOrderEmailSent;
  bool? recordedSales;
  bool? recordedCouponUsageCounts;
  String? number;
  List<MetaData>? metaData;
  List<dynamic>? taxLines;
  List<dynamic>? shippingLines;
  List<dynamic>? feeLines;
  List<dynamic>? couponLines;
  String? locationId;
  String? location;
  String? productType;

  Data(
      {this.id,
      this.parentId,
      this.status,
      this.currency,
      this.version,
      this.pricesIncludeTax,
      this.dateCreated,
      this.dateModified,
      this.discountTotal,
      this.discountTax,
      this.shippingTotal,
      this.shippingTax,
      this.cartTax,
      this.total,
      this.totalTax,
      this.customerId,
      this.orderKey,
      this.billing,
      this.shipping,
      this.paymentMethod,
      this.paymentMethodTitle,
      this.transactionId,
      this.customerIpAddress,
      this.customerUserAgent,
      this.createdVia,
      this.customerNote,
      this.dateCompleted,
      this.datePaid,
      this.cartHash,
      this.orderStockReduced,
      this.downloadPermissionsGranted,
      this.newOrderEmailSent,
      this.recordedSales,
      this.recordedCouponUsageCounts,
      this.number,
      this.metaData,
      this.taxLines,
      this.shippingLines,
      this.feeLines,
      this.couponLines,
      this.locationId,
      this.location,
      this.productType});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    parentId = json["parent_id"];
    status = json["status"];
    currency = json["currency"];
    version = json["version"];
    pricesIncludeTax = json["prices_include_tax"];
    dateCreated = json["date_created"] == null
        ? null
        : DateCreated.fromJson(json["date_created"]);
    dateModified = json["date_modified"] == null
        ? null
        : DateModified.fromJson(json["date_modified"]);
    discountTotal = json["discount_total"];
    discountTax = json["discount_tax"];
    shippingTotal = json["shipping_total"];
    shippingTax = json["shipping_tax"];
    cartTax = json["cart_tax"];
    total = json["total"];
    totalTax = json["total_tax"];
    customerId = json["customer_id"];
    orderKey = json["order_key"];
    billing =
        json["billing"] == null ? null : Billing.fromJson(json["billing"]);
    shipping =
        json["shipping"] == null ? null : Shipping.fromJson(json["shipping"]);
    paymentMethod = json["payment_method"];
    paymentMethodTitle = json["payment_method_title"];
    transactionId = json["transaction_id"];
    customerIpAddress = json["customer_ip_address"];
    customerUserAgent = json["customer_user_agent"];
    createdVia = json["created_via"];
    customerNote = json["customer_note"];
    dateCompleted = json["date_completed"] == null
        ? null
        : DateCompleted.fromJson(json["date_completed"]);
    datePaid =
        json["date_paid"] == null ? null : DatePaid.fromJson(json["date_paid"]);
    cartHash = json["cart_hash"];
    orderStockReduced = json["order_stock_reduced"];
    downloadPermissionsGranted = json["download_permissions_granted"];
    newOrderEmailSent = json["new_order_email_sent"];
    recordedSales = json["recorded_sales"];
    recordedCouponUsageCounts = json["recorded_coupon_usage_counts"];
    number = json["number"];
    metaData = json["meta_data"] == null
        ? null
        : (json["meta_data"] as List).map((e) => MetaData.fromJson(e)).toList();
    taxLines = json["tax_lines"] ?? [];
    shippingLines = json["shipping_lines"] ?? [];
    feeLines = json["fee_lines"] ?? [];
    couponLines = json["coupon_lines"] ?? [];
    locationId = json["location_id"];
    location = json["location"];
    productType = json["product_type"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["parent_id"] = parentId;
    _data["status"] = status;
    _data["currency"] = currency;
    _data["version"] = version;
    _data["prices_include_tax"] = pricesIncludeTax;
    if (dateCreated != null) {
      _data["date_created"] = dateCreated?.toJson();
    }
    if (dateModified != null) {
      _data["date_modified"] = dateModified?.toJson();
    }
    _data["discount_total"] = discountTotal;
    _data["discount_tax"] = discountTax;
    _data["shipping_total"] = shippingTotal;
    _data["shipping_tax"] = shippingTax;
    _data["cart_tax"] = cartTax;
    _data["total"] = total;
    _data["total_tax"] = totalTax;
    _data["customer_id"] = customerId;
    _data["order_key"] = orderKey;
    if (billing != null) {
      _data["billing"] = billing?.toJson();
    }
    if (shipping != null) {
      _data["shipping"] = shipping?.toJson();
    }
    _data["payment_method"] = paymentMethod;
    _data["payment_method_title"] = paymentMethodTitle;
    _data["transaction_id"] = transactionId;
    _data["customer_ip_address"] = customerIpAddress;
    _data["customer_user_agent"] = customerUserAgent;
    _data["created_via"] = createdVia;
    _data["customer_note"] = customerNote;
    if (dateCompleted != null) {
      _data["date_completed"] = dateCompleted?.toJson();
    }
    if (datePaid != null) {
      _data["date_paid"] = datePaid?.toJson();
    }
    _data["cart_hash"] = cartHash;
    _data["order_stock_reduced"] = orderStockReduced;
    _data["download_permissions_granted"] = downloadPermissionsGranted;
    _data["new_order_email_sent"] = newOrderEmailSent;
    _data["recorded_sales"] = recordedSales;
    _data["recorded_coupon_usage_counts"] = recordedCouponUsageCounts;
    _data["number"] = number;
    if (metaData != null) {
      _data["meta_data"] = metaData?.map((e) => e.toJson()).toList();
    }
    if (taxLines != null) {
      _data["tax_lines"] = taxLines;
    }
    if (shippingLines != null) {
      _data["shipping_lines"] = shippingLines;
    }
    if (feeLines != null) {
      _data["fee_lines"] = feeLines;
    }
    if (couponLines != null) {
      _data["coupon_lines"] = couponLines;
    }
    _data["location_id"] = locationId;
    _data["location"] = location;
    _data["product_type"] = productType;
    return _data;
  }
}

class MetaData {
  int? id;
  String? key;
  String? value;

  MetaData({this.id, this.key, this.value});

  MetaData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    key = json["key"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["key"] = key;
    _data["value"] = value;
    return _data;
  }
}

class DatePaid {
  String? date;
  int? timezoneType;
  String? timezone;

  DatePaid({this.date, this.timezoneType, this.timezone});

  DatePaid.fromJson(Map<String, dynamic> json) {
    date = json["date"];
    timezoneType = json["timezone_type"];
    timezone = json["timezone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["date"] = date;
    _data["timezone_type"] = timezoneType;
    _data["timezone"] = timezone;
    return _data;
  }
}

class DateCompleted {
  String? date;
  int? timezoneType;
  String? timezone;

  DateCompleted({this.date, this.timezoneType, this.timezone});

  DateCompleted.fromJson(Map<String, dynamic> json) {
    date = json["date"];
    timezoneType = json["timezone_type"];
    timezone = json["timezone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["date"] = date;
    _data["timezone_type"] = timezoneType;
    _data["timezone"] = timezone;
    return _data;
  }
}

class Shipping {
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? phone;

  Shipping(
      {this.firstName,
      this.lastName,
      this.company,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postcode,
      this.country,
      this.phone});

  Shipping.fromJson(Map<String, dynamic> json) {
    firstName = json["first_name"];
    lastName = json["last_name"];
    company = json["company"];
    address1 = json["address_1"];
    address2 = json["address_2"];
    city = json["city"];
    state = json["state"];
    postcode = json["postcode"];
    country = json["country"];
    phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["first_name"] = firstName;
    _data["last_name"] = lastName;
    _data["company"] = company;
    _data["address_1"] = address1;
    _data["address_2"] = address2;
    _data["city"] = city;
    _data["state"] = state;
    _data["postcode"] = postcode;
    _data["country"] = country;
    _data["phone"] = phone;
    return _data;
  }
}

class Billing {
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? email;
  String? phone;

  Billing(
      {this.firstName,
      this.lastName,
      this.company,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postcode,
      this.country,
      this.email,
      this.phone});

  Billing.fromJson(Map<String, dynamic> json) {
    firstName = json["first_name"];
    lastName = json["last_name"];
    company = json["company"];
    address1 = json["address_1"];
    address2 = json["address_2"];
    city = json["city"];
    state = json["state"];
    postcode = json["postcode"];
    country = json["country"];
    email = json["email"];
    phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["first_name"] = firstName;
    _data["last_name"] = lastName;
    _data["company"] = company;
    _data["address_1"] = address1;
    _data["address_2"] = address2;
    _data["city"] = city;
    _data["state"] = state;
    _data["postcode"] = postcode;
    _data["country"] = country;
    _data["email"] = email;
    _data["phone"] = phone;
    return _data;
  }
}

class DateModified {
  String? date;
  int? timezoneType;
  String? timezone;

  DateModified({this.date, this.timezoneType, this.timezone});

  DateModified.fromJson(Map<String, dynamic> json) {
    date = json["date"];
    timezoneType = json["timezone_type"];
    timezone = json["timezone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["date"] = date;
    _data["timezone_type"] = timezoneType;
    _data["timezone"] = timezone;
    return _data;
  }
}

class DateCreated {
  String? date;
  int? timezoneType;
  String? timezone;

  DateCreated({this.date, this.timezoneType, this.timezone});

  DateCreated.fromJson(Map<String, dynamic> json) {
    date = json["date"];
    timezoneType = json["timezone_type"];
    timezone = json["timezone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["date"] = date;
    _data["timezone_type"] = timezoneType;
    _data["timezone"] = timezone;
    return _data;
  }
}
