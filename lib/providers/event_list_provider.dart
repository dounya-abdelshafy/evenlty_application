import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import '../firebase_utils.dart';
import '../l10n/app_localizations.dart';
import '../model/events.dart';

class EventListProvider extends ChangeNotifier {
  //todo: data
  List<Event> eventsList = [];
  List<Event> filterEventList = [];
  List<String> eventNameList = [];
  List<Event> favouriteEventList = [];

  int selectedIndex = 0;

  List<String> getEventNameList(BuildContext context) {
    return eventNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.work_shop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
  }

  //todo: function  =>  get all events
  void getAllEvents(String uId) async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventsCollection(uId).get();
    //List<Event>         List<QueryDocumentSnapshot<Event>>
    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    filterEventList = eventsList;
    //todo: sorting events
    filterEventList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();
  }

  void getFilterEvents(String uId) async {
    //todo: get events

    //todo: 1- get collection
    //QuerySnapshot<Event> querySnapshot = await FirebaseUtils.getEventsCollection().get();   -> The same as the following
    var querySnapshot = await FirebaseUtils.getEventsCollection(uId).get();

    /// Has an error because of the different types of lists
    /// as 'where' return type is 'Iterable<Event>'
    /// (we change Iterable<Event> to List<Event> with .toList())
    /// and the type of 'filterEventList' is List<Event>
    /// so we first map it 'mean we convert the type of Iterable<Event> to List<Event>'
    /// then assign 'filterEventList' to 'where'

    // filterEventList = querySnapshot.docs.where((event) {
    //   return event.data().eventName == eventNameList[selectedIndex];
    // },).toList();

    //todo: 2- convert data
    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    //todo: 3- filter data
    filterEventList = eventsList.where((event) {
      return event.eventName == eventNameList[selectedIndex];
    }).toList();

    //todo: sorting events
    filterEventList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();

    /// if(event.data().eventName == eventNameList[selectedIndex]) {
    ///   return true;
    /// } else {
    ///   return false;
    /// }
    /// The same as  ->  return event.data().eventName == eventNameList[selectedIndex];
  }

  void getFilterEventsFromFireStore(String uId) async {
    //todo: 1- get collection
    //todo: 2- filter data
    //todo: 3- get data

    var querySnapshot = await FirebaseUtils.getEventsCollection(uId)
        .orderBy('dateTime')
        .where('eventName', isEqualTo: eventNameList[selectedIndex])
        .get();
    filterEventList = querySnapshot.docs.map((docs) {
      return docs.data();
    }).toList();
    notifyListeners();
  }

  void getAllFavouriteEvents(String uId) async {
    var querySnapshot = await FirebaseUtils.getEventsCollection(uId).get();
    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    favouriteEventList = eventsList.where((event) {
      return event.isFavorite == true;
    }).toList();

    /// sorting favourite events
    favouriteEventList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();
  }

  void updateIsFavourite(Event event, String uId) {
    FirebaseUtils.getEventsCollection(uId)
        .doc(event.id)
        .update({'isFavorite': !event.isFavorite})
        .then((value) {
          ToastUtils.toastMsg(
            msg: 'Event Updated Successfully.',
            backgroundColor: Colors.green.shade900,
            textColor: AppColors.whiteColor,
          );
          //todo: get all events , filter events
          selectedIndex == 0 ? getAllEvents(uId) : getFilterEvents(uId);
          //todo: get all favourite events
          getAllFavouriteEvents(uId);
          // getAllFavouriteEventsFromFireStore();
        })
        .timeout(
          Duration(milliseconds: 500),
          onTimeout: () {
            ToastUtils.toastMsg(
              msg: 'Event Updated Successfully.',
              backgroundColor: Colors.green.shade900,
              textColor: AppColors.whiteColor,
            );
            //todo: get all events , filter events
            selectedIndex == 0 ? getAllEvents(uId) : getFilterEvents(uId);
            //todo: get all favourite events
            getAllFavouriteEvents(uId);
            // getAllFavouriteEventsFromFireStore();
            notifyListeners();
          },
        );
  }

  void getAllFavouriteEventsFromFireStore(String uId) async {
    var querySnapshot = await FirebaseUtils.getEventsCollection(
      uId,
    ).orderBy('dateTime').where('isFavorite', isEqualTo: true).get();
    favouriteEventList = querySnapshot.docs.map((event) {
      return event.data();
    }).toList();
    notifyListeners();
  }

  void changeSelectedIndex(int newSelectedIndex, String uId) {
    selectedIndex = newSelectedIndex;
    selectedIndex == 0 ? getAllEvents(uId) : getFilterEvents(uId);
    // selectedIndex == 0 ? getAllEvents() : getFilterEventsFromFireStore(); //todo: The same result as the top one
  }
}
