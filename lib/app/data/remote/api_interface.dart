import 'dart:convert';

abstract class ApiInterface {
  //static const oldbaseUrl = "https://wahine.netgains.org/api/";
  //static const oldimgPath = "https://wahine.netgains.org/";
  static String consumer_key = 'ck_4b39fe705845fa1c15eaa52dddef64780a15e836';
  static String consumer_secret = 'cs_4231a5956e8f077a5d00ae9af568684ed696d8bf';
  static const baseUrl = "https://bettergas.com/new/wp-json";
  static const imgPath = "https://bettergas.com/new/wp-json";

  static String? auth =
      'Basic ${base64.encode(utf8.encode('$consumer_key:$consumer_secret'))}';

  Future getApi({
    String? url,
    Map<String, String>? headers,
  });

  Future postApi({
    String? url,
    Map<String, String>? headers,
    Map? data,
  });

  Future putApi({
    String? url,
    Map<String, String>? headers,
    Map? data,
  });

  Future deleteApi({
    String? url,
    Map<String, String>? headers,
    Map? data,
  });
}
