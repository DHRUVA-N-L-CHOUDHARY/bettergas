import 'dart:convert';

import 'package:bettergas_assignment/app/data/remote/paystack/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../service/helper/dialog_helper.dart';
import 'paystack_interface.dart';

class PayStackService extends PayStackInterface {
  @override
  Future deleteApi(
      {String? url, Map<String, String>? headers, Map? data}) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.delete(Uri.parse(url!),
        headers: <String, String>{
          'accept': 'application/json',
          'content-type': 'application/json',
          'authorization': PayStackInterface.auth!
        },
        body: jsonEncode(data));
    responseJson = jsonDecode(response.body);
    return responseJson;
  }

  @override
  Future getApi({
    String? url,
    Map<String, String>? headers,
  }) async {
    var client = http.Client();
    final response =
        await client.get(Uri.parse(url!), headers: <String, String>{
      'accept': 'application/json',
      'content-type': 'application/json',
      'authorization': PayStackInterface.auth!
    });
    return response;
  }

  @override
  Future postApi({String? url, Map<String, String>? headers, Map? data}) async {
    var client = http.Client();
    print(data);
    // if (MySharedPref.getToken() != null) {
    //   data = data ?? {};
    //   data['token'] = MySharedPref.getToken();
    //   data['user_id'] = MySharedPref.getUserId();
    // }
    http.Response res = await client.post(Uri.parse(url!),
        headers: headers ??
            <String, String>{
              'content-type': 'application/json',
              'authorization': PayStackInterface.auth!
            },
        body: jsonEncode(data));

    return res;
  }

  @override
  Future putApi({String? url, Map<String, String>? headers, Map? data}) async {
    var client = http.Client();
    dynamic responseJson;
    final response = await client.put(Uri.parse(url!),
        headers: headers ??
            <String, String>{
              'accept': 'application/json',
              'content-type': 'application/json',
              'authorization': PayStackInterface.auth!
            },
        body: jsonEncode(data));
    responseJson = jsonDecode(response.body);
    return responseJson;
  }

  Map<String, dynamic>? _parseBaseResponse(http.Response res) {
    debugPrint(jsonEncode(res.body));
    Map<String, dynamic> response = jsonDecode(res.body);
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

// Intialize Transaction
  Future<Map<String, dynamic>> initializeTransaction(
      Map<String, dynamic> data) async {
    http.Response res = await PayStackService().postApi(
      url: PayStackInterface.baseUrl + PayStackEndpoints.initializeTransaction,
      data: data,
    );
    return _parseBaseResponse(res) ?? {};
  }

  // Verify Transaction after Customer makes payment
  Future<Map> verifyTransaction(String refrence) async {
    http.Response res = await PayStackService().getApi(
      url: PayStackInterface.baseUrl +
          PayStackEndpoints.verifyTransaction +
          "/$refrence",
    );
    return _parseBaseResponse(res) ?? {};
  }

  Future<http.Response> listAllTransactions() async {
    http.Response res = await PayStackService().getApi(
      url: PayStackInterface.baseUrl + PayStackEndpoints.transaction,
    );
    return res;
  }
}
