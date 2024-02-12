import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/financials/financials_service.dart';
import 'package:luround/utils/colors/app_theme.dart';






class PaymentMethodForInvoice extends StatefulWidget {
  @override
  _PaymentMethodForInvoiceState createState() => _PaymentMethodForInvoiceState();
}

class _PaymentMethodForInvoiceState extends State<PaymentMethodForInvoice> {

  
  var service = Get.put(FinancialsService());

  // Sample list of users, each represented as a map
  /*List<Map<String, dynamic>> users = [
    {'name': 'User 1', 'job': 'Developer'},
    {'name': 'User 2', 'job': 'Designer'},
    {'name': 'User 3', 'job': 'Manager'},
    {'name': 'User 4', 'job': 'Tester'},
  ];*/



  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return service.filteredSavedAccounts.isNotEmpty ? ListView.builder(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: service.filteredSavedAccounts.length,
          itemBuilder: (context, index) {

            final item = service.filteredSavedAccounts[index];

            //wrap with Obx
            return RadioListTile<String>(
              enableFeedback: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              activeColor: AppColor.blackColor,
              title: Text(
                item.account_name,
                style: GoogleFonts.inter(
                  color: AppColor.blackColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
              subtitle: Text(
                "${item.bank_name} | ${item.account_number}",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400
                ),
              ),
              value: item.account_name,
              groupValue: service.selectedAccName.value,
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (value) {
                setState(() {
                  service.selectedAccName.value = value!;
                  service.selectedAccNumber.value = service.filteredSavedAccounts.firstWhere((bank) => bank.account_number == value).account_number;
                });
                print("${service.selectedAccName.value} - ${service.selectedAccNumber.value}");
              },
              secondary: SvgPicture.asset("assets/svg/bank.svg"),
            );
          },
        ) : Text(
          "You haven't uploaded you bank details",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        );
      }
    );
  }
}