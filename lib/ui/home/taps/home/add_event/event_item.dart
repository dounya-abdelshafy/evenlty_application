import 'package:evently_app/model/events.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider.dart';

class EventItem extends StatelessWidget {
  Event event;

  EventItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.04),
      height: height * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(16),
        border: BoxBorder.all(color: AppColors.primaryLight, width: 2),
        image: DecorationImage(
          image: AssetImage(event.image),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.01,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.002,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.circular(8),
              color: AppColors.whiteColor,
            ),
            child: Column(
              children: [
                Text(
                  event.dateTime.day.toString(),
                  style: AppStyles.bold20Primary,
                ),
                Text(
                  // '${event.dateTime.month}',
                  DateFormat('MMM').format(event.dateTime),
                  style: AppStyles.bold16Primary,
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.01,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.01,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.circular(8),
              color: AppColors.whiteColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(event.title, style: AppStyles.bold16Black),
                ),
                GestureDetector(
                  onTap: () {
                    eventListProvider.updateIsFavourite(event , userProvider.currentUser!.id);
                  },
                  child: event.isFavorite == true
                      ? Icon(
                          Icons.favorite,
                          size: 28,
                          color: AppColors.primaryLight,
                        )
                      : Icon(
                          Icons.favorite_border,
                          size: 28,
                          color: AppColors.primaryLight,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
