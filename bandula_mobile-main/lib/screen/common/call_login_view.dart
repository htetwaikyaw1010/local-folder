import 'package:flutter/material.dart';
import '../../../../config/master_colors.dart';
import '../../../../config/route/route_paths.dart';
import '../../../../core/constant/dimesions.dart';

class CallLoginView extends StatelessWidget {
  const CallLoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("You are Not Login Please Login!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: MasterColors.black,
                fontSize: Dimesion.font12 - 2,
              )),
          SizedBox(
            height: Dimesion.height10,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                RoutePaths.login,
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimesion.height18,
              ),
              decoration: BoxDecoration(
                color: MasterColors.mainColor,
                borderRadius: BorderRadius.circular(8),
              ),
              height: Dimesion.height40,
              width: Dimesion.height200,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.login,
                        size: Dimesion.height24,
                        color: Color.fromRGBO(254, 242, 0, 1),
                      ),
                      SizedBox(
                        width: Dimesion.height24,
                      ),
                      Text(
                        'Login',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Color.fromRGBO(254, 242, 0, 1),
                              fontSize: 20,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
