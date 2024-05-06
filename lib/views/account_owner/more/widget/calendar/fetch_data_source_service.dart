import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:luround/models/account_owner/user_bookings/user_bookings_response_model.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/converters.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/views/account_owner/more/widget/calendar/appointment_details.dart';
import 'package:luround/views/account_owner/more/widget/calendar/meeting_model.dart';
import 'package:get/get.dart' as getx;







class CalendarService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  final isLoading = false.obs;
  
  //list of booking to be displayed on the calendar
  final List<Meeting> appointmentData = [];


  //colors list
  final List<Color> _colorCollection = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.indigo,
    Colors.pink,
  ];

  //fetch data from bookings api
  Future<List<Meeting>> getDataFromWeb() async {
    try {

      isLoading.value = true;
      http.Response res = await baseService.httpGet(endPoint: "booking/my-bookings");

      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user bookings fetched successfully!!");

        List<dynamic> jsonData = json.decode(res.body);
        
        // Extract the "details" list from the first map
        List<dynamic> result = jsonData[0]['details'];
        List<dynamic> result2 = jsonData[1]['details'];

        result.addAll(result2);

        print("new_arr[0]: $result");

        var finalResult = result.map((e) => DetailsModel.fromJson(e)).toList();
        finalResult.sort((a, b) => a.bookingUserInfo.displayName.toString().toLowerCase().compareTo(b.bookingUserInfo.displayName.toString().toLowerCase()));
        final Random random = Random();
        
        for (var data in finalResult) {
          Meeting meetingData = Meeting(
            eventName: data.serviceDetails.serviceName, //data.bookingUserInfo.displayName,
            clientName: data.bookingUserInfo.displayName,
            time: data.serviceDetails.time,
            date: data.serviceDetails.date,

            from: //DateTime(2024, 5, 6, 09, 30, 0),
            parseDateTime(
              dateString: data.serviceDetails.date, 
              timeString: '10:00 AM'  //data.serviceDetails.time
            ),

            to: //DateTime(2024, 5, 6, 10, 30, 0),
            parseDateTime(
              dateString: data.serviceDetails.date, 
              timeString: '12:00 PM'  //data.serviceDetails.time
            ),

            background: _colorCollection[random.nextInt(6)],
            isAllDay: false, //true
          );
          appointmentData.clear();
          appointmentData.add(meetingData);
        }
        debugPrint("appointment list: $appointmentData");
        return appointmentData;

      } 
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response body ==> ${res.body}');
        throw Exception('Failed to load calendar bookings');
      }
    }   
    catch (e) {
      isLoading.value = false;
      throw Exception("$e");
    }
  }
  


  ///////USEFUL TO ADD EVENTS TO THE CALENDAR////
  //getter for fetching the list of appointments
  List<Meeting> get eventsGetter => appointmentData;

  //selected date
  DateTime selectedDate = DateTime.now();

  //getter for selected date
  DateTime get selectedDateGetter => selectedDate;

  //set the selected datedate
  void setDate(DateTime date) => selectedDate = date;

  //events of selected date
  List<Meeting> get eventsOfSelectedDate => appointmentData;

  //function to add event to the calendar
  void addEvent({required BuildContext context, required Meeting event}){
    if(!eventsGetter.contains(event)) {
      eventsGetter.add(event);
    }
    else{
      showMySnackBar(
        context: context, 
        message: "event has already been added", 
        backgroundColor: AppColor.redColor
      );
    }
  }



  ///Alert Dialog
  Future<void> showAppointmentDetailBottomsheet({required BuildContext context,}) async{
    showModalBottomSheet(
      isScrollControlled: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 2,
      isDismissible: true,
      useSafeArea: true,
      backgroundColor: AppColor.bgColor,
      //barrierColor: Theme.of(context).colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.r)
        )
      ),
      context: context,
      builder: (context) {
        return AppointmentDetailsPage();
      }
    );
  }





  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    
    super.dispose();
  }

}


