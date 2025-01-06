// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../../config/master_config.dart';
import '../../viewobject/common/master_object.dart';
import 'master_api_reponse.dart';
import 'master_resource.dart';
import 'master_status.dart';

abstract class MasterApi {
  MasterResource<T> masterObjectConvert<T>(dynamic dataList, T data) {
    return MasterResource<T>(dataList.status, dataList.message, data);
  }

  // Future<List<dynamic>> getList(String url) async {
  //   final Client client = http.Client();
  //   try {
  //     final Response response = await client.get('${MasterConfig.Master_app_url}$url');

  //     if (response.statusCode == 200 &&
  //         response.body != null &&
  //         response.body != '') {
  //       // parse into List
  //       final List<dynamic> parsed = json.decode(response.body);

  //       //posts.addAll(SubCategory().fromJsonList(parsed));

  //       return parsed;
  //     } else {
  //       throw Exception('Error in loading...');
  //     }
  //   } finally {
  //     client.close();
  //   }
  // }

  void printGetLog(MasterApiResponse psApiResponse, http.Response response) {
    const String success = '✅';
    const String failed = '❌';
    print(' ');
    print(
        '____________________________________________________________________________________________');
    print('\u001b[33m GET    --> ${response.request?.url.toString()} ');
    if (psApiResponse.isSuccessful) {
      print(
          '\u001b[33m ${response.statusCode} $success <-- ${response.request?.url.toString()}\u001b[0m');
    } else if (psApiResponse.totallyNoRecord) {
      print(
          '\u001b[33m ${response.statusCode} $success (Totally No Record) <-- ${response.request?.url.toString()}\u001b[0m');
    } else {
      print(
          '\u001b[33m ${response.statusCode} $failed <-- ${response.request?.url.toString()}\u001b[0m');
    }
    print(
        '____________________________________________________________________________________________');
    print('');
  }

  void printPostLog(MasterApiResponse psApiResponse, http.Response response,
      Map<dynamic, dynamic> jsonMap) {
    const String success = '✅';
    const String failed = '❌';
    print(
        '____________________________________________________________________________________________');
    print(
        '\u001b[33m POST   --> ${response.request?.url.toString()}\u001b[0m ');
    print('\u001b[37m REQ-BODY --> ${jsonMap.toString()} \u001b[0m');
    if (psApiResponse.isSuccessful) {
      print(
          '\u001b[33m ${response.statusCode} $success <-- ${response.request?.url.toString()}\u001b[0m');
    } else if (psApiResponse.totallyNoRecord) {
      print(
          '\u001b[33m ${response.statusCode} $success (Totally No Record) <-- ${response.request?.url.toString()}\u001b[0m');
    } else {
      print(
          '\u001b[33m ${response.statusCode} $failed <-- ${response.request?.url.toString()}\u001b[0m');
    }
    print(
        '____________________________________________________________________________________________');
    print('');
  }

  Future<MasterResource<R>>
      getServerCall<T extends MasterObject<dynamic>, R /*!*/ >(
          T obj, String url) async {
    final Client client = http.Client();
    final Response response;
    try {
      final Map<String, String> headerTokenData = <String, String>{
        'content-type': 'application/json',
        // 'header-token': headerToken,
      };
      response = await client.get(
        Uri.parse('${MasterConfig.app_url}$url'),
        headers: headerTokenData,
      );
      print('${MasterConfig.app_url}$url');
      print(response.statusCode);
      print(response.body);
      final MasterApiResponse masterApiResponse = MasterApiResponse(response);
      if (masterApiResponse.isSuccessful) {
        final dynamic hashMap = json.decode(response.body);
        ApiBaseResponse data = ApiBaseResponse.fromJson(hashMap);
        if (data.response is! Map) {
          final List<T> tList = <T>[];
          hashMap.forEach((dynamic data) {
            tList.add(obj.fromMap(data as dynamic));
          });
          return MasterResource<R>(
              MasterStatus.SUCCESS, '', tList as R? ?? R as R?);
        } else {
          return MasterResource<R>(
              MasterStatus.SUCCESS, '', obj.fromMap(hashMap));
        }
      } else {
        return MasterResource<R>(
            MasterStatus.ERROR, masterApiResponse.errorMessage, null);
      }
    } catch (e) {
      return MasterResource<R>(
          MasterStatus.ERROR, e.toString(), null); //e.message ??
    } finally {
      client.close();
    }
  }

