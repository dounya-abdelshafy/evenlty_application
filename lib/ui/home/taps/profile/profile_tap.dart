import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/ui/home/taps/profile/language/language_bottom_sheet.dart';
import 'package:evently_app/ui/home/taps/profile/theme/theme_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/app_language_provider.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';

class ProfileTap extends StatefulWidget {
  const ProfileTap({super.key});

  @override
  State<ProfileTap> createState() => _ProfileTapState();
}

//new command

class _ProfileTapState extends State<ProfileTap> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        toolbarHeight: height * 0.18,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.only(
            bottomLeft: Radius.circular(55),
          ),
        ),
        title: Row(
          children: [
            Image.asset(AppAssets.routeImage),
            SizedBox(width: width * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Route Academy', style: AppStyles.bold24White),
                Text('routeacademy@gmail.com', style: AppStyles.medium16White),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            InkWell(
              onTap: () {
                showLanguageBottomSheet();
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: height * 0.02),
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.01,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: BoxBorder.all(
                    color: AppColors.primaryLight,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      languageProvider.appLanguage == 'en'
                          ? AppLocalizations.of(context)!.english
                          : AppLocalizations.of(context)!.arabic,
                      style: AppStyles.bold20Primary,
                    ),
                    Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 35,
                      color: AppColors.primaryLight,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: height * 0.03),

            Text(
              AppLocalizations.of(context)!.theme,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            InkWell(
              onTap: () {
                showThemeBottomSheet();
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: height * 0.02),
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.01,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: BoxBorder.all(
                    color: AppColors.primaryLight,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      themeProvider.isDarkMode()
                          ? AppLocalizations.of(context)!.dark
                          : AppLocalizations.of(context)!.light,
                      style: AppStyles.bold20Primary,
                    ),
                    Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 35,
                      color: AppColors.primaryLight,
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redColor,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.02,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(16),
                ),
              ),

              child: Row(
                children: [
                  Icon(
                    Icons.logout_outlined,
                    size: 30,
                    color: AppColors.whiteColor,
                  ),
                  SizedBox(width: width * 0.02),
                  Text(
                    AppLocalizations.of(context)!.logout,
                    style: AppStyles.regular20White,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
    );
  }
}
