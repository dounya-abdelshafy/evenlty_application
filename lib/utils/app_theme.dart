import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    textTheme: TextTheme(
      headlineLarge: AppStyles.bold20Black,
      headlineMedium: AppStyles.bold16Primary,
      headlineSmall: AppStyles.medium16White,
      titleLarge: AppStyles.medium16Black,
    ),
    dividerColor: AppColors.blackColor,
    focusColor: AppColors.whiteColor,
    appBarTheme: AppBarTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.transparentColor,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedItemColor: AppColors.whiteColor,
      unselectedItemColor: AppColors.whiteColor,
      selectedLabelStyle: AppStyles.bold12White,
      unselectedLabelStyle: AppStyles.bold12White,
    ),
    primaryColor: AppColors.primaryLight,
    scaffoldBackgroundColor: AppColors.whiteBgColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryLight,
      shape: StadiumBorder(
        side: BorderSide(
          color: AppColors.whiteColor,
          width: 5,
        )
      ),
      // RoundedRectangleBorder(
      //   borderRadius: BorderRadiusGeometry.circular(30),
      //   side: BorderSide(
      //     color: AppColors.whiteColor,
      //     width: 4
      //   ),
      // ),
    ),
  );


  static final ThemeData darkTheme = ThemeData(
    textTheme: TextTheme(
      headlineLarge: AppStyles.bold20White,
      headlineMedium: AppStyles.medium16White,
      headlineSmall: AppStyles.medium16White,
      titleLarge: AppStyles.medium16White,
    ),
    dividerColor: AppColors.whiteColor,
    focusColor: AppColors.primaryLight,
    appBarTheme: AppBarTheme(
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.transparentColor,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedItemColor: AppColors.whiteColor,
      unselectedItemColor: AppColors.whiteColor,
      selectedLabelStyle: AppStyles.bold12White,
      unselectedLabelStyle: AppStyles.bold12White,
    ),
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.primaryDark,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryDark,
      shape: StadiumBorder(
          side: BorderSide(
            color: AppColors.whiteColor,
            width: 5,
          )
      ),
      // RoundedRectangleBorder(
      //   borderRadius: BorderRadiusGeometry.circular(30),
      //   side: BorderSide(
      //     color: AppColors.whiteColor,
      //     width: 4
      //   ),
      // ),
    ),
  );
}