  Future<MasterResource<R>>
      testGetServerCall<T extends MasterObject<dynamic>, R /*!*/ >(
          T obj, String url, String headerToken) async {
    final Client client = http.Client();
    final Response response;
    try {
      final Map<String, String> headerTokenData = <String, String>{
        'content-type': 'application/json',
        'Authorization': 'Bearer $headerToken',
        // 'header-token': headerToken,
      };
      response = await client.get(
        Uri.parse('${MasterConfig.app_url}$url'),
        headers: headerTokenData,
      );

      final MasterApiResponse masterApiResponse = MasterApiResponse(response);
      printGetLog(masterApiResponse, response);

      if (masterApiResponse.isSuccessful) {
        print('response Success');

        final dynamic hashMap = json.decode(response.body);
        if (hashMap is! Map) {
          final List<T> tList = <T>[];
          hashMap.forEach((dynamic data) {
            tList.add(obj.fromMap(data as dynamic));
          });
          return MasterResource<R>(
              MasterStatus.SUCCESS, '', tList as R? ?? R as R?);
        } else {
          return MasterResource<R>(
              MasterStatus.SUCCESS, '', obj.fromMap(hashMap));
        }
      } else {
        return MasterResource<R>(
            MasterStatus.ERROR, masterApiResponse.errorMessage, null);
      }
    } catch (e) {
      return MasterResource<R>(
          MasterStatus.ERROR, e.toString(), null); //e.message ??
    } finally {
      client.close();
    }
  }

  Future<MasterResource<R>> postData<T extends MasterObject<dynamic>, R>(
    T obj,
    String url, {
    required Map<dynamic, dynamic> jsonMap,
    bool useToken = false,
    required String token,
  }) async {
    final Client client = http.Client();
    late Response response;
    try {
      final Map<String, String> headerTokenData = <String, String>{
        // 'content-type': 'application/json',
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };
      response = await client.post(Uri.parse('${MasterConfig.app_url}$url'),
          headers: headerTokenData, body: const JsonEncoder().convert(jsonMap));
      print("logout data : ${response.body}");
      final MasterApiResponse masterApiResponse = MasterApiResponse(response);
      printPostLog(masterApiResponse, response, jsonMap);
      if (masterApiResponse.isSuccessful) {
        final dynamic hashMap = json.decode(response.body);
        if (hashMap is! Map) {
          final List<T> tList = <T>[];
          hashMap.forEach((dynamic data) {
            tList.add(obj.fromMap(data));
          });
          print("list");
          return MasterResource<R>(
              MasterStatus.SUCCESS, '', tList as R? ?? R as R?);
        } else {
          print("json");
          return MasterResource<R>(
              MasterStatus.SUCCESS, '', obj.fromMap(hashMap));
        }
      } else {
        return MasterResource<R>(
            MasterStatus.ERROR, masterApiResponse.errorMessage, null);
      }
    } catch (e) {
      return MasterResource<R>(
          MasterStatus.ERROR, e.toString(), null); //e.message ??
    } finally {
      client.close();
    }
  }

  Future<MasterResource<R>> postLogin<T extends MasterObject<dynamic>, R>(
      T obj, String url, String email, String password,
      {bool useHeaderToken = false}) async {
    final Client client = http.Client();
    late Response response;
    try {
      final Map<String, String> headerTokenData = <String, String>{
        'content-type': 'application/json',
      };

      response = await client.post(
        Uri.parse(
            '${MasterConfig.app_url + url}email=$email&password=$password'),
        headers: headerTokenData,
      );
      final MasterApiResponse masterApiResponse = MasterApiResponse(response);

      // printPostLog(
      //   masterApiResponse,
      //   response,
      // );
      if (masterApiResponse.isSuccessful) {
        final dynamic hashMap = json.decode(response.body);

        if (hashMap is! Map) {
          final List<T> tList = <T>[];
          hashMap.forEach((dynamic data) {
            tList.add(obj.fromMap(data));
          });
          return MasterResource<R>(
              MasterStatus.SUCCESS, '', tList as R? ?? R as R?);
        } else {
          return MasterResource<R>(
              MasterStatus.SUCCESS, '', obj.fromMap(hashMap));
        }
      } else {
        return MasterResource<R>(
            MasterStatus.ERROR, masterApiResponse.errorMessage, null);
      }
    } catch (e) {
      return MasterResource<R>(
          MasterStatus.ERROR, e.toString(), null); //e.message ??
    } finally {
      client.close();
    }
  }

