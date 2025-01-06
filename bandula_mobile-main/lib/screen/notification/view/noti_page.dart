import 'package:bandula/config/master_colors.dart';
import 'package:bandula/core/viewobject/common/master_value_holder.dart';
import 'package:bandula/noti_controller.dart';
import 'package:bandula/screen/notification/witgets/notification_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

final _notiController = Get.put(NotiController());

class NotiPage extends StatefulWidget {
  const NotiPage({super.key});

  @override
  State<NotiPage> createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage> {
  @override
  Widget build(BuildContext context) {
    final MasterValueHolder valueHolder =
        Provider.of<MasterValueHolder>(context);
    return Scaffold(
      backgroundColor: MasterColors.grey,
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: false,
        elevation: 0,
        backgroundColor: MasterColors.mainColor,
        title: Text(
          'Notification'.tr,
          style: TextStyle(
            color: Color.fromRGBO(254, 242, 0, 1),
          ),
        ),
      ),
      body: ListView(
        children: [
          const Gap(20),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 25),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Container(
          //           alignment: Alignment.topLeft,
          //           child: IconButton(
          //             icon: const Icon(
          //               Icons.arrow_back_ios,
          //               color: Colors.black,
          //               size: 20,
          //             ),
          //             onPressed: () {
          //               Navigator.pop(context);
          //             },
          //           )),
          //       const Text(
          //         'Notification',
          //         style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             fontSize: 20,
          //             color: Color.fromRGBO(254, 242, 0, 1)),
          //       ),
          //       const Gap(30)
          //     ],
          //   ),
          // ),
          const Gap(30),
          Obx(() => _notiController.isLoading.value
              ? Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.34),
                  child: const Center(child: CupertinoActivityIndicator()),
                )
              : _notiController.notiList.isEmpty
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.18),
                      child: const Center(child: Text("No Data")))
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              // showDialog(
                              //     context: context,
                              //     builder: (context) => AlertDialog(
                              //           content: SizedBox(
                              //             width: double.infinity,
                              //             child: SingleChildScrollView(
                              //               scrollDirection: Axis.vertical,
                              //               child: Column(
                              //                 children: [
                              //                   Text(
                              //                     _notiController
                              //                         .notiList[index].title,
                              //                     style: const TextStyle(
                              //                         fontSize: 17,
                              //                         fontWeight:
                              //                             FontWeight.bold),
                              //                   ),
                              //                   const Gap(20),
                              //                   Text(_notiController
                              //                       .notiList[index].message),
                              //                 ],
                              //               ),
                              //             ),
                              //           ),
                              //         )).then((value) {
                                _notiController
                                    .readNoti(
                                        valueHolder.loginUserToken ?? '',
                                        int.parse(
                                            valueHolder.loginUserId ?? ''),
                                        _notiController.notiList[index].id)
                                    .then((value) {
                                  if (value) {
                                    _notiController.callNoti(
                                        valueHolder.loginUserToken ?? '',
                                        int.parse(
                                            valueHolder.loginUserId ?? ''));
                                  }
                                });
                             // }
                              //);
                            },
                            child: NotificationListItem(
                              title: _notiController.notiList[index].title,
                              date: _notiController.notiList[index].created,
                              id: _notiController.notiList[index].id,
                              message: _notiController.notiList[index].message,
                              status: _notiController.notiList[index].status,
                            ),
                          ),
                      separatorBuilder: (context, index) => const Gap(20),
                      itemCount: _notiController.notiList.length)),
          const Gap(70)
        ],
      ),
    );
  }
}
