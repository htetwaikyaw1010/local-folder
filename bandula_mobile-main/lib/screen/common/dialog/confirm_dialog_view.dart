import 'package:flutter/material.dart';

import '../../../config/master_colors.dart';
import '../../../core/constant/dimesions.dart';
import '../../../core/utils/utils.dart';
import '../button_widget_with_round_corner.dart';

class ConfirmDialogView extends StatefulWidget {
  const ConfirmDialogView(
      {Key? key,
      this.description,
      this.leftButtonText,
      this.rightButtonText,
      this.title,
      this.onAgreeTap})
      : super(key: key);

  final String? description, leftButtonText, rightButtonText, title;
  final Function? onAgreeTap;

  @override
  State<ConfirmDialogView> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<ConfirmDialogView> {
  @override
  Widget build(BuildContext context) {
    return NewDialog(widget: widget);
  }
}

class NewDialog extends StatelessWidget {
  const NewDialog({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final ConfirmDialogView widget;

  @override
  Widget build(BuildContext context) {
    final Widget headerWidget = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.contact_support_outlined,
                color: MasterColors.mainColor,
              ),
              SizedBox(
                width: Dimesion.height12,
              ),
              Text(
                widget.title ?? 'Confirmation',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Utils.isLightMode(context)
                        ? MasterColors.secondary800
                        : MasterColors.primaryDarkWhite,
                    fontSize: Dimesion.font18,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );

    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimesion.height8)),
      child: Padding(
        padding: EdgeInsets.all(Dimesion.height16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            headerWidget,
            Container(
              padding: EdgeInsets.only(
                  top: Dimesion.height16, bottom: Dimesion.height24),
              child: Text(
                widget.description!,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              ButtonWidgetRoundCorner(
                  colorData: Colors.grey[50]!,
                  hasShadow: false,
                  width: Dimesion.height80,
                  height: Dimesion.height40,
                  titleText: widget.leftButtonText!,
                  titleTextColor: MasterColors.black,
                  hasBorder: true,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              SizedBox(
                width: Dimesion.height16,
              ),
              ButtonWidgetRoundCorner(
                  colorData: MasterColors.iconRejectColor,
                  hasShadow: false,
                  width: Dimesion.height80,
                  height: Dimesion.height40,
                  titleText: widget.rightButtonText!,
                  titleTextColor: MasterColors.black,
                  onPressed: () {
                    widget.onAgreeTap!();
                  }),
            ])
          ],
        ),
      ),
    );
  }
}
