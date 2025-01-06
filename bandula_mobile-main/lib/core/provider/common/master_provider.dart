import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../config/master_config.dart';
import '../../api/common/master_resource.dart';
import '../../api/common/master_status.dart';
import '../../constant/master_constants.dart';
import '../../db/common/master_data_source_manager.dart';
import '../../repository/Common/master_repository.dart';
import '../../viewobject/common/master_holder.dart';
import '../../viewobject/holder/request_path_holder.dart';

class MasterProvider<T> extends ChangeNotifier {
  MasterProvider(
    this._masterRepository,
    int limit, {
    required this.subscriptionType,
  }) {
    if (limit != 0) {
      this.limit = limit;
    }

    MasterConfig.printLog('${runtimeType.toString()} Init $hashCode');
    _startSubscription();
  }

  /// For DataList Object
  StreamController<MasterResource<List<dynamic>>>? dataListStreamController;
  StreamSubscription<MasterResource<List<dynamic>>>?
      _dataListStreamSubscription;
  MasterResource<List<T>> dataList =
      MasterResource<List<T>>(MasterStatus.NOACTION, '', <T>[]);

  /// For Single Object
  StreamController<MasterResource<dynamic>>? dataStreamController;
  StreamSubscription<MasterResource<dynamic>>? _dataStreamSubscription;
  MasterResource<T> data = MasterResource<T>(MasterStatus.NOACTION, '', null);

  /// Config
  bool isConnectedToInternet = false;
  bool isLoading = true;
  final MasterRepository? _masterRepository;
  String subscriptionType;
  final DataConfiguration defaultDataConfig = MasterConfig.defaultDataConfig;
  int? offset = 0;
  int limit = 30;
  int? _cacheDataLength = 0;
  int maxDataLoadingCount = 0;
  int maxDataLoadingCountLimit = 4;
  bool isReachMaxData = false;
  bool isDispose = false;

  RequestPathHolder? cachePathHolder;
  MasterHolder<dynamic>? cacheBodyHolder;
  DataConfiguration? cacheDataConfig;

  bool get hasData {
    if (subscriptionType == MasterConst.LIST_OBJECT_SUBSCRIPTION) {
      return dataList.data != null && dataList.data!.isNotEmpty;
    } else if (subscriptionType == MasterConst.SINGLE_OBJECT_SUBSCRIPTION) {
      return data.data != null;
    } else {
      return false;
    }
  }

  MasterStatus get currentStatus {
    if (subscriptionType == MasterConst.LIST_OBJECT_SUBSCRIPTION) {
      return dataList.status;
    } else if (subscriptionType == MasterConst.SINGLE_OBJECT_SUBSCRIPTION) {
      return data.status;
    } else {
      return MasterStatus.NOACTION;
    }
  }

  int get dataLength {
    if (subscriptionType == MasterConst.LIST_OBJECT_SUBSCRIPTION &&
        dataList.data != null &&
        dataList.data!.isNotEmpty) {
      return dataList.data!.length;
    } else {
      return 0;
    }
  }

  T getListIndexOf(int index, bool isNew) {
    if (subscriptionType == MasterConst.LIST_OBJECT_SUBSCRIPTION &&
        dataList.data != null &&
        dataList.data!.isNotEmpty &&
        dataList.data!.length > index) {
      if (isNew == true) {
        List newData = dataList.data?.reversed.toList() ?? [];

        return newData[index];
      } else {
        return dataList.data![index];
      }
    } else {
      return T as T;
    }
  }

  List<T> getCartDataList() {
    if (subscriptionType == MasterConst.LIST_OBJECT_SUBSCRIPTION &&
        dataList.data != null &&
        dataList.data!.isNotEmpty) {
      return dataList.data!;
    } else {
      return [];
    }
  }

  void updateOffset(int? dataLength) {
    if (offset == 0) {
      isReachMaxData = false;
      maxDataLoadingCount = 0;
    }
    if (dataLength == _cacheDataLength) {
      maxDataLoadingCount++;
      if (maxDataLoadingCount == maxDataLoadingCountLimit) {
        isReachMaxData = true;
      }
    } else {
      maxDataLoadingCount = 0;
    }

    offset = dataLength;
    _cacheDataLength = dataLength;
  }

  void _startSubscription() {
    switch (subscriptionType) {
      case MasterConst.SINGLE_OBJECT_SUBSCRIPTION:
        _singleObjectSubscription();
        break;
      case MasterConst.LIST_OBJECT_SUBSCRIPTION:
        _listObjectSubScription();
        break;
      case MasterConst.NO_SUBSCRIPTION:
        break;

      default:
    }
  }

  Future<void> loadValueHolder() async {
    await _masterRepository!.loadValueHolder();
  }

  void _singleObjectSubscription() {
    dataStreamController =
        StreamController<MasterResource<dynamic>>.broadcast();
    _dataStreamSubscription =
        dataStreamController?.stream.listen((MasterResource<dynamic> resource) {
      data.message = resource.message;
      data.status = resource.status;
      data.errorCode = resource.errorCode;
      data.data = resource.data;

      if (resource.status != MasterStatus.BLOCK_LOADING &&
          resource.status != MasterStatus.PROGRESS_LOADING) {
        isLoading = false;
      }

      if (!isDispose) {
        notifyListeners();
      }
    });
  }

