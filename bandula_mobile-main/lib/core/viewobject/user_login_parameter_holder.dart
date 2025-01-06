import 'common/master_holder.dart';

class UserLoginParameterHolder extends MasterHolder<UserLoginParameterHolder> {
  UserLoginParameterHolder({
    required this.userEmail,
    required this.userPassword,
  });

  final String? userEmail;
  final String? userPassword;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['email'] = userEmail;
    map['password'] = userPassword;

    return map;
  }

  @override
  UserLoginParameterHolder fromMap(dynamic dynamicData) {
    return UserLoginParameterHolder(
      userEmail: dynamicData['email'],
      userPassword: dynamicData['password'],
    );
  }

  @override
  String getParamKey() {
    return userEmail.toString();
  }
}
