
abstract class PayStackInterface {
  static String paystack_secret = 'sk_test_286bbc7458e4ac2553e73fa426f61deb108be7ee';
  static const baseUrl = "https://api.paystack.co";

  static String? auth =
      'Bearer ${paystack_secret}';

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
