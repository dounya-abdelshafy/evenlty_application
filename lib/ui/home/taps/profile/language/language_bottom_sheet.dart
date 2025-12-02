import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() =>
      _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.03,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              //todo: change language to english
              languageProvider.changeLanguage('en');
            },
            child: languageProvider.appLanguage == 'en'
                ? getSelectedLanguageItem(
                    textLanguage: AppLocalizations.of(context)!.english,
                  )
                : getUnSelectedLanguageItem(
                    textLanguage: AppLocalizations.of(context)!.english,
                  ),
          ),
          SizedBox(height: height * 0.02),
          InkWell(
            onTap: () {
              //todo: change language to arabic
              languageProvider.changeLanguage('ar');
            },
            child: languageProvider.appLanguage == 'ar'
                ? getSelectedLanguageItem(
                    textLanguage: AppLocalizations.of(context)!.arabic,
                  )
                : getUnSelectedLanguageItem(
                    textLanguage: AppLocalizations.of(context)!.arabic,
                  ),
          ),
        ],
      ),
    );
  }

  Widget getSelectedLanguageItem({required String textLanguage}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(textLanguage, style: AppStyles.bold20Primary),
        Icon(Icons.check, size: 35, color: AppColors.primaryLight),
      ],
    );
  }

  Widget getUnSelectedLanguageItem({required String textLanguage}) {
    return Text(textLanguage, style: AppStyles.bold20Black);
  }
}
