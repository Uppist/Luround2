
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




Future<void> displayiOSTimepicker({
  required BuildContext context, 
  //required int index,
  required RxString selectedTime,
  }) async{
    var time = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false), 
          child: child!
        );
      },
    );

    if (time != null) {
      
      //print({'${time.hour}:${time.minute} ${time.period.name}'});
      time.format(context);
      selectedTime.value = time.format(context);  //'${time.hour}:${time.minute} ${time.period.name.toUpperCase()}';
      log(selectedTime.value);

    }
  }