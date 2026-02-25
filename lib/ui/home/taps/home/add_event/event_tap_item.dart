import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class EventTapItem extends StatelessWidget {
  String eventName;
  bool isSelected;
  Color? borderColor;
  Color selectedBgColor;
  TextStyle selectedTextStyle;
  TextStyle unselectedTextStyle;

  EventTapItem({
    super.key,
    required this.eventName,
    required this.isSelected,
    this.borderColor,
    required this.selectedBgColor,
    required this.selectedTextStyle,
    required this.unselectedTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.01),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.005,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(46),
        border: BoxBorder.all(
          color: borderColor ?? Theme.of(context).focusColor,
          width: 1,
        ),
        color: isSelected
            ? selectedBgColor
            : AppColors.transparentColor,
      ),
      child: Text(
        eventName,
        style: isSelected
            ? selectedTextStyle
            : unselectedTextStyle,
      ),
    );
  }
}
