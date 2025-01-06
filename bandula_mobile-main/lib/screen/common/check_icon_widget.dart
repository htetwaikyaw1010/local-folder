import 'package:flutter/material.dart';

import '../../config/master_colors.dart';
import '../../core/constant/dimesions.dart';

class CheckedIconWidget extends StatelessWidget {
  const CheckedIconWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimesion.height20,
      height: Dimesion.height20,
      margin: EdgeInsets.only(right: Dimesion.height2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: MasterColors.mainColor,
      ),
      child: Center(
        child: Container(
          width: Dimesion.height5,
          height: Dimesion.height5,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
