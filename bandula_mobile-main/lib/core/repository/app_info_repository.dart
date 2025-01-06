// // ignore_for_file: unused_field, always_specify_types

// import 'dart:async';

// import 'package:shusarmal/core/api/common/master_resource.dart';
// import 'package:shusarmal/core/api/common/master_status.dart';
// import 'package:shusarmal/core/api/master_api_service.dart';
// import 'package:shusarmal/core/repository/Common/master_repository.dart';
// import 'package:shusarmal/core/viewobject/app_info.dart';
// import 'package:shusarmal/core/viewobject/common/master_holder.dart';
// import 'package:shusarmal/core/viewobject/holder/request_path_holder.dart';
// import 'package:shusarmal/core/viewobject/master_mobile_config_setting.dart';

// class AppInfoRepository extends MasterRepository {
//   AppInfoRepository({
//     required MasterApiService apiService,
//   }) {
//     _psApiService = apiService;
//   }
//   late MasterApiService _psApiService;

//   // Future<PsResource<PSAppInfo>> postDeleteHistory(Map<dynamic, dynamic> jsonMap,
//   //     {bool isLoadFromServer = true}) async {
//   //   final PsResource<PSAppInfo> _resource =
//   //       await _psApiService.postPsAppInfo(jsonMap);
//   //   if (_resource.status == PsStatus.SUCCESS) {
//   //     if (_resource.data!.deleteObject!.isNotEmpty) {}
//   //     return _resource;
//   //   } else {
//   //     final Completer<PsResource<PSAppInfo>> completer =
//   //         Completer<PsResource<PSAppInfo>>();
//   //     completer.complete(_resource);
//   //     return completer.future;
//   //   }
//   // }
//   @override
//   Future<MasterResource<AppInfo>> postData({
//     MasterHolder<dynamic>? requestBodyHolder,
//     RequestPathHolder? requestPathHolder,
//   }) async {
//     // final MasterResource<AppInfo> _resource = await _psApiService.postPsAppInfo(
//     //     requestBodyHolder!.toMap(),
//     //     requestPathHolder?.loginUserId ?? 'nologinuser');

//     // if (_resource.status == MasterStatus.SUCCESS) {
//     //   return _resource;
//     // } else {
//     //   final Completer<MasterResource<AppInfo>> completer =
//     //       Completer<MasterResource<AppInfo>>();
//     //   completer.complete(_resource);
//     //   return completer.future;
//     // }
//     final MasterResource<AppInfo> appinfo = MasterResource(MasterStatus.SUCCESS,
//         'Success', AppInfo(mobileConfigSetting: MasterMobileConfigSetting()));
//     return appinfo;
//   }
// }
