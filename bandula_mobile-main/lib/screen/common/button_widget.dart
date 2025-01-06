import 'package:flutter/material.dart';

import '../../config/master_colors.dart';
import '../../core/constant/dimesions.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget(
      {super.key,
      this.onPressed,
      this.titleText = '',
      this.titleTextAlign = TextAlign.center,
      this.colorData,
      this.width,
      this.gradient,
      this.hasShadow = false});

  final Function? onPressed;
  final String titleText;
  final Color? colorData;
  final double? width;
  final Gradient? gradient;
  final bool hasShadow;
  final TextAlign titleTextAlign;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  Color? _color;
  @override
  Widget build(BuildContext context) {
    _color = widget.colorData;

    _color ??= MasterColors.buttonColor;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(4), color: _color),
      child: Material(
        color: _color,
        type: MaterialType.card,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(Dimesion.height10 / 2))),
        child: InkWell(
          onTap: widget.onPressed as void Function()?,
          highlightColor: MasterColors.buttonColor,
          child: Center(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  left: Dimesion.height10 - 2, right: Dimesion.height10 - 2),
              child: Text(widget.titleText,
                  textAlign: widget.titleTextAlign,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      // color: MasterColors.baseColor,
                      fontSize: 14) //Color.fromRGBO(254, 242, 0, 1)),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonWithIconWidget extends StatefulWidget {
  const ButtonWithIconWidget(
      {super.key,
      this.onPressed,
      this.titleText = '',
      this.colorData,
      this.width,
      this.height,
      this.gradient,
      this.icon,
      this.iconAlignment = MainAxisAlignment.center,
      this.hasShadow = false,
      this.iconColor,
      this.textColor});

  final Function? onPressed;
  final String titleText;
  final Color? colorData;
  final double? width;
  final IconData? icon;
  final Gradient? gradient;
  final MainAxisAlignment iconAlignment;
  final bool hasShadow;
  final Color? iconColor;
  final Color? textColor;

  final double? height;

  @override
  State<ButtonWithIconWidget> createState() => _ButtonWithIconWidgetState();
}

class _ButtonWithIconWidgetState extends State<ButtonWithIconWidget> {
  Color? _color;
  Color? _iconColor;
  Color? _textColor;

  @override
  Widget build(BuildContext context) {
    _color = widget.colorData;

    _iconColor = widget.iconColor;
    _textColor = widget.textColor;
    _iconColor ??= Color.fromRGBO(254, 242, 0, 1);
    _color ??= MasterColors.primary500;
    _textColor ??= Color.fromRGBO(254, 242, 0, 1);

    return Container(
      width: widget.width, //MediaQuery.of(context).size.width,
      height: widget.height ?? 40,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(4), color: _color),
      child: Material(
        color: _color,
        type: MaterialType.card,
        clipBehavior: Clip.antiAlias,
        shape: BeveledRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(Dimesion.height10 - 2))),
        child: InkWell(
          onTap: widget.onPressed as void Function()?,
          highlightColor: MasterColors.primary900,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: widget.iconAlignment,
            children: <Widget>[
              if (widget.icon != null) Icon(widget.icon, color: _iconColor),
              if (widget.icon != null && widget.titleText != '')
                SizedBox(
                  width: Dimesion.height10 + 2,
                ),
              Text(
                widget.titleText,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: _textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
