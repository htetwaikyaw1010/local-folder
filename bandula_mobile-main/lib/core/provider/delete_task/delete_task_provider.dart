// import 'dart:async';

// import 'package:shusarmal/core/constant/master_constants.dart';
// import 'package:shusarmal/core/provider/common/master_provider.dart';
// import 'package:shusarmal/core/repository/delete_task_repository.dart';
// import 'package:shusarmal/core/viewobject/common/master_value_holder.dart';
// import 'package:shusarmal/core/viewobject/user_login.dart';

// class DeleteTaskProvider extends MasterProvider<UserLogin> {
//   DeleteTaskProvider(
//       {required DeleteTaskRepository? repo, this.psValueHolder, int limit = 0})
//       : super(repo, limit, subscriptionType: MasterConst.NO_SUBSCRIPTION) {
//     _repo = repo;
//   }

//   DeleteTaskRepository? _repo;
//   MasterValueHolder? psValueHolder;

//   Future<dynamic> deleteTask() async {
//     isLoading = true;
//     await _repo!.deleteTask();
//   }
// }