  Future<MasterResource<R>> postListData<T extends MasterObject<dynamic>, R>(
      T obj, String url, List<Map<dynamic, dynamic>> jsonMap,
      {bool useHeaderToken = false, String headerToken = ''}) async {
    final Client client = http.Client();
    final Map<String, String> headerTokenData = <String, String>{
      'content-type': 'application/json',
      // 'Authorization': MasterConfig.bearer_token,
      'header-token': headerToken,
    };

    try {
      final Response response = await client.post(
          Uri.parse('${MasterConfig.app_url}$url'),
          headers: headerTokenData,
          body: const JsonEncoder().convert(jsonMap));

      final MasterApiResponse masterApiResponse = MasterApiResponse(response);

      if (masterApiResponse.isSuccessful) {
        final dynamic hashMap = json.decode(response.body);

        if (hashMap is! Map) {
          final List<T> tList = <T>[];
          hashMap.forEach((dynamic data) {
            tList.add(obj.fromMap(data));
          });
          return MasterResource<R>(
              MasterStatus.SUCCESS, '', tList as R? ?? R as R?);
        } else {
          return MasterResource<R>(
              MasterStatus.SUCCESS, '', obj.fromMap(hashMap));
        }
      } else {
        return MasterResource<R>(
            MasterStatus.ERROR, masterApiResponse.errorMessage, null);
      }
    } catch (e) {
      return MasterResource<R>(
          MasterStatus.ERROR, e.toString(), null); //e.message ??
    } finally {
      client.close();
    }
  }

  Future<MasterResource<R>> postUploadImage<T extends MasterObject<dynamic>, R>(
      T obj,
      String url,
      String userIdText,
      String userId,
      String platformNameText,
      String platformName,
      String imageFileText,
      File imageFile,
      {bool useHeaderToken = false,
      String? headerToken = ''}) async {
    final Client client = http.Client();
    final Map<String, String> headerTokenData = <String, String>{
      'content-type': 'application/json',
      // 'Authorization': MasterConfig.bearer_token,
      'header-token': headerToken!,
    };
    try {
      // final ByteStream stream =
      //     http.ByteStream(Stream.castFrom(imageFile.openRead()));
      // final int length = await imageFile.length();

      final Uri uri = Uri.parse('${MasterConfig.app_url}$url');

      final MultipartRequest request = http.MultipartRequest('POST', uri);
      // final MultipartFile multipartFile = http.MultipartFile(
      //     imageFileText, stream, length,
      //     filename: basename(imageFile.path));
      request.headers.addAll(headerTokenData);
      request.fields[userIdText] = userId;
      request.fields[platformNameText] = platformName;
      // request.files.add(multipartFile);
      final StreamedResponse response = await request.send();
      // response.stream.listen((List<int> value ) {
      //   print(value);
      // });

      final MasterApiResponse masterApiResponse =
          MasterApiResponse(await http.Response.fromStream(response));

      if (masterApiResponse.isSuccessful) {
        final dynamic hashMap = json.decode(masterApiResponse.body!);

        if (hashMap is! Map) {
          final List<T> tList = <T>[];
          hashMap.forEach((dynamic data) {
            tList.add(obj.fromMap(data));
          });
          return MasterResource<R>(
              MasterStatus.SUCCESS, '', tList as R? ?? R as R?);
        } else {
          return MasterResource<R>(
              MasterStatus.SUCCESS, '', obj.fromMap(hashMap));
        }
      } else {
        return MasterResource<R>(
            MasterStatus.ERROR, masterApiResponse.errorMessage, null);
      }
    } finally {
      client.close();
    }
  }

