import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/ui/home/taps/widgets/custom_text_form_field.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/user_provider.dart';
import '../home/add_event/event_item.dart';

class FavoriteTap extends StatefulWidget {
  const FavoriteTap({super.key});

  @override
  State<FavoriteTap> createState() => _FavoriteTapState();
}

class _FavoriteTapState extends State<FavoriteTap> {
  TextEditingController searchController = TextEditingController();
  late EventListProvider eventListProvider;
  late UserProvider userProvider;

  @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     eventListProvider.getAllFavouriteEvents(userProvider.currentUser!.id);
  //     // eventListProvider.getAllFavouriteEventsFromFireStore();
  //   });
  //   // eventListProvider.getAllFavouriteEvents();
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    eventListProvider = Provider.of<EventListProvider>(context);
    userProvider = Provider.of<UserProvider>(context);

    if (eventListProvider.favouriteEventList.isEmpty) {
      eventListProvider.getAllFavouriteEvents(userProvider.currentUser!.id);
    }


    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: height * 0.02),
            CustomTextFormField(
              colorBorderSide: AppColors.primaryLight,
              hintText: AppLocalizations.of(context)!.search_event,
              hintStyle: AppStyles.bold14Primary,
              prefixIcon: Image.asset(AppAssets.iconSearch),
              controller: searchController,
            ),
            Expanded(
              child: eventListProvider.favouriteEventList.isEmpty
                  ? Center(
                      child: Text(
                        AppLocalizations.of(context)!.no_favourite_events_found,
                        style: AppStyles.bold20Primary,
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.only(top: height * 0.02),
                      itemBuilder: (context, index) {
                        return EventItem(
                          event: eventListProvider.favouriteEventList[index],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: height * 0.01),
                      itemCount: eventListProvider.favouriteEventList.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
