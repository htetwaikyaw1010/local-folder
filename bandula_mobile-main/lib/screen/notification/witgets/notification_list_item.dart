import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../config/master_colors.dart';
import '../../../core/constant/dimesions.dart';

class NotificationListItem extends StatefulWidget {
  final String title;
  final String status;
  final String message;
  final int id;
  final String date;
  const NotificationListItem({
    super.key,
    required this.title,
    required this.status,
    required this.message,
    required this.id,
    required this.date,
  });

  @override
  State<NotificationListItem> createState() => _NotificationListItemState();
}

class _NotificationListItemState extends State<NotificationListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: widget.status == "1"
            ? MasterColors.black.withOpacity(0.03)
            : Color.fromRGBO(254, 242, 0, 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: Dimesion.height20),
            width: 40,
            height: 40,
            child: SvgPicture.asset(
              "assets/images/icons/purchase_success.svg",
              color: MasterColors.mainColor,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Dimesion.height150,
                child: Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: MasterColors.black,
                      ),
                ),
              ),
              SizedBox(
                height: Dimesion.height5,
              ),
              Text(
                  widget.message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey,fontSize: 14),
                      
                ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.access_time_filled,
                    color: Colors.grey.shade400,
                  ),
                  SizedBox(
                    width: Dimesion.height5,
                  ),
                  Text(
                    widget.date.split("T").first,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey,fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
