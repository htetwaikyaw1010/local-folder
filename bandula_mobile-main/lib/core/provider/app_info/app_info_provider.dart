// import 'package:shusarmal/core/api/common/master_resource.dart';
// import 'package:shusarmal/core/api/common/master_status.dart';
// import 'package:shusarmal/core/constant/master_constants.dart';
// import 'package:shusarmal/core/provider/common/master_init_provider.dart';
// import 'package:shusarmal/core/provider/common/master_provider.dart';
// import 'package:shusarmal/core/viewobject/common/master_value_holder.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:provider/single_child_widget.dart';

// import '../../repository/app_info_repository.dart';
// import '../../viewobject/app_info.dart';

// class AppInfoProvider extends MasterProvider<AppInfo> {
//   AppInfoProvider({
//     required AppInfoRepository? repo,
//     this.valueHolder,
//     int limit = 0,
//   }) : super(repo, limit, subscriptionType: MasterConst.NO_SUBSCRIPTION) {
//     // _repo = repo;
//     isDispose = false;
//   }

//   // AppInfoRepository? _repo;
//   MasterValueHolder? valueHolder;

//   final MasterResource<AppInfo> _psAppInfo =
//       MasterResource<AppInfo>(MasterStatus.NOACTION, '', null);

//   MasterResource<AppInfo> get appInfo => _psAppInfo;
//   String? realStartDate = '0';
//   String realEndDate = '0';
//   bool isSubLocation = false;

//   String get pricePerOneDay {
//     return appInfo.data?.appSetting?.oneDayPerPrice ?? '10';
//   }

//   bool get isIAPEnable {
//     return appInfo.data!.inAppPurchasedEnabled == MasterConst.ONE;
//   }

//   bool get isPayStackEnabled {
//     return appInfo.data!.payStackEnabled == MasterConst.ONE;
//   }

//   bool get isOfflinePaymentEnabled {
//     return appInfo.data!.offlineEnabled == MasterConst.OFFLINE_PAYMENT_ENABLE;
//   }

//   bool get isRazorPaymentEnabled {
//     return appInfo.data!.razorEnable == MasterConst.RAZOR_ENABLE;
//   }

//   bool get isPaypalEnabled {
//     return appInfo.data!.paypalEnable == MasterConst.PAYPAL_ENABLE;
//   }

//   bool get isStripeEnabled {
//     return appInfo.data!.stripeEnable == MasterConst.STRIPE_ENABLE;
//   }
// }

// SingleChildWidget initAppInfoProvider(
//   BuildContext context, {
//   Widget? widget,
// }) {
//   final AppInfoRepository repo = Provider.of<AppInfoRepository>(context);
//   final MasterValueHolder valueHolder = Provider.of<MasterValueHolder>(context);
//   return masterInitProvider<AppInfoProvider>(
//       initProvider: () => AppInfoProvider(repo: repo, valueHolder: valueHolder),
//       onProviderReady: (AppInfoProvider pro) {});
// }
