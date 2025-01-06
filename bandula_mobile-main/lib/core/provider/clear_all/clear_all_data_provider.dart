// import 'dart:async';

// import 'package:shusarmal/core/constant/master_constants.dart';
// import 'package:shusarmal/core/provider/common/master_provider.dart';
// import 'package:shusarmal/core/repository/clear_all_data_repository.dart';
// import 'package:shusarmal/core/viewobject/app_info.dart';
// import 'package:shusarmal/core/viewobject/common/master_value_holder.dart';

// class ClearAllDataProvider extends MasterProvider<AppInfo> {
//   ClearAllDataProvider(
//       {required ClearAllDataRepository repo, this.psValueHolder, int limit = 0})
//       : super(repo, limit, subscriptionType: MasterConst.NO_SUBSCRIPTION) {
//     _repo = repo;
//   }

//   late ClearAllDataRepository _repo;
//   MasterValueHolder? psValueHolder;

//   Future<dynamic> clearAllData() async {
//     isLoading = true;
//     _repo.clearAllData();
//   }
// }
