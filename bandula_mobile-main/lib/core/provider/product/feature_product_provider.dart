import '../../api/common/master_resource.dart';
import '../../constant/master_constants.dart';
import '../../repository/product_repository.dart';
import '../../viewobject/product.dart';
import '../common/master_provider.dart';

class FavouriteProductProvider extends MasterProvider<Product> {
  FavouriteProductProvider({
    required ProductRepository repo,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: MasterConst.LIST_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }

  late ProductRepository _repo;
  MasterResource<List<Product>> get productList => super.dataList;
  // @override
  // Future<dynamic> loadDataListFromDatabase() async {
  //   await _repository.loadDataListFromDatabase(
  //       streamController: dataListStreamController!);
  // }

  @override
  Future<dynamic> addToDatabase(dynamic obj) async {
    await _repo.insertToDatabase(
        // streamController: dataListStreamController!,
        obj: obj);
    dataList.data?.clear();
    await _repo.loadDataListFromDatabase(
        streamController: dataListStreamController!);
  }

  @override
  Future<dynamic> deleteFromDatabase(dynamic obj) async {
    await _repo.deleteFromDatabase(
        streamController: dataListStreamController!, obj: obj);
    dataList.data?.clear();
    await _repo.loadDataListFromDatabase(
        streamController: dataListStreamController!);
  }
}
