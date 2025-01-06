import 'package:bandula/noti_vo.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotiController extends GetxController {
  RxString fcm = "".obs;
  RxBool showBadge = false.obs;
  RxInt count = 0.obs;
  RxList<NotiVO> notiList = <NotiVO>[].obs;
  RxBool isLoading = false.obs;
  RxBool isFetchable = false.obs;

  Future<void> callNoti(String token, int id) async {
    isLoading.value = true;

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://bandulamobile.ecommyanmar.com/api/notifications?user_id=$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsed = await http.Response.fromStream(response);
    var finalResponse = jsonDecode(responsed.body);

    print('get noti page...');

    if (response.statusCode == 200) {
      List data = finalResponse['data']['data'];
      notiList.value = [];
      count.value = 0;
      for (var d in data) {
        NotiVO noti = NotiVO.fromJson(d);
        notiList.add(noti);
      }
      isLoading.value = false;

      for (NotiVO noti in notiList) {
        if (noti.status == "0") {
          count.value = count.value + 1;
        }
      }

      notiList.value = notiList.reversed.toList();
    } else {
      isLoading.value = false;
      print("----eorrr");
    }

    update();
  }

  Future<bool> readNoti(String token, int userId, int id) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://bandulamobile.ecommyanmar.com/api/notifications/update'));
    request.fields.addAll({'id': '$id', 'user_id': '$userId', 'new': '1'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}


