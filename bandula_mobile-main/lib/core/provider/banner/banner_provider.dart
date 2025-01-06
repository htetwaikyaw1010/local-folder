import '../../api/common/master_resource.dart';
import '../../constant/master_constants.dart';
import '../../repository/banner_repository.dart';
import '../../viewobject/banner.dart';
import '../../viewobject/common/master_holder.dart';
import '../../viewobject/holder/request_path_holder.dart';
import '../common/master_provider.dart';

class BannerProvider extends MasterProvider<HomeBanner> {
  BannerProvider({
    required BannerRepository repo,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: MasterConst.LIST_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }

  BannerRepository? _repo;
  MasterResource<List<HomeBanner>> get bannerList => super.dataList;
  // OrderParameterHolder orderParameterHolder = OrderParameterHolder();

  Future<void> getBannerList({
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
  }) async {
    await _repo!.getBannerList(
      streamController: dataListStreamController!,
      dataConfig: defaultDataConfig,
    );
    notifyListeners();
  }
}
