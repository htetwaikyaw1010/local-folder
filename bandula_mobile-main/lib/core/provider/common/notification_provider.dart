// import '../../api/common/master_resource.dart';
// import '../../repository/Common/notification_repository.dart';
// import '../../utils/utils.dart';

// class NotificationProvider extends PsProvider<Type> {
//   NotificationProvider({
//     required NotificationRepository? repo,
//     required this.psValueHolder,
//     int limit = 0,
//   }) : super(repo, limit, subscriptionType: PsConst.NO_SUBSCRIPTION) {
//     _repo = repo;
//   }

//   NotificationRepository? _repo;
//   PsValueHolder? psValueHolder;

//   MasterResource<ApiStatus> _notification =
//       MasterResource<ApiStatus>(PsStatus.NOACTION, '', null);
//   MasterResource<ApiStatus> get user => _notification;

//   Future<dynamic> rawRegisterNotiToken(Map<dynamic, dynamic> jsonMap,
//       String loginUserId, String languageCode) async {
//     isLoading = true;

//     isConnectedToInternet = await Utils.checkInternetConnectivity();

//     _notification = await _repo!.rawRegisterNotiToken(
//         jsonMap,
//         isConnectedToInternet,
//         PsStatus.PROGRESS_LOADING,
//         loginUserId,
//         psValueHolder!.headerToken!,
//         languageCode);

//     return _notification;
//   }

//   Future<dynamic> rawUnRegisterNotiToken(Map<dynamic, dynamic> jsonMap,
//       String loginUserId, String languageCode) async {
//     isLoading = true;

//     isConnectedToInternet = await Utils.checkInternetConnectivity();

//     _notification = await _repo!.rawUnRegisterNotiToken(
//         jsonMap,
//         isConnectedToInternet,
//         PsStatus.PROGRESS_LOADING,
//         loginUserId,
//         psValueHolder!.headerToken!,
//         languageCode);

//     return _notification;
//   }
// }
