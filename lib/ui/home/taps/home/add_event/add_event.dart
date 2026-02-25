import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/model/events.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/ui/home/taps/widgets/date_or_time_widget.dart';
import 'package:evently_app/ui/home/taps/home/add_event/event_tap_item.dart';
import 'package:evently_app/ui/home/taps/widgets/custom_elevated_button.dart';
import 'package:evently_app/ui/home/taps/widgets/custom_text_form_field.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int selectedIndex = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String formatedDate = '';
  String formatedTime = '';
  var formKey = GlobalKey<FormState>();
  String selectedImage = '';
  String selectedEventName = '';
  late EventListProvider eventListProvider;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    eventListProvider = Provider.of<EventListProvider>(context);

    List<String> eventNameList = [
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

    List<String> eventImagesList = [
      AppAssets.sportImage,
      AppAssets.birthday,
      AppAssets.meetingImage,
      AppAssets.gamingImage,
      AppAssets.workshopImage,
      AppAssets.bookClubImage,
      AppAssets.exhibitionImage,
      AppAssets.holidayImage,
      AppAssets.eatingImage,
    ];
    selectedImage = eventImagesList[selectedIndex];
    selectedEventName = eventNameList[selectedIndex];
    // Map<String, String> eventsMapList = {
    //   AppLocalizations.of(context)!.sport: AppAssets.sportImage,
    //   AppLocalizations.of(context)!.birthday: AppAssets.birthday,
    //   AppLocalizations.of(context)!.meeting: AppAssets.meetingImage,
    //   AppLocalizations.of(context)!.gaming: AppAssets.gamingImage,
    //   AppLocalizations.of(context)!.work_shop: AppAssets.workshopImage,
    //   AppLocalizations.of(context)!.book_club: AppAssets.bookClubImage,
    //   AppLocalizations.of(context)!.exhibition: AppAssets.exhibitionImage,
    //   AppLocalizations.of(context)!.holiday: AppAssets.holidayImage,
    //   AppLocalizations.of(context)!.eating: AppAssets.eatingImage,
    // };

    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.transparentColor,
          iconTheme: IconThemeData(color: AppColors.primaryLight),
          title: Text(
            AppLocalizations.of(context)!.create_event,
            style: AppStyles.medium20Primary,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.02,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(16),
                  child: Image.asset(eventImagesList[selectedIndex]),
                ),
                // Container(
                //   clipBehavior: Clip.antiAlias,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadiusGeometry.circular(16)
                //   ),
                //   child: Image.asset(AppAssets.birthday),
                // ),
                SizedBox(height: height * 0.02),
                SizedBox(
                  height: height * 0.035,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          selectedIndex = index;
                          eventNameList[index] = eventImagesList[index];
                          setState(() {});
                        },
                        child: EventTapItem(
                          selectedTextStyle: Theme.of(
                            context,
                          ).textTheme.headlineSmall!,
                          unselectedTextStyle: Theme.of(
                            context,
                          ).textTheme.headlineMedium!,
                          selectedBgColor: AppColors.primaryLight,
                          borderColor: AppColors.primaryLight,
                          eventName: eventNameList[index],
                          isSelected: selectedIndex == index,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: width * 0.01);
                    },
                    itemCount: eventNameList.length,
                  ),
                ),
                SizedBox(height: height * 0.015),
                Text(
                  AppLocalizations.of(context)!.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: height * 0.01),
                CustomTextFormField(
                  controller: titleController,
                  colorBorderSide: themeProvider.isDarkMode()
                      ? AppColors.primaryLight
                      : AppColors.greyColor,
                  prefixIcon: Image.asset(
                    AppAssets.iconEdit,
                    color: themeProvider.isDarkMode()
                        ? AppColors.whiteColor
                        : AppColors.greyColor,
                  ),
                  hintText: AppLocalizations.of(context)!.event_title,
                  hintStyle: themeProvider.isDarkMode()
                      ? AppStyles.medium16White
                      : AppStyles.medium16Grey,
                ),
                SizedBox(height: height * 0.01),
                Text(
                  AppLocalizations.of(context)!.description,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: height * 0.01),
                CustomTextFormField(
                  controller: descriptionController,
                  colorBorderSide: themeProvider.isDarkMode()
                      ? AppColors.primaryLight
                      : AppColors.greyColor,
                  hintText: AppLocalizations.of(context)!.event_description,
                  hintStyle: themeProvider.isDarkMode()
                      ? AppStyles.medium16White
                      : AppStyles.medium16Grey,
                  maxLines: 4,
                ),
                SizedBox(height: height * 0.02),
                DateOrTimeWidget(
                  iconDateOrTimeName: AppAssets.iconDate,
                  iconColor: Theme.of(context).dividerColor,
                  textEventDateOrTime: AppLocalizations.of(context)!.event_date,
                  textButtonChooseDateOrTime: selectedDate == null
                      ? AppLocalizations.of(context)!.choose_date
                      : formatedDate,
                  // DateFormat('dd/MM/yyyy').format(selectedDate!),
                  // '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                  onChooseDateOrTimeClicked: chooseDate,
                ),
                DateOrTimeWidget(
                  iconDateOrTimeName: AppAssets.iconTime,
                  iconColor: Theme.of(context).dividerColor,
                  textEventDateOrTime: AppLocalizations.of(context)!.event_time,
                  textButtonChooseDateOrTime: selectedTime == null
                      ? AppLocalizations.of(context)!.choose_time
                      : formatedTime,
                  onChooseDateOrTimeClicked: chooseTime,
                ),
                SizedBox(height: height * 0.004),
                Text(
                  AppLocalizations.of(context)!.location,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03,
                    vertical: height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: BoxBorder.all(
                      color: AppColors.primaryLight,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.primaryLight,
                        ),
                        height: height * 0.05,
                        child: Image.asset(
                          AppAssets.iconLocation,
                          color: themeProvider.isDarkMode()
                              ? AppColors.blackColor
                              : AppColors.whiteColor,
                        ),
                      ),
                      SizedBox(width: width * 0.04),
                      Text(
                        AppLocalizations.of(context)!.choose_event_location,
                        style: AppStyles.medium16Primary,
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.primaryLight,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                CustomElevatedButton(
                  onPressed: addEvent,
                  text: AppLocalizations.of(context)!.add_event,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addEvent() {
    if (formKey.currentState?.validate() == true) {
      //todo: add event to db
      Event event = Event(
        dateTime: selectedDate!,
        title: titleController.text,
        eventName: selectedEventName,
        description: descriptionController.text,
        image: selectedImage,
        time: formatedTime,
      );
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      FirebaseUtils.addEventToFireStore(event, userProvider.currentUser!.id)
          .then((value) {
            //todo: alert dialog , toast , snack bar
            ToastUtils.toastMsg(
              msg: 'Event Added Successfully',
              backgroundColor: AppColors.primaryLight,
              textColor: AppColors.whiteColor,
            );
            // => todo: refresh events in home tap after add new event  =>  get all events from fireS tore
            eventListProvider.getAllEvents(userProvider.currentUser!.id);
            Navigator.pop(context);
          })
          .timeout(
            Duration(milliseconds: 500),
            onTimeout: () {
              //todo: alert dialog , toast , snack bar
              ToastUtils.toastMsg(
                msg: 'Event Added Successfully',
                backgroundColor: AppColors.primaryLight,
                textColor: AppColors.whiteColor,
              );
              // => todo: refresh events in home tap after add new event  =>  get all events from fireS tore
              eventListProvider.getAllEvents(userProvider.currentUser!.id);
              Navigator.pop(context);
            },
          );
    }
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    selectedDate = chooseDate;
    if (selectedDate != null) {
      formatedDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
      setState(() {});
    }
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime = chooseTime;
    if (selectedTime != null) {
      formatedTime = selectedTime!.format(context);
      setState(() {});
    }
  }
}
