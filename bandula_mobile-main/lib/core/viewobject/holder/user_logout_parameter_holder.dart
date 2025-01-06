import '../common/master_holder.dart';

class UserLogoutHolder extends MasterHolder<UserLogoutHolder> {
  UserLogoutHolder({
    required this.userId,
  });

  final String? userId;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['user_id'] = userId;
    return map;
  }

  @override
  UserLogoutHolder fromMap(dynamic dynamicData) {
    return UserLogoutHolder(
      userId: dynamicData['user_id'],
    );
  }

  @override
  String getParamKey() {
    return userId.toString();
  }
}
