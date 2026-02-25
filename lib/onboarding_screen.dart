import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return IntroductionScreen(
      globalBackgroundColor: AppColors.whiteColor,
      pages: [
        PageViewModel(
          titleWidget: Column(
            children: [
              Image.asset(AppAssets.onBoardingLogo, height: height * 0.14),

              Image.asset(AppAssets.onBoardingScreen1, height: height * 0.35),
            ],
          ),

          bodyWidget: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.01),
                Text(
                  "Personalize Your Experience",
                  style: AppStyles.bold20Primary,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: height * 0.01),
                Text(
                  "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
                  style: AppStyles.medium16Black,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: height * 0.01),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.language,
                      style: AppStyles.medium20Primary,
                    ),
                    Spacer(),
                    ToggleSwitch(
                      borderColor: [AppColors.primaryLight],
                      minWidth: 45.0,
                      initialLabelIndex: 0,
                      cornerRadius: 20.0,
                      activeFgColor: AppColors.blackColor,
                      inactiveBgColor: AppColors.whiteBgColor,
                      inactiveFgColor: AppColors.blackColor,
                      totalSwitches: 2,
                      customWidgets: [
                        Image.asset(AppAssets.englishIcon),
                        Image.asset(AppAssets.arabicIcon),
                      ],
                      activeBgColors: [
                        [AppColors.primaryLight],
                        [AppColors.primaryLight],
                      ],
                    ),
                  ],
                ),
                SizedBox(height: height * 0.01),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.theme,
                      style: AppStyles.medium20Primary,
                    ),
                    Spacer(),
                    ToggleSwitch(
                      borderColor: [AppColors.primaryLight],
                      minWidth: 45.0,
                      initialLabelIndex: 0,
                      cornerRadius: 20.0,
                      activeFgColor: AppColors.blackColor,
                      inactiveBgColor: AppColors.whiteBgColor,
                      inactiveFgColor: AppColors.blackColor,
                      totalSwitches: 2,
                      customWidgets: [
                        Image.asset(AppAssets.lightMoodIcon),
                        Image.asset(AppAssets.darkMoodIcon),
                      ],
                      activeBgColors: [
                        [AppColors.primaryLight],
                        [AppColors.primaryLight],
                      ],
                    ),
                  ],
                ),
                SizedBox(height: height * 0.03),
                Container(
                  padding: EdgeInsets.symmetric(vertical: height * 0.01),
                  width: width * 0.9,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.primaryLight,
                  ),
                  child: Text("Let's Start", style: AppStyles.medium20White , textAlign: TextAlign.center,),
                ),
              ],
            ),
          ),

          decoration: const PageDecoration(pageColor: AppColors.whiteColor),
        ),

        PageViewModel(
          titleWidget: Column(
            children: [
              Image.asset(AppAssets.onBoardingLogo, height: height * 0.15),

              Image.asset(AppAssets.onBoardingScreen2, height: height * 0.36),
            ],
          ),

          bodyWidget: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: height * 0.05),
                Text(
                  "Find Events That Inspire You",
                  style: AppStyles.bold20Primary,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: height * 0.03),
                Text(
                  "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
                  style: AppStyles.medium16Black,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),

          decoration: const PageDecoration(pageColor: AppColors.whiteColor),
        ),

        PageViewModel(
          titleWidget: Column(
            children: [
              Image.asset(AppAssets.onBoardingLogo, height: height * 0.15),

              Image.asset(AppAssets.onBoardingScreen3, height: height * 0.35),
            ],
          ),

          bodyWidget: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: height * 0.05),
                Text(
                  "Effortless Event Planning",
                  style: AppStyles.bold20Primary,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: height * 0.03),
                Text(
                  "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
                  style: AppStyles.medium16Black,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),

          decoration: const PageDecoration(pageColor: AppColors.whiteColor),
        ),

        PageViewModel(
          titleWidget: Column(
            children: [
              Image.asset(AppAssets.onBoardingLogo, height: height * 0.15),

              Image.asset(AppAssets.onBoardingScreen4, height: height * 0.35),
            ],
          ),

          bodyWidget: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: height * 0.03),
                Text(
                  "Connect with Friends & Share Moments",
                  style: AppStyles.bold20Primary,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: height * 0.02),
                Text(
                  'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.',
                  style: AppStyles.medium16Black,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),

          decoration: const PageDecoration(pageColor: AppColors.whiteColor),
        ),
      ],
      onDone: () {
        Navigator.pushReplacementNamed(context, AppRoutes.loginRouteName);
      },
      showBackButton: true,
      back: Icon(
        Icons.arrow_circle_left_outlined,
        size: 40,
        color: AppColors.primaryLight,
      ),
      next: Icon(
        Icons.arrow_circle_right_outlined,
        size: 40,
        color: AppColors.primaryLight,
      ),
      done: Icon(
        Icons.arrow_circle_right_outlined,
        size: 40,
        color: AppColors.primaryLight,
      ),
      dotsDecorator: DotsDecorator(
        color: Colors.grey,
        activeSize: const Size(22.0, 10.0),
        activeColor: AppColors.primaryLight,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}
