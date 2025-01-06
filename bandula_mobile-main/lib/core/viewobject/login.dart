import 'package:quiver/core.dart';
import 'common/master_object.dart';

class Login extends MasterObject<Login> {
  Login({
    this.status,
    this.token,
    this.name,
    this.id,
    this.phone,
    this.email,
  });
  String? status;
  String? token;
  String? name;
  String? id;
  String? phone;
  String? email;

  @override
  bool operator ==(dynamic other) => other is Login && token == other.token;

  @override
  int get hashCode {
    return hash2(token.hashCode, token.hashCode);
  }

  @override
  String getPrimaryKey() {
    return token ?? '';
  }

  @override
  Login fromMap(
    dynamic dynamicData,
  ) {
    if (dynamicData != null) {
      return Login(
        status: dynamicData['status'],
        token: dynamicData['token'],
        name: dynamicData['user']['name'],
        id: dynamicData['user']['id'].toString(),
        phone: dynamicData['user']['phone'],
        email: dynamicData['user']['email'],
      );
    } else {
      return Login(token: '');
    }
  }

  Login fromMaps(
    dynamic dynamicData,
  ) {
    if (dynamicData != null) {
      return Login(
        status: dynamicData['status'],
        token: dynamicData['token'],
        name: dynamicData['data']['name'],
        id: dynamicData['data']['id'].toString(),
        phone: dynamicData['data']['phone'],
        email: dynamicData['data']['email'],
      );
    } else {
      return Login(token: '');
    }
  }

  @override
  Map<String, dynamic>? toMap(Login object) {
    // if (object != null) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = object.status;
    data['token'] = object.token;
    return data;
  }

  @override
  List<Login> fromMapList(List<dynamic> dynamicDataList) {
    final List<Login> subUserList = <Login>[];
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        subUserList.add(fromMap(dynamicData));
      }
    }
    return subUserList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Login> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (Login? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}

class LoginData extends MasterObject<LoginData> {
  LoginData({
    this.login,
  });

  Login? login;

  @override
  bool operator ==(dynamic other) => other is LoginData && login == other.login;

  @override
  int get hashCode {
    return hash2(login.hashCode, login.hashCode);
  }

  @override
  String? getPrimaryKey() {
    return login!.token ?? '';
  }

  @override
  LoginData fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return LoginData(
        login: Login().fromMap(dynamicData['data']),
      );
    } else {
      return LoginData();
    }
  }

  @override
  Map<String, dynamic>? toMap(LoginData object) {
    // if (object != null) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = object.login;
    return data;
  }

  @override
  List<LoginData> fromMapList(List<dynamic> dynamicDataList) {
    final List<LoginData> subUserList = <LoginData>[];
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        subUserList.add(fromMap(dynamicData));
      }
    }
    return subUserList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<LoginData> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (LoginData? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