  Future<MasterResource<R>>
      postUploadItemImage<T extends MasterObject<dynamic>, R>(
          T obj,
          String url,
          String itemIdText,
          String itemId,
          String imageIdText,
          String? imageId,
          String orderingText,
          String orderingDesc,
          File imageFile,
          {bool useHeaderToken = false,
          String headerToken = ''}) async {
    final Client client = http.Client();
    StreamedResponse response;
    // ByteStream stream;
    final Map<String, String> headerTokenData = <String, String>{
      'content-type': 'application/json',
      // 'Authorization': MasterConfig.bearer_token,
      'header-token': headerToken,
    };
    try {
      if (imageFile.path != '') {
        // stream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
        // final int length = await imageFile.length();

        final Uri uri = Uri.parse('${MasterConfig.app_url}$url');

        final MultipartRequest request = http.MultipartRequest('POST', uri);
        // final MultipartFile multipartFile = http.MultipartFile(
        //     'cover', stream, length,
        //     filename: basename(imageFile.path));
        request.headers.addAll(headerTokenData);
        request.fields[itemIdText] = itemId;
        request.fields[imageIdText] = imageId!;
        request.fields[orderingText] = orderingDesc;
        // request.files.add(multipartFile);
        response = await request.send();
      } else {
        // stream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
        final Uri uri = Uri.parse('${MasterConfig.app_url}$url');
        final MultipartRequest request = http.MultipartRequest('POST', uri);
        request.headers.addAll(headerTokenData);
        request.fields[itemIdText] = itemId;
        request.fields[imageIdText] = imageId!;
        request.fields[orderingText] = orderingDesc;
        response = await request.send();
      }

      final MasterApiResponse masterApiResponse =
          MasterApiResponse(await http.Response.fromStream(response));

      if (masterApiResponse.isSuccessful) {
        final dynamic hashMap = json.decode(masterApiResponse.body!);

        if (hashMap is! Map) {
          final List<T> tList = <T>[];
          hashMap.forEach((dynamic data) {
            tList.add(obj.fromMap(data));
          });
          return MasterResource<R>(
              MasterStatus.SUCCESS, '', tList as R? ?? R as R?);
        } else {
          return MasterResource<R>(
              MasterStatus.SUCCESS, '', obj.fromMap(hashMap));
        }
      } else {
        return MasterResource<R>(
            MasterStatus.ERROR, masterApiResponse.errorMessage, null);
      }
    } finally {
      client.close();
    }
  }

  Future<MasterResource<R>>
      postUploadChatImage<T extends MasterObject<dynamic>, R>(
          T obj,
          String url,
          String senderIdText,
          String senderId,
          String sellerUserIdText,
          String sellerUserId,
          String buyerUserIdText,
          String buyerUserId,
          String itemIdText,
          String itemId,
          String typeText,
          String type,
          String isUserOnlineText,
          String isUserOnline,
          File imageFile,
          {bool useHeaderToken = false,
          String headerToken = ''}) async {
    final Client client = http.Client();
    try {
      final Map<String, String> headerTokenData = <String, String>{
        'content-type': 'application/json',
        // 'Authorization': MasterConfig.bearer_token,
        'header-token': headerToken,
      };
      // final ByteStream stream =
      //     http.ByteStream(Stream.castFrom(imageFile.openRead()));
      // final int length = await imageFile.length();

      final Uri uri = Uri.parse('${MasterConfig.app_url}$url');

      final MultipartRequest request = http.MultipartRequest('POST', uri);
      request.headers.addAll(headerTokenData);
      // final MultipartFile multipartFile = http.MultipartFile(
      //     'file', stream, length,
      //     filename: basename(imageFile.path));

      request.fields[senderIdText] = senderId;
      request.fields[sellerUserIdText] = sellerUserId;
      request.fields[buyerUserIdText] = buyerUserId;
      request.fields[itemIdText] = itemId;
      request.fields[typeText] = type;
      request.fields[isUserOnlineText] = isUserOnline;
      // request.files.add(multipartFile);
      final StreamedResponse response = await request.send();

      final MasterApiResponse masterApiResponse =
          MasterApiResponse(await http.Response.fromStream(response));

      if (masterApiResponse.isSuccessful) {
        final dynamic hashMap = json.decode(masterApiResponse.body!);

        if (hashMap is! Map) {
          final List<T> tList = <T>[];
          hashMap.forEach((dynamic data) {
            tList.add(obj.fromMap(data));
          });
          return MasterResource<R>(
              MasterStatus.SUCCESS, '', tList as R? ?? R as R?);
        } else {
          return MasterResource<R>(
              MasterStatus.SUCCESS, '', obj.fromMap(hashMap));
        }
      } else {
        return MasterResource<R>(
            MasterStatus.ERROR, masterApiResponse.errorMessage, null);
      }
    } finally {
      client.close();
    }
  }
}
