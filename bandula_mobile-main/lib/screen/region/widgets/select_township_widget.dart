import 'package:flutter/material.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import 'package:bandula/core/viewobject/township.dart';
import '../../../../config/master_colors.dart';
import '../../../../core/constant/dimesions.dart';

class SelectTownshipWidget extends StatefulWidget {
  const SelectTownshipWidget({
    super.key,
    required this.townshipList,
    required this.selectedRegion,
    required this.codFun,
  });

  final List<Township> townshipList;
  final TextEditingController selectedRegion;

  final Function codFun;
  @override
  State<SelectTownshipWidget> createState() => _SelectTownshipWidgetState();
}

class _SelectTownshipWidgetState extends State<SelectTownshipWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimesion.height10),
      padding: EdgeInsets.symmetric(horizontal: Dimesion.height20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "township".tr,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: MasterColors.black,
                  fontWeight: FontWeight.w700,
                ),
          ),
          Container(
            margin: EdgeInsets.only(top: Dimesion.height10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(254, 242, 0, 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0.1,
                  blurRadius: 10,
                  offset: const Offset(0, 1),
                )
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: Dimesion.width20),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    readOnly: true,
                    autofocus: false,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 10),
                      hintText: widget.selectedRegion.text,
                      hintStyle:
                          Theme.of(context).textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w300,
                                color: MasterColors.black,
                              ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_up,
                    size: Dimesion.iconSize16 + 5,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w300,
                        color: MasterColors.black,
                      ),
                  items: widget.townshipList.map<DropdownMenuItem<Township>>(
                    (value) {
                      return DropdownMenuItem<Township>(
                        value: value,
                        child: Text(
                          value.townshipName.toString(),
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    },
                  ).toList(),
                  underline: Container(height: 0),
                  onChanged: (Township? newValue) {
                    setState(
                      () {
                        widget.selectedRegion.text =
                            newValue?.townshipName.toString() ?? "";
                        widget.codFun(newValue);
                        setState(() {});
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
