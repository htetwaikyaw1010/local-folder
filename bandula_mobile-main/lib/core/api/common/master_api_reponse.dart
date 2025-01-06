import 'dart:convert';

import 'package:http/http.dart';

class MasterApiResponse {
  MasterApiResponse(Response response) {
    code = response.statusCode;

    if (isSuccessful) {
      body = response.body;
      errorMessage = '';
    } else if (totallyNoRecord) {
      //Create Error Message(TOTALLY_NO_RECORD##totally no record)
      body = null;
      errorMessage = '##' 'totally no record';
    } else {
      body = null;
      try {
        final dynamic hashMap = json.decode(response.body);
        print(hashMap['message']);
        errorMessage = hashMap['message'];
      } catch (error) {
        print('Timeout Error');
        errorMessage = 'Timeout Error';
      }
    }
  }
  int code = 0;
  String? body;
  String errorMessage = '';

  bool get isSuccessful {
    return code == 200 || code == 201; // between 200 and 300 (before)
  }

  bool get totallyNoRecord {
    return code == 204;
  }

  /**
   * 200, 201 --> Success
   * 200 with black array [ ] --> No data at pagination
   * 204  --> Totally No Record
   * 
   */
}

ApiBaseResponse apiResponseFromJson(String str) =>
    ApiBaseResponse.fromJson(json.decode(str));

class ApiBaseResponse {
  ApiBaseResponse({this.message, this.response});

  dynamic message;
  dynamic response;

  factory ApiBaseResponse.fromJson(Map<String, dynamic> json) =>
      ApiBaseResponse(message: json["message"], response: json["data"]);
}
