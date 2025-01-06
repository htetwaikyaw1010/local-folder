import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import '../../../../config/master_colors.dart';
import '../../../../core/constant/dimesions.dart';
import '../../../config/route/route_paths.dart';
import '../../../core/provider/cart/cart_provider.dart';
import '../../../core/provider/payment/payment_provider.dart';
import '../../../core/repository/payment_repository.dart';
import '../../../core/utils/utils.dart';
import '../../../core/viewobject/common/master_value_holder.dart';
import '../../../core/viewobject/payment.dart';
import '../../common/button_widgets.dart';
import '../../common/dialog/warning_dialog_view.dart';
import '../widgets/payment_list.dart';
import '../widgets/select_image_widget.dart';

class CheckoutManualScreen extends StatefulWidget {
  const CheckoutManualScreen({
    super.key,
    required this.region,
    required this.name,
    required this.phone,
    required this.address,
    required this.totalFee,
    required this.fees,
    required this.paymentName,
    required this.regionId,
  });

  final String region;
  final String name;
  final String phone;
  final String address;
  final String totalFee;
  final String regionId;
  final String paymentName;
  final String fees;
  @override
  State<CheckoutManualScreen> createState() => _CheckoutManualScreenState();
}

enum SingingCharacter { lafayette, jefferson }

class _CheckoutManualScreenState extends State<CheckoutManualScreen> {
  @override
  void initState() {
    super.initState();
  }

  late XFile image;
  String imgPath = '';
  bool isSelected = true;
  late Payment selectedPayment;
  MasterValueHolder? valueHolder;

  bool isloading = true;

  @override
  Widget build(BuildContext context) {
    valueHolder = Provider.of<MasterValueHolder>(context);

    final PaymentRepository paymentRepository =
        Provider.of<PaymentRepository>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PaymentProvider>(
          lazy: false,
          create: (BuildContext context) {
            PaymentProvider paymentProvider =
                PaymentProvider(repo: paymentRepository);
            paymentProvider.loadDataList();
            return paymentProvider;
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          toolbarHeight: 60,
          title: Text(
            'manual_checkout'.tr,
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimesion.height20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: Dimesion.height20,
                ),
                Text(
                  "checkout_desc".tr,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimesion.font12,
                      fontWeight: FontWeight.w400),
                ),
                PaymentList(select: (Payment a) {
                  isSelected = false;
                  selectedPayment = a;
                }),
                SelectImageWidget(
                  file: (XFile file) {
                    imgPath = file.path;
                    image = file;
                  },
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "ငွေလွှဲပြီးပါက Screenshot ပို့ရန်\n Upload Payment ကို နှိပ်ပေးပါ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<CartProvider>(
                  builder:
                      (BuildContext context, CartProvider pro, Widget? child) {
                    return Container(
                      margin: EdgeInsets.only(bottom: Dimesion.height40),
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimesion.width20,
                      ),
                      height: Dimesion.height40 * 2.5,
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
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                widget.totalFee,
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
                                if (isSelected) {
                                  callWarningDialog(
                                      context, 'warning_dialog_payment'.tr);
                                } else if (imgPath == '') {
                                  callWarningDialog(context,
                                      'warning_dialog_no_upload_payment_ss'.tr);
                                } else {
                                  pro.createOrder(
                                    context,
                                    () async {
                                      Navigator.pushNamed(
                                        context,
                                        RoutePaths.successScreen,
                                      );
                                    },
                                    token: valueHolder!.loginUserToken ?? '',
                                    name: widget.name,
                                    userid: valueHolder!.loginUserId ?? '',
                                    phone: widget.phone,
                                    address: widget.address,
                                    paymentId: selectedPayment.id.toString(),
                                    carts: pro.getCartDataList(),
                                    regionId: widget.regionId,
                                    paymentName: selectedPayment.name ?? "",
                                    fees: widget.fees,
                                    email: valueHolder!.loginUserEmail!,
                                    file: image,
                                  );
                                }
                              },
                              child: BigButton(
                                text: "make_order".tr,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Dimesion.height15,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
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
