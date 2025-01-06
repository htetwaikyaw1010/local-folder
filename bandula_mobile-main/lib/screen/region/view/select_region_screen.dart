import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import 'package:bandula/core/provider/region/region_provider.dart';
import 'package:bandula/core/provider/township/township_provider.dart';
import 'package:bandula/core/repository/region_repository.dart';
import 'package:bandula/core/repository/township_repository.dart';
import 'package:bandula/core/viewobject/region.dart';
import '../../../../config/master_colors.dart';
import '../../../../core/constant/dimesions.dart';
import '../../../config/route/route_paths.dart';
import '../../../core/provider/cart/cart_provider.dart';
import '../../../core/utils/utils.dart';
import '../../../core/viewobject/common/master_value_holder.dart';
import '../../../core/viewobject/holder/intent_holder/order_checkout_intent_holder.dart';
import '../../../core/viewobject/township.dart';
import '../../common/button_widgets.dart';
import '../../common/dialog/warning_dialog_view.dart';
import '../../common/textfield_widget_with_icon.dart';
import '../widgets/select_region_widget.dart';
import '../widgets/select_township_widget.dart';

class SelectRegionScreen extends StatefulWidget {
  const SelectRegionScreen({
    super.key,
  });
  @override
  State<SelectRegionScreen> createState() => _SelectRegionScreenState();
}

class _SelectRegionScreenState extends State<SelectRegionScreen> {
  TextEditingController regionController = TextEditingController();
  TextEditingController townshipController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    regionController.text = 'select_region'.tr;
    townshipController.text = 'select_township'.tr;

    super.initState();
  }

  late TownshipProvider townshipProvider;
  bool isCod = true;
  String deliveryFee = '0';
  String regionID = '0';
  String fees = '0';
  MasterValueHolder? valueHolder;

  @override
  Widget build(BuildContext context) {
    final RegionRepository regionRepository =
        Provider.of<RegionRepository>(context);
    final TownshipRepository townshipRepository =
        Provider.of<TownshipRepository>(context);
    valueHolder = Provider.of<MasterValueHolder>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RegionProvider>(
            lazy: false,
            create: (BuildContext context) {
              RegionProvider regionProvider =
                  RegionProvider(repo: regionRepository);
              regionProvider.loadDataList();
              return regionProvider;
            }),
        ChangeNotifierProvider<TownshipProvider>(
            lazy: false,
            create: (BuildContext context) {
              townshipProvider = TownshipProvider(repo: townshipRepository);
              // townshipProvider.loadDataList();
              return townshipProvider;
            }),
      ],
      child: Scaffold(
        // backgroundColor: MasterColors.grey,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          title: Text(
            'region_and_deli'.tr,
            style: TextStyle(color: Color.fromRGBO(254, 242, 0, 1)),
          ),
          titleTextStyle: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Color.fromRGBO(254, 242, 0, 1)),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Consumer<CartProvider>(
              builder: (BuildContext context, CartProvider pro, Widget? child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Consumer<RegionProvider>(
                  builder: (BuildContext context, RegionProvider pro,
                      Widget? child) {
                    return SelectRegionWidget(
                      regionList: pro.regionList,
                      selectedRegion: regionController,
                      townshipFun: (Region? newValue) {
                        townshipController.text = 'select_township'.tr;
                        setState(() {
                          regionID = newValue?.id.toString() ?? "";
                        });
                      },
                    );
                  },
                ),
                Consumer<TownshipProvider>(
                  builder: (BuildContext context, TownshipProvider pro,
                      Widget? child) {
                    return SelectTownshipWidget(
                      townshipList: pro.townshipList,
                      selectedRegion: townshipController,
                      codFun: (Township? data) {
                        setState(() {
                          deliveryFee = data?.fees ?? "";
                          print("fee : $deliveryFee");
                          fees = data?.townshipID.toString() ?? "";
                        });
                      },
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimesion.height20, top: Dimesion.height10),
                  child: Text(
                    "name".tr,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: MasterColors.black,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimesion.width20),
                    child: MasterTextFieldWidget(
                        hintText: "name".tr,
                        textEditingController: nameController)),
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimesion.height20, top: Dimesion.height10),
                  child: Text(
                    "phone".tr,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: MasterColors.black,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimesion.width20),
                    child: MasterTextFieldWidget(
                        keyboardType: TextInputType.phone,
                        hintText: "phone".tr,
                        textEditingController: phoneController)),
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimesion.height20, top: Dimesion.height10),
                  child: Text(
                    "address".tr,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: MasterColors.black,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimesion.width20),
                  child: MasterTextFieldWidget(
                    hintText: "address".tr,
                    textEditingController: addressController,
                  ),
                ),
              ],
            );
          }),
        ),
        bottomNavigationBar: Consumer<CartProvider>(
          builder: (BuildContext context, CartProvider pro, Widget? child) {
            return Container(
              margin: EdgeInsets.only(bottom: Dimesion.height40),
              padding: EdgeInsets.symmetric(
                horizontal: Dimesion.width20,
              ),
              height: Dimesion.height40 * 3.5,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "total".tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimesion.font16,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '${NumberFormat("#,##0", "en_Us").format(pro.totalCost + double.parse(deliveryFee))} MMK',
                        style: TextStyle(
                          color: MasterColors.mainColor,
                          fontSize: Dimesion.font16,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Dimesion.height15,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        if (regionController.text == 'select_region'.tr) {
                          callWarningDialog(
                              context, 'warning_dialog_region'.tr);
                        } else if (townshipController.text ==
                            'select_township'.tr) {
                          callWarningDialog(
                              context, 'warning_dialog_township'.tr);
                        } else if (nameController.text == '') {
                          callWarningDialog(context, 'warning_dialog_name'.tr);
                        } else if (phoneController.text == '') {
                          callWarningDialog(context, 'warning_dialog_phone'.tr);
                        } else if (addressController.text == '') {
                          callWarningDialog(
                              context, 'warning_dialog_address'.tr);
                        } else {
                          OrderCheckoutIntentHolder holder =
                              OrderCheckoutIntentHolder(
                            region: regionID,
                            name: nameController.text,
                            phone: phoneController.text,
                            address: addressController.text,
                            totalFee:
                                '${NumberFormat("#,##0", "en_Us").format(pro.totalCost + double.parse(deliveryFee))} MMK',
                            fees: fees,
                            paymentName: '',
                          );
                          Navigator.pushNamed(
                            context,
                            RoutePaths.manualCheckout,
                            arguments: holder,
                          );
                        }
                      },
                      child: BigButton(
                        text: "pay_manually".tr,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
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
}
