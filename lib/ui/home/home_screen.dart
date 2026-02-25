import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/home/taps/favorite/favorite_tap.dart';
import 'package:evently_app/ui/home/taps/home/home_tap.dart';
import 'package:evently_app/ui/home/taps/map/map_tap.dart';
import 'package:evently_app/ui/home/taps/profile/profile_tap.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> taps = [
    HomeTap(),
    MapTap(),
    FavoriteTap(),
    ProfileTap(),
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: [
            builtBottomNavigationBarItem(
              unSelectedIconName: AppAssets.homeIcon,
              selectedIconName: AppAssets.homeIconSelected,
              label: AppLocalizations.of(context)!.home,
              index: 0,
            ),
            builtBottomNavigationBarItem(
              unSelectedIconName: AppAssets.mapIcon,
              selectedIconName: AppAssets.mapIconSelected,
              label: AppLocalizations.of(context)!.map,
              index: 1,
            ),
            builtBottomNavigationBarItem(
              unSelectedIconName: AppAssets.favoriteIcon,
              selectedIconName: AppAssets.favoriteIconSelected,
              label: AppLocalizations.of(context)!.favorite,
              index: 2,
            ),
            builtBottomNavigationBarItem(
              unSelectedIconName: AppAssets.profileIcon,
              selectedIconName: AppAssets.profileIconSelected,
              label: AppLocalizations.of(context)!.profile,
              index: 3,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //todo: navigate to create event screen
          Navigator.of(context).pushNamed(AppRoutes.addEventRouteName);
        },
        child: Icon(Icons.add, size: 40, color: AppColors.whiteColor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: taps[selectedIndex],
    );
  }

  BottomNavigationBarItem builtBottomNavigationBarItem({
    required String selectedIconName,
    required String unSelectedIconName,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(
          selectedIndex == index ? selectedIconName : unSelectedIconName,
        ),
      ),
      label: label,
    );
  }
}
