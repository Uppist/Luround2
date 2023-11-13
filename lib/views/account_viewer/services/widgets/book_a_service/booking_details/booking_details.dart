import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/booking_details/custom_text_row.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/payment_folder/payment_screen.dart';







class BookingDetails extends StatelessWidget {
  BookingDetails({super.key});

  var controller = Get.put(AccViewerServicesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.bgColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColor.blackColor,
          )
        ),
        title: CustomAppBarTitle(text: 'Back',),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.h),
              Container(
                color: AppColor.greyColor,
                width: double.infinity,
                height: 7.h,
              ),
              SizedBox(height: 20.h,),
              //important section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //SizedBox(height: 10,),
                    Center(
                      child: Text(
                        "Booking Details",
                        style: GoogleFonts.inter(
                          color: AppColor.blackColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    //listview.builder
                    ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      itemCount: 10,
                      separatorBuilder: (context, index) => Divider(color: AppColor.textGreyColor, thickness: 0.2), 
                      itemBuilder: (context, index) {
                        return CustomTextRow(
                          leftText: "name",
                          rightText: "Japhet Alvin",
                        );
                      },
                    ),
                    SizedBox(height: 20.h,),
                    Text(
                      "Message",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Text(
                      "gzfgxdfgdffhfghfghfgggggggggggggggggggggggggggggggggsfssssssssssssssssssssssssssssss",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 14.sp,
                        //fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 70.h,),
                    RebrandedReusableButton(
                      textColor: AppColor.bgColor,
                      color: AppColor.mainColor,
                      text: "Proceed to pay", 
                      onPressed: () {
                        //amount of service as argument
                        Get.to(() => PaymentScreen(
                          amount: 25000,
                        ));
                        print('nothing');
                      },
                    ),
                    SizedBox(height: 10.h,),
                  ]
                )
              )
            ]
          )
        )
      )
    );
  }
}