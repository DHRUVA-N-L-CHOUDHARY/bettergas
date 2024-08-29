import 'dart:convert';

import 'package:bettergas_assignment/app/data/remote/api_interface.dart';
import 'package:bettergas_assignment/app/data/remote/endpoints.dart';
import 'package:http/http.dart' as http;

import '../../service/helper/dialog_helper.dart';
import '../local/my_shared_pref.dart';

class ApiService extends ApiInterface {
  @override
  Future deleteApi(
      {String? url, Map<String, String>? headers, Map? data}) async {
    var client = http.Client();
    final response = await client.delete(
      Uri.parse(url!),
      headers: <String, String>{
        'accept': 'application/json',
        'content-type': 'application/json',
        'authorization': ApiInterface.auth!
      },
    );
    return response;
  }

  @override
  Future getApi({
    String? url,
    Map<String, String>? headers,
  }) async {
    var client = http.Client();
    print(url);
    final response = await client.get(Uri.parse(url!),
        headers: headers ??
            <String, String>{
              'accept': 'application/json',
              'content-type': 'application/json',
              'authorization': ApiInterface.auth!
            });
    return response;
  }

  @override
  Future postApi({String? url, Map<String, String>? headers, Map? data}) async {
    var client = http.Client();
    http.Response res = await client.post(Uri.parse(url!),
        headers: headers ??
            <String, String>{
              'content-type': 'application/json',
              'authorization': ApiInterface.auth!
            },
        body: jsonEncode(data));

    return res;
  }

  @override
  Future putApi({String? url, Map<String, String>? headers, Map? data}) async {
    var client = http.Client();
    final response = await client.put(Uri.parse(url!),
        headers: headers ??
            <String, String>{
              'accept': 'application/json',
              'content-type': 'application/json',
              'authorization': ApiInterface.auth!
            },
        body: jsonEncode(data));
    return response;
  }

  Map<String, dynamic>? _parseBaseResponse(http.Response res) {
    print("--------------------------------------");
    Map<String, dynamic> response = jsonDecode(res.body);
    print(response);
    if (response.containsKey("error")) {
      try {
        List entryList = response['error'].entries.toList();
        List<dynamic> errorList = [];
        entryList.forEach((element) {
          errorList.add(element.value.first);
        });
        DialogHelper.showErrorDialog("Error", errorList.join("\n"));
      } catch (e) {
        DialogHelper.showErrorDialog("Error", response['error']);
      }
      return null;
    } else {
      return response;
    }
  }

  Future<Map> createUserAccount(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.createCustomer, data: data);
    return _parseBaseResponse(res) ?? {};
  }

  Future<Map> loginUser(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.loginCustomer,
        data: data,
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
        });
    return _parseBaseResponse(res) ?? {};
  }

  Future<Map> signUp(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.register, data: data);
    return _parseBaseResponse(res) ?? {};
  }

  Future<Map> login(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.login,
        data: data,
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
        });
    return _parseBaseResponse(res) ?? {};
  }

  Future<String> forgotPassword(String email) async {
    http.Response res = await getApi(
        url: ApiInterface.baseUrl + Endpoints.forgotPassword + "?email=$email");

    return jsonDecode(res.body);
  }

  Future<http.Response> changePassword(String password, String userid) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl +
            Endpoints.updatePassword +
            "?user_id=$userid&password=$password");
    return res;
  }

  Future<String> getUserIdByEmail(String useremail) async {
    http.Response res = await getApi(
        url: ApiInterface.baseUrl + Endpoints.getUserId + "?email=$useremail");
    return res.body;
  }

  Future<Map<String, dynamic>> getUserDetails(String userid) async {
    http.Response res = await getApi(
        url: ApiInterface.baseUrl + Endpoints.getUserDetails + "/$userid",
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
          'authorization': ApiInterface.auth!
        });
    return _parseBaseResponse(res) ?? {};
  }

  Future<http.Response> updateUserDetails(
      Map<String, dynamic> data, String userId) async {
    http.Response res = await putApi(
      url: ApiInterface.baseUrl + Endpoints.getUserDetails + "/$userId",
      data: data,
    );
    return res;
  }

  Future<Map<String, dynamic>> deleteCustomer() async {
    http.Response res = await deleteApi(
        url: ApiInterface.baseUrl +
            Endpoints.getUserDetails +
            "/${MySharedPref.getUserId()}?force=true");
    return _parseBaseResponse(res) ?? {};
  }

  Future<Map<String, dynamic>> createOrdernotes(
      Map<String, dynamic> data, String orderid) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl +
            Endpoints.createOrder +
            "/$orderid" +
            Endpoints.ordernotes,
        data: data);
    return _parseBaseResponse(res) ?? {};
  }

  Future<Map<String, dynamic>> createOrder(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.createOrder, data: data);
    return _parseBaseResponse(res) ?? {};
  }

  Future<Map<String, dynamic>> updateOrder(
      Map<String, dynamic> data, String orderid) async {
    http.Response res = await putApi(
        url: ApiInterface.baseUrl + Endpoints.createOrder + "/$orderid",
        data: data);
    return _parseBaseResponse(res) ?? {};
  }

  Future<http.Response> getOrdersList(String orderlistCustoms) async {
    http.Response res = await getApi(
        url: ApiInterface.baseUrl + Endpoints.orders + orderlistCustoms,
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
          'authorization': ApiInterface.auth!
        });
    return res;
  }

  Future<http.Response> fetchProductsList() async {
    http.Response res = await getApi(
        url:
            "${ApiInterface.baseUrl}${Endpoints.getProducts}?consumer_key=${ApiInterface.consumer_key}&consumer_secret=${ApiInterface.consumer_secret}");
    return res;
  }

  Future<http.Response> getSearchNearByLoc(
      Map<String, dynamic> data, bool isSearch) async {
    if (!isSearch) {
      http.Response res = await postApi(
          url: ApiInterface.baseUrl +
              Endpoints.searchApiGetDatanearbyloc +
              "?lat=${data["lat"]}" +
              "&long=${data["long"]}" +
              "&distance=${data["distance"]}");
      return res;
    } else {
      http.Response res = await postApi(
          url: ApiInterface.baseUrl + Endpoints.searchApiGetDatanearbyloc,
          data: data);
      print(jsonDecode(res.body));
      return res;
    }
  }

  Future<http.Response> getAllSearchLocations(
      Map<String, dynamic> data, bool isSearch) async {
    if (!isSearch) {
      http.Response res = await postApi(
          url: ApiInterface.baseUrl +
              Endpoints.getSearchAllLocations +
              "?lat=${data["lat"]}" +
              "&long=${data["long"]}" +
              "&distance=${data["distance"]}");
      return res;
    } else {
      http.Response res = await postApi(
          url: ApiInterface.baseUrl + Endpoints.getAllLocations, data: data);
      return res;
    }
  }

  Future<http.Response> getAllLocations(int pagenumber) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.getAllLocations,
        data: {
          "page": pagenumber
        });
    return res;
  }
}
