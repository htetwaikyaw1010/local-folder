import 'package:flutter/material.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';

import '../../../config/master_colors.dart';
import '../../../core/constant/dimesions.dart';
import '../../../core/utils/utils.dart';
import '../button_widget_with_round_corner.dart';

class SuccessDialog extends StatefulWidget {
  const SuccessDialog(
      {super.key, this.message, this.title, this.onPressed, this.btnTitle});
  final String? message, title, btnTitle;
  final Function? onPressed;

  @override
  State<SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog> {
  @override
  Widget build(BuildContext context) {
    return _NewDialog(widget: widget);
  }
}

class _NewDialog extends StatelessWidget {
  const _NewDialog({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final SuccessDialog widget;

  @override
  Widget build(BuildContext context) {
    final Widget headerWidget = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.check_circle,
                color: MasterColors.successColor,
              ),
              SizedBox(
                width: Dimesion.height12,
              ),
              Text(
                widget.title ?? 'Success',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Utils.isLightMode(context)
                        ? MasterColors.secondary800
                        : MasterColors.primaryDarkWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              headerWidget,
              Container(
                padding: EdgeInsets.only(
                    top: Dimesion.height16, bottom: Dimesion.height24),
                child: Text(
                  widget.message!,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w400, color: MasterColors.black),
                ),
              ),
              ButtonWidgetRoundCorner(
                  colorData: MasterColors.buttonColor,
                  hasShadow: false,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  titleText: 'Ok'.tr,
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onPressed!();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
