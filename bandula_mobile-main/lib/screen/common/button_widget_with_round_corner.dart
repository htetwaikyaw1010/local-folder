import 'package:flutter/material.dart';

import '../../config/master_colors.dart';
import '../../core/constant/dimesions.dart';

class ButtonWidgetRoundCorner extends StatefulWidget {
  const ButtonWidgetRoundCorner(
      {super.key,
      this.onPressed,
      this.titleText = '',
      this.titleTextColor,
      this.titleTextAlign = TextAlign.center,
      this.colorData,
      this.width,
      this.height,
      this.gradient,
      this.hasBorder = false,
      this.hasShadow = false});

  final Function? onPressed;
  final String titleText;
  final Color? titleTextColor;
  final Color? colorData;
  final double? width;
  final double? height;
  final bool hasBorder;
  final Gradient? gradient;
  final bool hasShadow;
  final TextAlign titleTextAlign;

  @override
  State<ButtonWidgetRoundCorner> createState() =>
      _ButtonWidgetRoundCornerState();
}

class _ButtonWidgetRoundCornerState extends State<ButtonWidgetRoundCorner> {
  Color? _color;
  Color? _titleTextColor;
  @override
  Widget build(BuildContext context) {
    _color = widget.colorData;

    _titleTextColor = widget.titleTextColor;

    // _titleTextColor ??= MasterColors.baseColor;

    _color ??= MasterColors.primary500;

    return Container(
      width: widget.width,
      height: widget.height ?? 46,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
        color: _color,
      ),
      child: Material(
        color: _color,
        type: MaterialType.card,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            side: widget.hasBorder
                ? const BorderSide(color: Colors.grey)
                : BorderSide.none,
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: InkWell(
          onTap: widget.onPressed as void Function()?,
          highlightColor: MasterColors.primary900,
          child: Center(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  left: Dimesion.height10, right: Dimesion.height10),
              child: Text(
                widget.titleText,
                textAlign: widget.titleTextAlign,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: _titleTextColor),
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
      this.gradient,
      this.icon,
      this.iconAlignment = MainAxisAlignment.center,
      this.hasShadow = false,
      this.iconColor});

  final Function? onPressed;
  final String titleText;
  final Color? colorData;
  final double? width;
  final IconData? icon;
  final Gradient? gradient;
  final MainAxisAlignment iconAlignment;
  final bool hasShadow;
  final Color? iconColor;

  @override
  State<ButtonWithIconWidget> createState() => _ButtonWithIconWidgetState();
}

class _ButtonWithIconWidgetState extends State<ButtonWithIconWidget> {
  Color? _color;
  Color? _iconColor;

  @override
  Widget build(BuildContext context) {
    _color = widget.colorData;

    _iconColor = widget.iconColor;

    // _iconColor ??= MasterColors.baseColor;

    _color ??= MasterColors.primary500;

    return Container(
      width: widget.width, //MediaQuery.of(context).size.width,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
        color: _color,
      ),
      child: Material(
        color: _color,
        type: MaterialType.card,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: widget.onPressed as void Function()?,
          highlightColor: MasterColors.buttonColor,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: widget.iconAlignment,
            children: <Widget>[
              if (widget.icon != null) Icon(widget.icon, color: _iconColor),
              if (widget.icon != null && widget.titleText != '')
                SizedBox(
                  width: Dimesion.height10 + 2,
                ),
              Text(widget.titleText,
                  style: Theme.of(context).textTheme.labelLarge!),
            ],
          ),
        ),
      ),
    );
  }
}

// class ButtonWidgetWithIconRoundCorner extends StatefulWidget {
//   const ButtonWidgetWithIconRoundCorner(
//       {super.key,
//       this.onPressed,
//       this.titleText = '',
//       this.titleTextAlign = TextAlign.center,
//       this.colorData,
//       this.width,
//       this.icon,
//       this.gradient,
//       this.iconColor,
//       this.iconAlignment = MainAxisAlignment.center,
//       this.hasShadow = false});

