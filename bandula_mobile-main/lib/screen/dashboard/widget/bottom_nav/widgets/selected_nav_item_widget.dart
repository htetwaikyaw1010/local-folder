import 'package:flutter/material.dart';

import '../../../../../config/master_colors.dart';

class SelectedNavItemWidget extends StatelessWidget {
  const SelectedNavItemWidget({super.key, required this.icon});
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        icon,
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: MasterColors.mainColor,
          ),
        )
      ],
    );
  }
}
