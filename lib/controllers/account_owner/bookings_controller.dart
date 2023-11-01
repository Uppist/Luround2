import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;










class BookingsController extends getx.GetxController {
  
  final TextEditingController searchController = TextEditingController();
  final isFieldTapped = false.obs;
  final isExpanded = false.obs;
  int selectedIndex = -1;

  var dates = <DateTime?>[].obs;

  void selectedDate(List<DateTime?> dateList) {
    if (dateList.isNotEmpty) {
      // Remove any previous items, if any
      dates.clear();

      // Add the new unique item
      dates.add(dateList[0]);
    }
  }

  //to select time frame for a service to be rendered (all are to be saved to db)
  //var startTime = 'from'.obs;
  //var endTime = 'to'.obs;

  var startMinute = ''.obs;
  var endMinute = ''.obs;

  var startMeridian = "".obs;
  var endMeridian = "".obs;
  ///////////////////////////////////

  String updatedDate ({required String initialDate}) {
    if(dates.isNotEmpty) {
      var result = dates[0].toString();
      var refinedList = result.substring(0, 10);
      print(refinedList);
      return refinedList;
    }
    return initialDate;
  }








  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

}