import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';

import '../../../config/master_colors.dart';
import '../../../core/constant/dimesions.dart';

class SelectImageWidget extends StatefulWidget {
  const SelectImageWidget({super.key, required this.file});
  final Function file;

  @override
  State<SelectImageWidget> createState() => _MakeOrderViewWidgetState();
}

class _MakeOrderViewWidgetState extends State<SelectImageWidget> {
  final ImagePicker picker = ImagePicker();
  XFile? image;

  Future<void> getImage(ImageSource media) async {
    // Navigator.pop(context);
    final XFile? img = await picker.pickImage(source: media);

    setState(() {
      image = img;
      widget.file(img);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimesion.height20),
      child: Column(
        children: <Widget>[
          if (image != null)
            Container(
              height: Dimesion.height120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: Dimesion.height20, vertical: Dimesion.height10),
              child: InkWell(
                onTap: () async => await getImage(ImageSource.gallery),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimesion.height10),
                  child: Image.file(
                    File(image!.path),
                    fit: BoxFit.cover,
                    // width: Dimesion.height100,
                    // height: Dimesion.height100,
                  ),
                ),
              ),
            )
          else
            Column(
              children: <Widget>[
                InkWell(
                  onTap: () async => await getImage(ImageSource.gallery),
                  child: Container(
                    height: Dimesion.height120,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimesion.height20,
                        vertical: Dimesion.height10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Dimesion.height24,
                          height: Dimesion.height24,
                          child: SvgPicture.asset(
                            "assets/images/icons/input.svg",
                          ),
                        ),
                        SizedBox(
                          width: Dimesion.height10,
                        ),
                        Text(
                          'upload_payment_ss'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: MasterColors.darkGrey),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  void myAlert() {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(
              'Please choose media to select',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: MasterColors.black),
            ),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () async => await getImage(ImageSource.gallery),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: Dimesion.height4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimesion.height4),
                        border: Border.all(color: MasterColors.black),
                      ),
                      width: Dimesion.height200,
                      height: Dimesion.height32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.image,
                            color: MasterColors.black,
                          ),
                          Text(
                            'From Gallery',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: MasterColors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async => await getImage(ImageSource.camera),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: Dimesion.height4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimesion.height4),
                        border: Border.all(color: MasterColors.black),
                      ),
                      width: Dimesion.height200,
                      height: Dimesion.height32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.camera,
                            color: MasterColors.black,
                          ),
                          Text(
                            'From Camera',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: MasterColors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
