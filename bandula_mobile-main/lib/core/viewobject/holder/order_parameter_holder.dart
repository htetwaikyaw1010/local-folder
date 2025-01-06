import '../common/master_holder.dart';

class OrderParameterHolder extends MasterHolder<OrderParameterHolder> {
  OrderParameterHolder() {
    headerToken = '';
    userId = '';
  }

  String? headerToken;
  String? userId;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['headerToken'] = headerToken;
    map['user_id'] = userId;

    return map;
  }

  @override
  OrderParameterHolder fromMap(dynamic dynamicData) {
    headerToken = '';
    userId = '';
    return this;
  }

  @override
  String getParamKey() {
    return userId.toString();
  }
}
