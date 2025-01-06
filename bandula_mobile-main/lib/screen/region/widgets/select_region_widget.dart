import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import 'package:bandula/core/viewobject/holder/request_path_holder.dart';
import '../../../../config/master_colors.dart';
import '../../../../core/constant/dimesions.dart';
import '../../../core/provider/township/township_provider.dart';
import '../../../core/viewobject/region.dart';

class SelectRegionWidget extends StatefulWidget {
  const SelectRegionWidget({
    super.key,
    required this.regionList,
    required this.selectedRegion,
    required this.townshipFun,
  });

  final List<Region> regionList;
  final TextEditingController selectedRegion;
  final Function townshipFun;

  @override
  State<SelectRegionWidget> createState() => _SelectRegionWidgetState();
}

class _SelectRegionWidgetState extends State<SelectRegionWidget> {
  @override
  Widget build(BuildContext context) {
    final TownshipProvider townshipProvider =
        Provider.of<TownshipProvider>(context);
    return Container(
      margin: EdgeInsets.only(top: Dimesion.height10),
      padding: EdgeInsets.symmetric(horizontal: Dimesion.height20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "region".tr,
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
                borderRadius: BorderRadius.circular(12)),
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
                        focusedBorder: InputBorder.none),
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
                  items: widget.regionList.map<DropdownMenuItem<Region>>(
                    (value) {
                      return DropdownMenuItem<Region>(
                        value: value,
                        child: Text(
                          value.regionName.toString(),
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    },
                  ).toList(),
                  underline: Container(height: 0),
                  onChanged: (Region? newValue) async {
                    await townshipProvider.loadDataList(
                      reset: true,
                      requestPathHolder: RequestPathHolder(
                        regionId: newValue!.id.toString(),
                      ),
                    );
                    setState(
                      () {
                        widget.selectedRegion.text =
                            newValue.regionName.toString();
                        widget.townshipFun(newValue);
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
