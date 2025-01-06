import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bandula/core/viewobject/comp_cpu.dart';
import 'package:bandula/core/viewobject/noti_model.dart';
import 'package:bandula/core/viewobject/order_detail.dart';
import 'package:bandula/main.dart';
import '../../config/master_config.dart';
import '../viewobject/api_status.dart';
import '../viewobject/banner.dart';
import '../viewobject/blog.dart';
import '../viewobject/brand.dart';
import '../viewobject/cart_product.dart';
import '../viewobject/category.dart';
import '../viewobject/error_return.dart';
import '../viewobject/generation.dart';
import '../viewobject/login.dart';
import '../viewobject/order.dart';
import '../viewobject/payment.dart';
import '../viewobject/product.dart';
import '../viewobject/region.dart';
import '../viewobject/township.dart';
import 'common/master_api.dart';
import 'common/master_resource.dart';
import 'common/master_status.dart';

class MasterApiService extends MasterApi {
  /// Load Home Banner List
  ///

  Future<MasterResource<List<HomeBanner>>> getHomeBannerList() async {
    const String url = '${MasterConfig.app_url}banner';
    final Client client = http.Client();
    final Response response = await client.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final dynamic hashMap = json.decode(response.body);
      final HomeBannerData gameData = HomeBannerData().fromMap(hashMap);
      List<HomeBanner>? bannerlist = [];
      gameData.data!.map((e) {
        bannerlist.add(HomeBanner(image: e.toString()));
      });
      return MasterResource<List<HomeBanner>>(
          MasterStatus.SUCCESS, '', gameData.data);
    } else {
      return MasterResource<List<HomeBanner>>(MasterStatus.ERROR, '', null);
    }
  }

  /// Load Cpu List
  ///

  Future<MasterResource<List<CompCPU>>> getCPUList() async {
    const String url = '${MasterConfig.app_url}cpus';
    final Client client = http.Client();
    final Response response = await client.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final dynamic hashMap = json.decode(response.body);
      final CompCPUData gameData = CompCPUData().fromMap(hashMap);
      List<HomeBanner>? bannerlist = [];
      gameData.data!.map((e) {
        bannerlist.add(HomeBanner(image: e.toString()));
      });
      return MasterResource<List<CompCPU>>(
          MasterStatus.SUCCESS, '', gameData.data);
    } else {
      return MasterResource<List<CompCPU>>(MasterStatus.ERROR, '', null);
    }
  }

  /// Load Generation List
  ///

  Future<MasterResource<List<Generation>>> getGenerationList() async {
    const String url = '${MasterConfig.app_url}generations';
    final Client client = http.Client();
    final Response response = await client.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final dynamic hashMap = json.decode(response.body);
      final GenerationData gameData = GenerationData().fromMap(hashMap);
      List<HomeBanner>? bannerlist = [];
      gameData.data!.map((e) {
        bannerlist.add(HomeBanner(image: e.toString()));
      });
      return MasterResource<List<Generation>>(
          MasterStatus.SUCCESS, '', gameData.data);
    } else {
      return MasterResource<List<Generation>>(MasterStatus.ERROR, '', null);
    }
  }

  /// Load Category List
  ///

  Future<MasterResource<List<Category>>> getCategoryList() async {
    const String url = '${MasterConfig.app_url}category';

    final Client client = http.Client();
    final Response response = await client.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final dynamic hashMap = json.decode(response.body);
      final CategoryData data = CategoryData().fromMap(hashMap);
      return MasterResource<List<Category>>(
          MasterStatus.SUCCESS, '', data.data);
    } else {
      return MasterResource<List<Category>>(MasterStatus.ERROR, '', null);
    }
  }

  /// Load Category List
  ///

  Future<MasterResource<List<Brand>>> getBarndList(String? itemId) async {
    final String url = '${MasterConfig.app_url}category/$itemId';
    final Client client = http.Client();

    final Response response = await client.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final dynamic hashMap = json.decode(response.body);
      final BrandData data = BrandData().fromMap(hashMap);
      return MasterResource<List<Brand>>(MasterStatus.SUCCESS, '', data.data);
    } else {
      return MasterResource<List<Brand>>(MasterStatus.ERROR, '', null);
    }
  }

  /// Load Category List
  ///

  Future<MasterResource<List<Product>>> getlatestProduct(
      String currentPage) async {
    String url = '${MasterConfig.app_url}product?page=$currentPage';
    final Client client = http.Client();
    final Response response = await client.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final dynamic hashMap = json.decode(response.body);
      final ProductData data = ProductData().fromMap(hashMap);
      return MasterResource<List<Product>>(MasterStatus.SUCCESS, '', data.data,
          meta: data.meta);
    } else {
      return MasterResource<List<Product>>(MasterStatus.ERROR, '', null);
    }
  }

  /// Load Region List
  ///

  Future<MasterResource<List<Region>>> getRegionList() async {
    String url = '${MasterConfig.app_url}region';
    final Client client = http.Client();
    final Response response = await client.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final dynamic hashMap = json.decode(response.body);
      final RegionData data = RegionData().fromMap(hashMap);
      return MasterResource<List<Region>>(
        MasterStatus.SUCCESS,
        '',
        data.data,
      );
    } else {
      return MasterResource<List<Region>>(MasterStatus.ERROR, '', null);
    }
  }

  /// Load Township List
  ///
  Future<MasterResource<List<Township>>> getTownshipList(
      String regionID) async {
    String url = '${MasterConfig.app_url}deliveryfee/$regionID';
    final Client client = http.Client();
    final Response response = await client.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final dynamic hashMap = json.decode(response.body);
      final TownshipData data = TownshipData().fromMap(hashMap);
      return MasterResource<List<Township>>(
        MasterStatus.SUCCESS,
        '',
        data.data,
      );
    } else {
      return MasterResource<List<Township>>(MasterStatus.ERROR, '', null);
    }
  }

  /// Load Region List
  ///

  Future<MasterResource<List<Payment>>> getPaymentList() async {
    String url = '${MasterConfig.app_url}payment';
    final Client client = http.Client();
    final Response response = await client.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final dynamic hashMap = json.decode(response.body);

      final PaymentData data = PaymentData().fromMap(hashMap);
      return MasterResource<List<Payment>>(
        MasterStatus.SUCCESS,
        '',
        data.data,
      );
    } else {
      return MasterResource<List<Payment>>(MasterStatus.ERROR, '', null);
    }
  }

  /// Product List By Brand
  ///

  Future<MasterResource<List<Product>>> getProductByBrand(
    String brandID,
    String catID,
    String page,
  ) async {
    String url = '${MasterConfig.app_url}product?keyword=$brandID';
    print("url : ${url}");
    final Client client = http.Client();
    final Response response = await client.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final dynamic hashMap = json.decode(response.body);
      final ProductData data = ProductData().fromMap(hashMap);
      return MasterResource<List<Product>>(MasterStatus.SUCCESS, '', data.data,
          meta: data.meta);
    } else {
      return MasterResource<List<Product>>(MasterStatus.ERROR, '', null);
    }
  }

  /// Search Product List
  ///

  Future<MasterResource<List<Product>>> getSearchProductList(
    String keyword,
    String page,
  ) async {
    String url = '${MasterConfig.app_url}product?keyword=$keyword';
    final Client client = http.Client();
    final Response response = await client.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final dynamic hashMap = json.decode(response.body);
      final ProductData data = ProductData().fromMap(hashMap);
      return MasterResource<List<Product>>(MasterStatus.SUCCESS, '', data.data,
          meta: data.meta);
    } else {
      return MasterResource<List<Product>>(MasterStatus.ERROR, '', null);
    }
  }

  /// Search Product List
  ///

  Future<MasterResource<List<Product>>> filterProductList({
    String? min,
    String? max,
    String? cpu,
    String? generation,
    String? brandID,
    String? catID,
    required String page,
  }) async {
    String url = brandID == 'brandID'
        ? '${MasterConfig.app_url}products/search?min_price=$min&max_price=$max'
        : '${MasterConfig.app_url}products/search?&min_price=$min&max_price=$max&brand_id[]=$brandID';
    print("url : $url");
    final Client client = http.Client();
    final Response response = await client.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final dynamic hashMap = json.decode(response.body);
      final ProductData data = ProductData().fromMap(hashMap);
      return MasterResource<List<Product>>(MasterStatus.SUCCESS, '', data.data,
          meta: data.meta);
    } else {
      return MasterResource<List<Product>>(MasterStatus.ERROR, '', null);
    }
  }

  Future<MasterResource<Product>> getItemDetail(String? itemId) async {
    final String url = '${MasterConfig.app_url}product/$itemId';
    final Client client = http.Client();
    final Response response = await client.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final dynamic hashMap = json.decode(response.body);

      final ProductSingleData data = ProductSingleData().fromMap(hashMap);

      return MasterResource<Product>(MasterStatus.SUCCESS, '', data.data);
    } else {
      return MasterResource<Product>(MasterStatus.ERROR, '', null);
    }
    // return await getServerCall<Product, Product>(Product(), url);
  }

  /// Post Login
  ///
  Future<MasterResource<Login>> postUserLogin(
    String phone,
    String password,
    String fcmtoken,
  ) async {
    const String url = '${MasterConfig.app_url}login';
    final Client client = http.Client();
    final Response response = await client.post(
      Uri.parse(url),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'emailOrPhone': phone,
        'password': password,
        'fcm_token_key': fcmtoken,
      }),
    );
    final dynamic hashMap = json.decode(response.body);
    print(hashMap);
    if (response.statusCode == 200) {
      final dynamic hashMap = json.decode(response.body);
      if (hashMap["status"] != "error") {
        final MasterResource<Login> data = MasterResource<Login>(
            MasterStatus.SUCCESS, '', Login().fromMap(hashMap));
        return data;
      } else {
        return MasterResource<Login>(MasterStatus.ERROR, hashMap["data"], null);
      }
    } else {
      final dynamic hashMap = json.decode(response.body);
      final ErrorReturn error = ErrorReturn().fromMap(hashMap);
      return MasterResource<Login>(MasterStatus.ERROR, error.message!, null);
    }
  }

  Future<MasterResource<Login>> postUserRegister({
    required String name,
    required String password,
    required String email,
    required String phone,
    required String fcmToken,
  }) async {
    const String url = '${MasterConfig.app_url}register';
    final Client client = http.Client();
    final Response response = await client.post(
      Uri.parse(url),
      headers: <String, String>{
        'Accept': 'application/json',
      },
      body: <String, String>{
        'name': name,
        'phone': phone,
        'password': password,
        'email': email,
        'fcm_token_key': fcmToken,
      },
    );

    print('your response is....${response.body}');

    if (response.statusCode == 200) {
      String status = "";
      final dynamic hashMap = json.decode(response.body);
      print("register : ${hashMap}");
      status = hashMap["status"] ?? "";
      if (status.isEmpty) {
        return MasterResource<Login>(
            MasterStatus.ERROR, hashMap["data"].toString(), null);
      } else {
        final MasterResource<Login> data = MasterResource<Login>(
            MasterStatus.SUCCESS, '', Login().fromMaps(hashMap));
        return data;
      }
    } else {
      final dynamic hashMap = json.decode(response.body);
      final ErrorReturn error = ErrorReturn().fromMap(hashMap);
      return MasterResource<Login>(MasterStatus.ERROR, error.message!, null);
    }
  }

  ///
  /// Create Order
  ///
  Future<MasterResource<OrderCreateSuccess>> createOrder({
    required String token,
    required String name,
    required String phone,
    required String address,
    required String paymentId,
    required String regionId,
    required String paymentName,
    required String fees,
    required String email,
    required XFile file,
  }) async {
    String url = '${MasterConfig.app_url}order';

    final http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(url));

    request.headers.addAll(
      <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    request.files.add(
      http.MultipartFile(
        'payment_photo',
        file.readAsBytes().asStream(),
        await file.length(),
        filename: file.path.split('/').last,
        contentType: MediaType('jpg', 'jpeg'),
      ),
    );

    final Map<String, String> fields = <String, String>{};
    fields.addAll(
      <String, String>{
        "name": name,
        "email": email,
        "phone_no": phone,
        "address": address,
        "region_id": regionId,
        "delivery_id": fees,
        "payment_id": paymentId,
        "payment_method": paymentName,
      },
    );
    request.fields.addAll(fields);

    final http.StreamedResponse response = await request.send();
    final http.Response res = await http.Response.fromStream(response);
    final dynamic hashMap = json.decode(res.body);
    print("create order data : ${hashMap}");
    if (response.statusCode == 200) {
      final OrderCreateSuccess orderData =
          OrderCreateSuccess().fromMap(hashMap);
      return MasterResource<OrderCreateSuccess>(
          MasterStatus.SUCCESS, '', orderData);
    } else {
      final ErrorReturn error = ErrorReturn().fromMap(hashMap);
      return MasterResource<OrderCreateSuccess>(
          MasterStatus.ERROR, error.message!, null);
    }
  }

  /// Create Order COD
  ///

  Future<MasterResource<OrderCreateSuccess>> createOrderCOD({
    required String token,
    required String name,
    required String userid,
    required String phone,
    required String address,
    required String townshipID,
  }) async {
    String url = '${MasterConfig.app_url}order';

    final http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(url));

    request.headers.addAll(<String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final Map<String, String> fields = <String, String>{};
    fields.addAll(<String, String>{
      "name": "than",
      "phone_no": "09761943426",
      "address": address,
      "township_id": townshipID,
      "region_id": "1",
      "delivery_id": "1",
      "payment_id": "1",
      'fcm_token_key': 'testing_token'
    });
    request.fields.addAll(fields);

    final http.StreamedResponse response = await request.send();
    final http.Response res = await http.Response.fromStream(response);
    final dynamic hashMap = json.decode(res.body);

    if (response.statusCode == 200) {
      final OrderCreateSuccess orderData =
          OrderCreateSuccess().fromMap(hashMap);
      return MasterResource<OrderCreateSuccess>(
          MasterStatus.SUCCESS, '', orderData);
    } else {
      final ErrorReturn error = ErrorReturn().fromMap(hashMap);
      return MasterResource<OrderCreateSuccess>(
          MasterStatus.ERROR, error.message!, null);
    }
  }

  /// Load Order List
  ///

  Future<MasterResource<List<Order>>> getOrderList(String token) async {
    String url = '${MasterConfig.app_url}order';
    final Client client = http.Client();
    final Response response = await client.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final dynamic hashMap = json.decode(response.body);
    if (response.statusCode == 200) {
      final OrderData data = OrderData().fromMap(hashMap);
      return MasterResource<List<Order>>(
        MasterStatus.SUCCESS,
        '',
        data.data,
      );
    } else {
      final ErrorReturn error = ErrorReturn().fromMap(hashMap);

      return MasterResource<List<Order>>(
          MasterStatus.ERROR, error.message ?? '', null);
    }
  }

  ///
  /// Get Order
  ///
  Future<MasterResource<OrderDetails>> getOrderDetail(
      {required String orderId, required String token}) async {
    final String url = '${MasterConfig.app_url}order/$orderId';
    final Client client = http.Client();
    final Response response = await client.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final dynamic hashMap = json.decode(response.body);
      final OrderDetailsData data = OrderDetailsData().fromMap(hashMap);
      return MasterResource<OrderDetails>(MasterStatus.SUCCESS, '', data.data);
    } else {
      return MasterResource<OrderDetails>(MasterStatus.ERROR, '', null);
    }
    // return await getServerCall<Product, Product>(Product(), url);
  }

  Future<MasterResource<List<NotiModel>>> getNotiList(
      {required String token}) async {
    const String url = '${MasterConfig.app_url}notifications';
    final Client client = http.Client();
    final Response response = await client.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final dynamic hashMap = json.decode(response.body);
      final data = NotiModel().fromMapList(hashMap['data']);
      return MasterResource<List<NotiModel>>(MasterStatus.SUCCESS, '', data);
    } else {
      return MasterResource<List<NotiModel>>(MasterStatus.ERROR, '', null);
    }
    // return await getServerCall<Product, Product>(Product(), url);
  }

  Future<MasterResource<NotiModel>> getNotiDetail(
      {required String token, required int id}) async {
    String url = '${MasterConfig.app_url}notification/$id';
    final Client client = http.Client();
    final Response response = await client.post(
      Uri.parse(url),
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: <String, String>{
        'status': "1",
        '_method': 'PUT',
      },
    );
    print("NOTI Res ${json.decode(response.body)}");
    if (response.statusCode == 200) {
      getNotiList(token: token);
      final dynamic hashMap = json.decode(response.body);

      final data = NotiModel().fromMap(hashMap['data']);
      print("NOTIMODEL $data");

      return MasterResource<NotiModel>(MasterStatus.SUCCESS, '', data);
    } else {
      return MasterResource<NotiModel>(MasterStatus.ERROR, '', null);
    }
    // return await getServerCall<Product, Product>(Product(), url);
  }

  Future<MasterResource<ApiStatus>> clearNotiList(
      {required String token}) async {
    String url = '${MasterConfig.app_url}notifications/delete-all';
    final Client client = http.Client();
    final Map<String, String> headerTokenData = <String, String>{
      'Accept': 'application/json',
      'content-type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final Response response = await client.post(
      headers: headerTokenData,
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final dynamic hashMap = json.decode(response.body);
      final ApiStatus data = ApiStatus().fromMap(hashMap);
      getNotiList(token: token);
      return MasterResource<ApiStatus>(
        MasterStatus.SUCCESS,
        data.message ?? '',
        data,
      );
    } else {
      return MasterResource<ApiStatus>(MasterStatus.ERROR, '', null);
    }
  }

  ///
  /// Create cart
  ///
  Future<MasterResource<ApiStatus>> createCart({
    required String token,
    required List<CartProduct> carts,
  }) async {
    String url = '${MasterConfig.app_url}cart';
    final Client client = http.Client();

    List<Map<String, String>> cartdata = [];
    for (CartProduct cart in carts) {
      cartdata.add(<String, String>{
        "product_id": cart.product!.id.toString(),
        "quantity": cart.quantity.toString()
      });
    }

    final Response response = await client.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"cart": cartdata}),
    );

    final dynamic hashMap = json.decode(response.body);

    if (response.statusCode == 200) {
      final ApiStatus data = ApiStatus().fromMap(hashMap);
      return MasterResource<ApiStatus>(MasterStatus.SUCCESS, '', data);
    } else {
      final ErrorReturn error = ErrorReturn().fromMap(hashMap);

      return MasterResource<ApiStatus>(
          MasterStatus.ERROR, error.message!, null);
    }
  }

  ///
  /// User Logout
  ///
  Future<MasterResource<ApiStatus>> postUserLogout(
    String token,
  ) async {
    return await postData<ApiStatus, ApiStatus>(ApiStatus(), 'logout',
        useToken: true, token: token, jsonMap: <String, String>{});
  }

  Future<MasterResource<ApiStatus>> postChangePassword(
    String token,
    String oldPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    // var headers = {
    //   'Accept': 'application/json',
    //   'Authorization': 'Bearer $token'
    // };
    // var request = http.MultipartRequest(
    //   'POST',
    //   Uri.parse('${MasterConfig.app_url}update-password/user'),
    // );
    // request.fields.addAll({
    //   'old_password': oldPassword,
    //   'password': newPassword,
    //   'password_confirmation': confirmPassword,
    //   '_method': 'PUT',
    // });
    // request.headers.addAll(headers);
    // http.StreamedResponse response = await request.send();
    // final http.Response res = await http.Response.fromStream(response);
    final Client client = http.Client();
    final Response response = await client.post(
        Uri.parse('${MasterConfig.app_url}update-password/user'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          'old_password': oldPassword,
          'password': newPassword,
          'password_confirmation': confirmPassword,
          '_method': 'PUT',
        }));

    final dynamic hashMap = json.decode(response.body);
    if (response.statusCode == 200) {
      final ApiStatus data = ApiStatus().fromMap(hashMap);
      return MasterResource<ApiStatus>(MasterStatus.SUCCESS, '', data);
    } else {
      final ErrorReturn error = ErrorReturn().fromMap(hashMap);
      return MasterResource<ApiStatus>(
          MasterStatus.ERROR, error.message!, null);
    }
  }

  Future<MasterResource<ApiStatus>> deleteAccount(
    String token,
    String userID,
  ) async {
    String url = '${MasterConfig.app_url}delete/user';
    final Client client = http.Client();
    final Map<String, String> headerTokenData = <String, String>{
      'Accept': 'application/json',
      'content-type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final Response response = await client.delete(
      headers: headerTokenData,
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final dynamic hashMap = json.decode(response.body);
      final ApiStatus data = ApiStatus().fromMap(hashMap);
      return MasterResource<ApiStatus>(
        MasterStatus.SUCCESS,
        data.message ?? '',
        data,
      );
    } else {
      return MasterResource<ApiStatus>(MasterStatus.ERROR, '', null);
    }
    // return await postData<ApiStatus, ApiStatus>(
    //     ApiStatus(), 'delete/user/$userID',
    //     useToken: true, token: token, jsonMap: <String, String>{});
  }

  Future<MasterResource<List<Blog>>> getBlogList() async {
    String url = '${MasterConfig.app_url}blog';
    final Client client = http.Client();
    final Response response = await client.get(
      Uri.parse(url),
    );
    getSuggestionList();
    if (response.statusCode == 200) {
      final dynamic hashMap = json.decode(response.body);
      final BlogData data = BlogData().fromMap(hashMap);
      return MasterResource<List<Blog>>(
        MasterStatus.SUCCESS,
        '',
        data.data,
      );
    } else {
      return MasterResource<List<Blog>>(MasterStatus.ERROR, '', null);
    }
  }

  Future<MasterResource<List<Blog>>> getSuggestionList() async {
    String url = '${MasterConfig.app_url}advice';
    final Client client = http.Client();
    final Response response =
        await client.get(Uri.parse(url), headers: <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer 14|TjmgKUot1UULBkkScZfI932D8mn5yDKmj4jruJVh'
    });
    if (response.statusCode == 200) {
      final dynamic hashMap = json.decode(response.body);
      final BlogData data = BlogData().fromMap(hashMap);
      return MasterResource<List<Blog>>(
        MasterStatus.SUCCESS,
        '',
        data.data,
      );
    } else {
      return MasterResource<List<Blog>>(MasterStatus.ERROR, '', null);
    }
  }
}
