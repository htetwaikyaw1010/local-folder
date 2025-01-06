abstract class MasterHolder<T> {
  T fromMap(dynamic dynamicData);

  Map<dynamic, dynamic> toMap();

  String getParamKey();
}
