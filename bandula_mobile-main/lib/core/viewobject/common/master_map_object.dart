import 'master_object.dart';

abstract class MasterMapObject<T, R> extends MasterObject<T> {
  int? sorting;

  List<String> getIdList(List<T> mapList);

  T fromObject({
    required R obj,
    required String? addedDate,
    required String mapKey,
    required int sorting,
  });
}