  void _listObjectSubScription() {
    dataListStreamController =
        StreamController<MasterResource<List<dynamic>>>.broadcast();
    _dataListStreamSubscription = dataListStreamController?.stream
        .listen((MasterResource<List<dynamic>> resource) {
      if ((cacheDataConfig == null &&
              defaultDataConfig.dataSourceType ==
                  DataSourceType.SERVER_DIRECT) ||
          (cacheDataConfig != null &&
              cacheDataConfig?.dataSourceType ==
                  DataSourceType.SERVER_DIRECT)) {
        updateOffset(offset! + resource.data!.length);
        dataList.status = resource.status;
        dataList.message = resource.message;
        dataList.errorCode = resource.errorCode;

        dataList.data?.addAll(List<T>.from(resource.data!));
      } else {
        updateOffset(resource.data!.length);
        dataList.status = resource.status;
        dataList.message = resource.message;
        dataList.errorCode = resource.errorCode;
        if (resource.data != null) {
          dataList.data = List<T>.from(resource.data!);
        } else {
          dataList.data = List<T>.from(<T>[]);
        }
      }

      if (resource.status != MasterStatus.BLOCK_LOADING &&
          resource.status != MasterStatus.PROGRESS_LOADING) {
        isLoading = false;
      }

      if (!isDispose) {
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _stopSubscription();
    if (_masterRepository != null) {
      _masterRepository?.dispose();
    }
    isDispose = true;
    MasterConfig.printLog('${runtimeType.toString()} Dispose $hashCode',
        important: true);
    super.dispose();
  }

  void _stopSubscription() {
    if (_dataListStreamSubscription != null &&
        subscriptionType == MasterConst.LIST_OBJECT_SUBSCRIPTION) {
      _dataListStreamSubscription?.cancel();
    }
    if (_dataStreamSubscription != null &&
        subscriptionType == MasterConst.SINGLE_OBJECT_SUBSCRIPTION) {
      _dataStreamSubscription?.cancel();
    }
  }

  Future<void> loadData({
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    DataConfiguration? dataConfig,
  }) async {
    await _masterRepository?.loadData(
      streamController: dataStreamController!,
      dataConfig: dataConfig ?? defaultDataConfig,
      requestBodyHolder: requestBodyHolder,
      requestPathHolder: requestPathHolder,
    );
  }

  Future<void> loadDataList({
    bool reset = false,
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    DataConfiguration? dataConfig,
  }) async {
    if (!reset) {
      cacheBodyHolder = requestBodyHolder;
      cachePathHolder = requestPathHolder;
      cacheDataConfig = dataConfig;
    }
    if (reset) {
      MasterConfig.printLog('🔄 Data Refresh in ($runtimeType) 🔄');
      updateOffset(0);
      if ((cacheDataConfig != null &&
              cacheDataConfig?.dataSourceType ==
                  DataSourceType.SERVER_DIRECT) ||
          (cacheDataConfig == null &&
              defaultDataConfig.dataSourceType ==
                  DataSourceType.SERVER_DIRECT)) {
        dataList.data?.clear();
      }

      if (!isLoading && !isReachMaxData) {
        isLoading = true;
      }
    }

    await _masterRepository?.loadDataList(
      streamController: dataListStreamController!,
      dataConfig: cacheDataConfig ?? dataConfig ?? defaultDataConfig,
      requestBodyHolder: requestBodyHolder ?? cacheBodyHolder,
      requestPathHolder: requestPathHolder ?? cachePathHolder,
    );
    notifyListeners();
  }

  Future<void> loadNextDataList({
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    DataConfiguration? dataConfig,
  }) async {
    cacheDataConfig = dataConfig;
    notifyListeners();
    await _masterRepository?.loadNextDataList(
      streamController: dataListStreamController!,
      limit: limit,
      offset: offset!,
      dataConfig: cacheDataConfig ?? dataConfig ?? defaultDataConfig,
      requestPathHolder: requestPathHolder ?? cachePathHolder,
      requestBodyHolder: requestBodyHolder ?? cacheBodyHolder,
    );
  }

  Future<dynamic> loadDataListFromDatabase({
    bool reset = false,
  }) async {
    if (reset) {
      MasterConfig.printLog('🔄 Data Refresh in ($runtimeType) 🔄');
      dataList.data?.clear();
    }
    await _masterRepository?.loadDataListFromDatabase(
        streamController: dataListStreamController!);
  }

  Future<dynamic> addToDatabase(dynamic obj) async {
    await _masterRepository?.insertToDatabase(obj: obj);
  }

  Future<dynamic> deleteFromDatabase(dynamic obj) async {
    await _masterRepository?.deleteFromDatabase(
        streamController: dataListStreamController!, obj: obj);
  }

  Future<dynamic> postData({
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
  }) async {
    return await _masterRepository?.postData(
      requestBodyHolder: requestBodyHolder,
      requestPathHolder: requestPathHolder,
    );
  }

  Future<void> replaceLoginUserToken(String token) async {
    await _masterRepository!.replaceLoginUserToken(token);
  }

  Future<void> replaceLoginUserId(String loginUserId) async {
    await _masterRepository!.replaceLoginUserId(loginUserId);
  }

  Future<void> replaceLoginUserName(String loginUserName) async {
    await _masterRepository!.replaceLoginUserName(loginUserName);
  }

  // Future<void> replaceUserInfo(String userEmail, String userPassword) async {
  //   // await _masterRepository!.replaceUserInfo(userEmail, userPassword);
  // }

  Future<void> removeHeaderToken() async {
    await _masterRepository!.removeHeaderToken();
  }
}
