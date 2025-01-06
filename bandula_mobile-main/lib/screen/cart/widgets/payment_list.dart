import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import 'package:bandula/core/viewobject/payment.dart';
import '../../../../config/master_colors.dart';
import '../../../../core/constant/dimesions.dart';
import '../../../core/provider/payment/payment_provider.dart';
import '../../common/dialog/warning_dialog_view.dart';

class PaymentList extends StatefulWidget {
  const PaymentList({
    super.key,
    required this.select,
  });

  final Function select;

  @override
  State<PaymentList> createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  String selectedID = '';

  var random = Random();

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentProvider>(
      builder: (BuildContext context, PaymentProvider pro, Widget? child) {
        return Column(
          children: [
            if (pro.hasData)
              SizedBox(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: pro.dataLength,
                    itemBuilder: (context, index) {
                      bool isSelected =
                          selectedID == pro.getListIndexOf(index,false).id.toString();
                      Payment payment = pro.getListIndexOf(index,false);
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: Dimesion.height5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedID =
                                      pro.getListIndexOf(index,false).id.toString();
                                  widget.select(payment);
                                });

                                Clipboard.setData(
                                        ClipboardData(text: payment.phone!))
                                    .then(
                                  (_) => ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${payment.phone!} Copied to clipboard',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: Color.fromRGBO(
                                                    254, 242, 0, 1)),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: Dimesion.height10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        isSelected
                                            ? SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: Checkbox(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  value: isSelected,
                                                  checkColor: Color.fromRGBO(
                                                      254, 242, 0, 1),
                                                  activeColor:
                                                      MasterColors.black,
                                                  onChanged: (bool? value) {},
                                                ),
                                              )
                                            : SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: Checkbox(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  value: isSelected,
                                                  checkColor: Color.fromRGBO(
                                                      254, 242, 0, 1),
                                                  onChanged: (bool? value) {},
                                                ),
                                              ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          height: 35,
                                          width: 35,
                                          child: pro
                                                      .getListIndexOf(index,false)
                                                      .photo ==
                                                  null
                                              ? CachedNetworkImage(
                                                  memCacheWidth: 100,
                                                  imageUrl: pro
                                                          .getListIndexOf(index,false)
                                                          .photo ??
                                                      '',
                                                  fit: BoxFit.cover,
                                                  errorWidget: (_, __, ___) =>
                                                      Image.asset(
                                                    'assets/images/noimg.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                  progressIndicatorBuilder:
                                                      (_, __, ___) =>
                                                          Image.asset(
                                                    'assets/images/noimg.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : CachedNetworkImage(
                                                  memCacheWidth: 300,
                                                  imageUrl: pro
                                                          .getListIndexOf(index,false)
                                                          .photo ??
                                                      '',
                                                  fit: BoxFit.cover,
                                                  errorWidget: (_, __, ___) =>
                                                      Image.asset(
                                                    'assets/images/noimg.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                  progressIndicatorBuilder:
                                                      (_, __, ___) =>
                                                          Image.asset(
                                                    'assets/images/noimg.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                            height: 35,
                                            width: 35,
                                            child: CachedNetworkImage(
                                              memCacheWidth: 100,
                                              imageUrl: pro
                                                      .getListIndexOf(index,false)
                                                      .qr ??
                                                  '',
                                              fit: BoxFit.cover,
                                              errorWidget: (_, __, ___) =>
                                                  Image.asset(
                                                'assets/images/noimg.png',
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                pro
                                                        .getListIndexOf(index,false)
                                                        .name ??
                                                    '',
                                                maxLines: 3,
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        color:
                                                            MasterColors.black),
                                              ),
                                              Text(
                                                pro
                                                        .getListIndexOf(index,false)
                                                        .phone ??
                                                    '',
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        color:
                                                            MasterColors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // GestureDetector(
                            //   onTap: () async {
                            //     print(pro.getListIndexOf(index).qr ?? '');

                            //     _saveImage(
                            //       context,
                            //       pro.getListIndexOf(index).qr ?? '',
                            //     );
                            //   },
                            //   child: const Icon(Icons.download_outlined),
                            // ),
                          ],
                        ),
                      );
                    }),
              ),
            SizedBox(
              height: Dimesion.height10,
            ),
          ],
        );
      },
    );
  }

  dynamic callWarningDialog(BuildContext context, String text) {
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return WarningDialog(
          message: text.tr,
          onPressed: () {},
        );
      },
    );
  }

  Future<void> _saveImage(BuildContext context, String url) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    late String message;

    try {
      // Download image
      final http.Response response = await http.get(Uri.parse(url));

      // Get temporary directory
      final dir = await getTemporaryDirectory();

      // Create an image name
      var filename = '${dir.path}/SaveImage${random.nextInt(100)}.png';

      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      // Ask the user to save it
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        message = 'Image saved to disk';
      }
    } catch (e) {
      message = e.toString();
      scaffoldMessenger.showSnackBar(SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFe91e63),
      ));
    }

    if (message != null) {
      scaffoldMessenger.showSnackBar(SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFe91e63),
      ));
    }
  }
}
