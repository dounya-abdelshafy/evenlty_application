import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/ui/home/taps/home/add_event/event_item.dart';
import 'package:evently_app/ui/home/taps/home/add_event/event_tap_item.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/app_language_provider.dart';
import '../../../../providers/app_theme_provider.dart';
import '../../../../providers/user_provider.dart';

class HomeTap extends StatefulWidget {
  const HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    eventListProvider.getEventNameList(context); // => Localization
    if (eventListProvider.eventsList.isEmpty) {
      eventListProvider.getAllEvents(userProvider.currentUser!.id);
    }
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcome_back,
                  style: AppStyles.medium14White,
                ),
                Text(userProvider.currentUser!.name, style: AppStyles.bold24White),
              ],
            ),
            Spacer(),
            ImageIcon(
              AssetImage(AppAssets.themeIcon),
              color: AppColors.whiteColor,
              size: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: width * 0.02),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadiusGeometry.circular(8),
              ),
              child: Text('EN', style: AppStyles.bold14Primary,),
            ),
          ],
        ),
        bottom: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          toolbarHeight: height * 0.1,
          title: Column(
            children: [
              Row(
                children: [
                  Image.asset(AppAssets.mapIcon),
                  SizedBox(width: width * 0.01),
                  Text('Cairo , Egypt', style: AppStyles.bold14White),
                ],
              ),
              SizedBox(height: height * 0.02),
              DefaultTabController(
                length: eventListProvider.eventNameList.length,
                child: TabBar(
                  tabAlignment: TabAlignment.start,
                  dividerColor: AppColors.transparentColor,
                  labelPadding: EdgeInsets.zero,
                  isScrollable: true,
                  indicatorColor: AppColors.transparentColor,
                  onTap: (index) {
                    eventListProvider.changeSelectedIndex(index , userProvider.currentUser!.id);
                  },
                  tabs: eventListProvider.eventNameList.map((eventName) {
                    return EventTapItem(
                      selectedTextStyle: Theme.of(
                        context,
                      ).textTheme.headlineMedium!,
                      unselectedTextStyle: Theme.of(
                        context,
                      ).textTheme.headlineSmall!,
                      selectedBgColor: Theme.of(context).focusColor,
                      eventName: eventName,
                      isSelected:
                          eventListProvider.selectedIndex ==
                          eventListProvider.eventNameList.indexOf(eventName),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: eventListProvider.filterEventList.isEmpty
                ? Center(
                    child: Text(
                      AppLocalizations.of(context)!.no_events_found_yet,
                      style: AppStyles.bold20Primary,
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.only(top: height * 0.02),
                    itemBuilder: (context, index) {
                      return EventItem(
                        event: eventListProvider.filterEventList[index],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: height * 0.01),
                    itemCount: eventListProvider.filterEventList.length,
                  ),
          ),
        ],
      ),
    );
  }
}
