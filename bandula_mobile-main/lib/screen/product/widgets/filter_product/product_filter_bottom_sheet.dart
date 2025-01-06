import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bandula/core/provider/generation/generation_provider.dart';
import 'package:bandula/core/viewobject/comp_cpu.dart';
import 'package:bandula/core/viewobject/generation.dart';

import '../../../../config/master_colors.dart';
import '../../../../core/constant/dimesions.dart';
import '../../../../core/provider/comp_cpu/comp_cpu_provider.dart';
import '../../../../core/repository/comp_cpu_repository.dart';
import '../../../../core/repository/generation_repository.dart';

class ProductFilterBottomShetWiget extends StatefulWidget {
  const ProductFilterBottomShetWiget({
    Key? key,
    required this.dataFn,
  }) : super(key: key);
  final Function dataFn;
  @override
  State<ProductFilterBottomShetWiget> createState() =>
      _ProductFilterBottomShetWigetState();
}

class _ProductFilterBottomShetWigetState
    extends State<ProductFilterBottomShetWiget> {
  RangeValues currentRangeValues = const RangeValues(0, 1000000);

  TextEditingController cpuText = TextEditingController();
  TextEditingController generationText = TextEditingController();
  String cpuID = 'CPU';
  String generationID = 'Generation';
  @override
  void initState() {
    cpuText.text = 'CPU';
    generationText.text = 'Generation';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CompCPURepository repository =
        Provider.of<CompCPURepository>(context);

    final GenerationRepository generationRepository =
        Provider.of<GenerationRepository>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CompCPUProvier>(
          lazy: false,
          create: (BuildContext context) {
            CompCPUProvier provider = CompCPUProvier(repo: repository);
            provider.loadDataList();
            return provider;
          },
        ),
        ChangeNotifierProvider<GenerationProvier>(
          lazy: false,
          create: (BuildContext context) {
            GenerationProvier provider =
                GenerationProvier(repo: generationRepository);
            provider.loadDataList();
            return provider;
          },
        )
      ],
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimesion.height20),
        height: 400,
        decoration: BoxDecoration(
            color: Color.fromRGBO(254, 242, 0, 1),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: Dimesion.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: MasterColors.textColor2,
                        fontWeight: FontWeight.normal),
                  ),
                  InkWell(
                    child: const Icon(Icons.close),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
            const Divider(
              color: Colors.black26,
              height: 1,
            ),
            Container(
                margin: EdgeInsets.only(
                    top: Dimesion.height5, right: Dimesion.height20),
                child: Text(
                  'Price Range',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: MasterColors.black,
                      ),
                )),
            RangeSlider(
              values: currentRangeValues,
              max: 10000000,
              divisions: 20,
              activeColor: MasterColors.mainColor,
              labels: RangeLabels(
                '${NumberFormat("#,##0", "en_Us").format(currentRangeValues.start.round()).toString()} MMK',
                '${NumberFormat("#,##0", "en_Us").format(currentRangeValues.end.round()).toString()} MMK',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  currentRangeValues = values;
                });
              },
            ),
            const Divider(
              color: Colors.black26,
              height: 1,
            ),
            SizedBox(
              height: Dimesion.height10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<CompCPUProvier>(builder:
                    (BuildContext context, CompCPUProvier pro, Widget? child) {
                  return pro.hasData
                      ? Container(
                          width: Dimesion.height140,
                          alignment: Alignment.center,
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
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.black),
                                  readOnly: true,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.only(left: 10),
                                      hintText: cpuText.text,
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                            fontWeight: FontWeight.w300,
                                            color: MasterColors.black,
                                          ),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none),
                                ),
                              ),
                              Expanded(
                                child: DropdownButton<CompCPU>(
                                  isExpanded: true,
                                  borderRadius: BorderRadius.circular(12),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimesion.height20),
                                  alignment: Alignment.center,
                                  icon: const Icon(Icons.keyboard_arrow_up),
                                  elevation: 16,
                                  // value: dropdownValue,
                                  style: const TextStyle(color: Colors.black),
                                  underline: Container(
                                    height: 2,
                                  ),
                                  onChanged: (CompCPU? value) {
                                    setState(() {
                                      cpuID = value!.id!.toString();
                                      cpuText.text = value.name!;
                                    });
                                  },
                                  items: pro.dataList.data!
                                      .map<DropdownMenuItem<CompCPU>>(
                                          (CompCPU value) {
                                    return DropdownMenuItem<CompCPU>(
                                      value: value,
                                      child: Text(value.name ?? ''),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        )
                      : Container();
                }),
                Consumer<GenerationProvier>(builder: (BuildContext context,
                    GenerationProvier pro, Widget? child) {
                  return pro.hasData
                      ? Container(
                          width: Dimesion.height140,
                          alignment: Alignment.center,
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
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.black),
                                  readOnly: true,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.only(left: 10),
                                      hintText: generationText.text,
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                            fontWeight: FontWeight.w300,
                                            color: MasterColors.black,
                                          ),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none),
                                ),
                              ),
                              Expanded(
                                child: DropdownButton<Generation>(
                                  isExpanded: true,
                                  borderRadius: BorderRadius.circular(12),
                                  // padding: EdgeInsets.symmetric(
                                  //     horizontal: Dimesion.height20),
                                  alignment: Alignment.center,
                                  icon: const Icon(Icons.keyboard_arrow_up),
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  underline: Container(
                                    height: 2,
                                  ),
                                  onChanged: (Generation? value) {
                                    setState(() {
                                      generationID = value!.id!.toString();
                                      generationText.text = value.name!;
                                    });
                                  },
                                  items: pro.dataList.data!
                                      .map<DropdownMenuItem<Generation>>(
                                          (Generation value) {
                                    return DropdownMenuItem<Generation>(
                                      value: value,
                                      child: Text(value.name ?? ''),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        )
                      : Container();
                }),
              ],
            ),
            SizedBox(
              height: Dimesion.height20,
            ),
            const Divider(
              color: Colors.black26,
              height: 1,
            ),
            SizedBox(
              height: Dimesion.height20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {},
                  child: Container(
                      width: Dimesion.height140,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: MasterColors.mainColor!),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      child: Text(
                        'Reset',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: MasterColors.mainColor,
                            ),
                      )),
                ),
                InkWell(
                  onTap: () async {
                    widget.dataFn(currentRangeValues.start,
                        currentRangeValues.end, generationID, cpuID);
                  },
                  child: Container(
                    width: Dimesion.height140,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: MasterColors.mainColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    child: Text(
                      'Apply',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Color.fromRGBO(254, 242, 0, 1),
                          ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
