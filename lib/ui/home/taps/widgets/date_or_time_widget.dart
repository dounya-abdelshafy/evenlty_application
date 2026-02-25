import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../utils/app_styles.dart';

class DateOrTimeWidget extends StatelessWidget {
  String iconDateOrTimeName;
  String textEventDateOrTime;
  String textButtonChooseDateOrTime;
  VoidCallback onChooseDateOrTimeClicked;
  Color iconColor;

  DateOrTimeWidget({
    super.key,
    required this.iconDateOrTimeName,
    required this.textEventDateOrTime,
    required this.textButtonChooseDateOrTime,
    required this.onChooseDateOrTimeClicked,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Row(
      children: [
        Image.asset(iconDateOrTimeName,
        color: iconColor ?? AppColors.blackColor,),
        SizedBox(width: width * 0.02),
        Text(
          textEventDateOrTime,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Spacer(),
        TextButton(
          onPressed: onChooseDateOrTimeClicked,
          child: Text(
            textButtonChooseDateOrTime,
            style: AppStyles.medium16Primary,
          ),
        ),
      ],
    );
  }
}
