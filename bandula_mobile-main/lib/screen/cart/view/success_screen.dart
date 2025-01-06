import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';

import '../../../config/master_colors.dart';
import '../../../config/route/route_paths.dart';
import '../../../core/constant/dimesions.dart';
import '../../common/button_widgets.dart';

class SuccessfulScreen extends StatefulWidget {
  const SuccessfulScreen({Key? key}) : super(key: key);

  @override
  State<SuccessfulScreen> createState() => _SuccessfulScreenState();
}

class _SuccessfulScreenState extends State<SuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset('assets/lottiefiles/order.png'),
            ),
          ),
          SizedBox(
            height: Dimesion.height15,
          ),
          Text('THANK YOU',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: MasterColors.black, fontSize: Dimesion.font26)),
          SizedBox(
            height: Dimesion.height10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Your order ID " + "#af2013902193 " + "is successfully placed",
              style: TextStyle(
                fontSize: Dimesion.font12,
                color: MasterColors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: Dimesion.height30),
          Container(
              width: Dimesion.screenWidth / 2,
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutePaths.home,
                    );
                  },
                  child: BigButton(text: 'Home'))),
        ],
      ),
    );
  }
}
