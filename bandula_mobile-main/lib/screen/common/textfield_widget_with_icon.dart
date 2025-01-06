import 'package:flutter/material.dart';

import '../../config/master_colors.dart';
import '../../core/constant/dimesions.dart';
import '../../core/utils/utils.dart';

class TextFieldWidgetWithIcon extends StatelessWidget {
  const TextFieldWidgetWithIcon(
      {super.key,
      this.textEditingController,
      this.hintText,
      this.height = 44,
      this.keyboardType = TextInputType.text,
      this.clickEnterFunction,
      this.clickSearchButton});

  final TextEditingController? textEditingController;
  final String? hintText;
  final double height;
  final TextInputType keyboardType;
  final Function? clickEnterFunction;
  final Function? clickSearchButton;

  @override
  Widget build(BuildContext context) {
    final Widget productTextFieldWidget = TextField(
      keyboardType: TextInputType.text,
      maxLines: 1,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.left,
      textInputAction: TextInputAction.search,
      controller: textEditingController,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 14,
          color: Utils.isLightMode(context)
              ? MasterColors.secondary800
              : MasterColors.black),
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.only(left: Dimesion.height16, bottom: Dimesion.height4),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 14,
            color: Utils.isLightMode(context)
                ? MasterColors.secondary800
                : Colors.black54),
        prefixIcon: InkWell(
            child: Icon(
              Icons.search,
              color: Utils.isLightMode(context)
                  ? MasterColors.secondary600
                  : MasterColors.primaryDarkAccent,
            ),
            onTap: () {
              clickSearchButton!();
            }),
      ),
      onSubmitted: (String value) {
        clickEnterFunction!();
      },
    );

    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: height,
          margin: EdgeInsets.all(Dimesion.height12),
          decoration: BoxDecoration(
            color: MasterColors.secondary50,
            borderRadius: BorderRadius.circular(Dimesion.height12),
          ),
          child: productTextFieldWidget,
        ),
      ],
    );
  }
}

class MasterTextFieldWidget extends StatelessWidget {
  const MasterTextFieldWidget({
    super.key,
    this.textEditingController,
    this.hintText,
    this.keyboardType = TextInputType.text,
  });

  final TextEditingController? textEditingController;
  final String? hintText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimesion.height10),
      decoration: BoxDecoration(
        color: MasterColors.grey,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      padding: EdgeInsets.only(
          left: Dimesion.width10,
          ),
      child: Center(
        child: TextFormField(
          keyboardType: keyboardType,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
          controller: textEditingController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: Dimesion.font12,
                color: Colors.grey.shade500),
          ),
        ),
      ),
    );
  }
}

class MasterPasswordTextFieldWidget extends StatefulWidget {
  const MasterPasswordTextFieldWidget({
    super.key,
    this.textEditingController,
    this.hintText,
    this.keyboardType = TextInputType.text,
  });

  final TextEditingController? textEditingController;
  final String? hintText;
  final TextInputType keyboardType;

  @override
  State<MasterPasswordTextFieldWidget> createState() =>
      _MasterPasswordTextFieldWidgetState();
}

class _MasterPasswordTextFieldWidgetState
    extends State<MasterPasswordTextFieldWidget> {
  bool _passwordVisible = false;
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(top: Dimesion.height10),
      decoration: BoxDecoration(
        color: MasterColors.grey,
        borderRadius: BorderRadius.all(Radius.circular(Dimesion.radius5)),
      ),
      padding: EdgeInsets.only(left: Dimesion.width10,top: 4),
      child: Center(
        child: TextFormField(
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
          obscureText: !_passwordVisible,
          controller: widget.textEditingController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: Dimesion.font12,
                  color: Colors.grey.shade500),
              suffixIcon: GestureDetector(
                onTap: () => setState(() {
                  _passwordVisible = !_passwordVisible;
                }),
                child: Icon(
                  _passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off_rounded,
                  color: MasterColors.buttonColor,
                ),
              )),
        ),
      ),
    );
  }
}