//   final Function? onPressed;
//   final String titleText;
//   final Color? colorData;
//   final double? width;
//   final IconData? icon;
//   final Gradient? gradient;
//   final bool hasShadow;
//   final TextAlign titleTextAlign;
//   final MainAxisAlignment iconAlignment;
//   final Color? iconColor;

//   @override
//   State<ButtonWidgetWithIconRoundCorner> createState() =>
//       _ButtonWidgetWithIconRoundCornerState();
// }

// class _ButtonWidgetWithIconRoundCornerState
//     extends State<ButtonWidgetWithIconRoundCorner> {
//   Color? _color;
//   Color? _iconColor;

//   @override
//   Widget build(BuildContext context) {
//     _color = widget.colorData;

//     _iconColor = widget.iconColor;

//     _iconColor ??= Color.fromRGBO(254, 242, 0, 1);

//     _color ??= MasterColors.primary500;

//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 40,
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.all(
//           Radius.circular(4.0),
//         ),
//         color: _color,
//       ),
//       child: Material(
//         color: _color,
//         type: MaterialType.card,
//         clipBehavior: Clip.antiAlias,
//         shape: RoundedRectangleBorder(
//             side: BorderSide(color: MasterColors.secondary50),
//             borderRadius:
//                 BorderRadius.all(Radius.circular(Dimesion.height10 - 2))),
//         child: InkWell(
//           onTap: widget.onPressed as void Function()?,
//           highlightColor: MasterColors.primary900,
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: widget.iconAlignment,
//             children: <Widget>[
//               if (widget.icon != null) Icon(widget.icon, color: _iconColor),
//               if (widget.icon != null && widget.titleText != '')
//                 SizedBox(
//                   width: Dimesion.height10 / 2,
//                 ),
//               Text(
//                 widget.titleText.toUpperCase(),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     color: widget.titleText == 'edit_profile__title'.tr ||
//                             widget.titleText == 'Reset'.tr ||
//                             widget.titleText == 'map_filter__reset'.tr
//                         ? MasterColors.mainColor //MasterColors.primary500
//                         : MasterColors.textColor4 //Color.fromRGBO(254, 242, 0, 1)
//                     ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class ButtonWidgetWithIconRoundCorner2 extends StatefulWidget {
  const ButtonWidgetWithIconRoundCorner2(
      {super.key,
      this.onPressed,
      this.titleText = '',
      this.titleTextAlign = TextAlign.center,
      this.colorData,
      this.width,
      this.icon,
      this.gradient,
      this.iconColor,
      this.iconAlignment = MainAxisAlignment.center,
      this.hasShadow = false});

  final Function? onPressed;
  final String titleText;
  final Color? colorData;
  final double? width;
  final IconData? icon;
  final Gradient? gradient;
  final bool hasShadow;
  final TextAlign titleTextAlign;
  final MainAxisAlignment iconAlignment;
  final Color? iconColor;

  @override
  State<ButtonWidgetWithIconRoundCorner2> createState() =>
      _ButtonWidgetWithIconRoundCorner2State();
}

class _ButtonWidgetWithIconRoundCorner2State
    extends State<ButtonWidgetWithIconRoundCorner2> {
  Color? _color;
  Color? _iconColor;

  @override
  Widget build(BuildContext context) {
    _color = widget.colorData;

    _iconColor = widget.iconColor;

    _iconColor ??= Color.fromRGBO(254, 242, 0, 1);

    _color ??= MasterColors.primary500;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: MasterColors.secondary400),
        color: _color,
      ),
      child: Material(
        color: _color,
        type: MaterialType.card,
        clipBehavior: Clip.antiAlias,
        // shape: RoundedRectangleBorder(
        //     side: BorderSide(color: MasterColors.secondary50),
        //     borderRadius:
        //         const BorderRadius.all(Radius.circular(MasterDimesion.height6))),
        child: InkWell(
          onTap: widget.onPressed as void Function()?,
          highlightColor: MasterColors.primary900,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.titleText.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: MasterColors.textColor2,
                      fontWeight:
                          FontWeight.normal //Color.fromRGBO(254, 242, 0, 1)
                      ),
                ),
              ),
              if (widget.icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(widget.icon, color: _iconColor),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
