import 'package:album_project/manager/color_manager.dart';
import 'package:album_project/manager/font_manager.dart';
import 'package:album_project/manager/space_manger.dart';
import 'package:album_project/manager/url_manager.dart';
import 'package:album_project/utils/get_dimension.dart';
import 'package:album_project/widgets/dropdown_field.dart';
import 'package:album_project/widgets/long_button.dart';
import 'package:album_project/widgets/simple_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelectorScreen extends StatefulWidget {
  const DateSelectorScreen({super.key});

  @override
  State<DateSelectorScreen> createState() => _DateSelectorScreenState();
}

class _DateSelectorScreenState extends State<DateSelectorScreen> {
  final DateTime now = DateTime.now();

  DateTime? selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String? morningSelection;
  String? afternoonSelection;
  String? collectionMainSelectedDate;
  String? deliveryMainSelectedDate;
  int? collectionMainSelectedDateIndex = 0;
  int? deliveryMainSelectedDateIndex = 0;

  @override
  Widget build(BuildContext context) {
    final today = DateTime(now.year, now.month, now.day);

    final formatter = DateFormat('d MMM');

    final todayFormatted = formatter.format(today);
    final tomorrowFormatted =
        formatter.format(today.add(const Duration(days: 1)));
    final selectDateFormatted = selectedDate != null
        ? formatter.format(selectedDate!)
        : tomorrowFormatted;
    collectionMainSelectedDate = todayFormatted;
    deliveryMainSelectedDate = todayFormatted;
    return SimpleScaffold(
      floatingButton: false,
      title: 'Select Date',
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        children: [
          Text(
            'Select Collection Date & Time',
            style: appFont.f12w600Black,
          ),
          appSpaces.spaceForHeight15,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) {
              List<String> titles = ['Today', 'Tomorrow', 'Select Date'];
              List<String> dates = [
                todayFormatted,
                tomorrowFormatted,
                selectDateFormatted,
              ];
              return InkWell(
                onTap: () {
                  setState(() {
                    collectionMainSelectedDate = dates[index];
                    collectionMainSelectedDateIndex = index;
                  });
                  if (index == 2) {
                    _selectDate(context);
                  }
                },
                child: Container(
                  height: screenHeight(context) * 0.08,
                  width: screenWidth(context) * 0.29,
                  decoration: BoxDecoration(
                      border: Border.all(color: appColors.appGrey!),
                      color: collectionMainSelectedDateIndex == index
                          ? null
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      gradient: collectionMainSelectedDateIndex == index
                          ? const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xff90CAF2),
                                Color(0xff1976D2),
                                Color(0xff1976D2)
                              ],
                            )
                          : null),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          titles[index],
                          style: collectionMainSelectedDateIndex == index
                              ? appFont.f12w500White
                              : appFont.f12w500Grey,
                        ),
                        Text(
                          dates[index],
                          style: collectionMainSelectedDateIndex == index
                              ? appFont.f12w600White
                              : appFont.f12w600Black,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          appSpaces.spaceForHeight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: screenWidth(context) * 0.45,
                child: CustomDropdownFormField(
                    onChanged: (value) {
                      morningSelection = value!;
                    },
                    validator: (service) {
                      if (service.toString() == "") {
                        return "Please Enter Service Type";
                      }
                      return null;
                    },
                    title: 'Morning',
                    items: morningList,
                    labelText: 'Select time',
                    hint: 'Select time'),
              ),
              SizedBox(
                width: screenWidth(context) * 0.45,
                child: CustomDropdownFormField(
                    onChanged: (value) {
                      afternoonSelection = value!;
                    },
                    validator: (service) {
                      if (service.toString() == "") {
                        return "Please Enter Service Type";
                      }
                      return null;
                    },
                    title: 'Afternoon',
                    items: afternoonList,
                    labelText: 'Select time',
                    hint: 'Select time'),
              ),
            ],
          ),
          SizedBox(
            height: screenHeight(context) * 0.05,
          ),
          Text(
            'Select Delivery Date & Time',
            style: appFont.f12w600Black,
          ),
          appSpaces.spaceForHeight15,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) {
              List<String> titles = ['Today', 'Tomorrow', 'Select Date'];
              List<String> deliveryDates = [
                todayFormatted,
                tomorrowFormatted,
                selectDateFormatted,
              ];
              return InkWell(
                onTap: () {
                  setState(() {
                    deliveryMainSelectedDate = deliveryDates[index];
                    deliveryMainSelectedDateIndex = index;
                  });
                  if (index == 2) {
                    _selectDate(context);
                  }
                },
                child: Container(
                  height: screenHeight(context) * 0.08,
                  width: screenWidth(context) * 0.29,
                  decoration: BoxDecoration(
                      border: Border.all(color: appColors.appGrey!),
                      color: deliveryMainSelectedDateIndex == index
                          ? null
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      gradient: deliveryMainSelectedDateIndex == index
                          ? const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xff90CAF2),
                                Color(0xff1976D2),
                                Color(0xff1976D2)
                              ],
                            )
                          : null),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          titles[index],
                          style: deliveryMainSelectedDateIndex == index
                              ? appFont.f12w500White
                              : appFont.f12w500Grey,
                        ),
                        Text(
                          deliveryDates[index],
                          style: deliveryMainSelectedDateIndex == index
                              ? appFont.f12w600White
                              : appFont.f12w600Black,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          appSpaces.spaceForHeight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: screenWidth(context) * 0.45,
                child: CustomDropdownFormField(
                    onChanged: (value) {
                      morningSelection = value!;
                    },
                    validator: (service) {
                      if (service.toString() == "") {
                        return "Please Enter Service Type";
                      }
                      return null;
                    },
                    title: 'Morning',
                    items: morningList,
                    labelText: 'Select time',
                    hint: 'Select time'),
              ),
              SizedBox(
                width: screenWidth(context) * 0.45,
                child: CustomDropdownFormField(
                    onChanged: (value) {
                      afternoonSelection = value!;
                    },
                    validator: (service) {
                      if (service.toString() == "") {
                        return "Please Enter Service Type";
                      }
                      return null;
                    },
                    title: 'Afternoon',
                    items: afternoonList,
                    labelText: 'Select time',
                    hint: 'Select time'),
              ),
            ],
          ),
          appSpaces.spaceForHeight20,
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.blue[50]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                'Note: A delivery charge of \$300 will be included for a full service',
                style: appFont.f12w500Grey,
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
      bottomWidget: SizedBox(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: LongButton(
              buttonWidth: double.infinity, onTap: () {}, title: 'Continue'),
        ),
      ),
    );
  }
}
