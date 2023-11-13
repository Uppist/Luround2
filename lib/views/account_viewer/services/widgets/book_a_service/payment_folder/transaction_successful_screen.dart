import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_viewer/mainpage/screen/mainpage._acc_viewer.dart';
import 'package:luround/views/account_viewer/services/widgets/sign_me_up/sign_up_bottomsheet.dart';
import 'package:lottie/lottie.dart';










class TransactionSuccesscreen extends StatefulWidget {
  TransactionSuccesscreen({super.key,});

  @override
  State<TransactionSuccesscreen> createState() => _TransactionSuccesscreenState();
}

class _TransactionSuccesscreenState extends State<TransactionSuccesscreen> {

  var controller = Get.put(AccViewerServicesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30.h),
              Container(
                color: AppColor.greyColor,
                width: double.infinity,
                height: 7.h,
              ),
              //SizedBox(height: 20,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100.h,),
                    //
                    Lottie.asset("assets/lottie/my_g.json"),
                    SizedBox(height: 50.h,),
                    Text(
                      "Transaction Successful",
                      style: GoogleFonts.inter(
                        color: AppColor.darkGreyColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text :'    You have successfully booked',
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColor.darkGreyColor
                              )
                            ),
                            TextSpan(
                              text :' "Ronald Richie"          \n',
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.darkGreyColor
                              )
                            ),
                            TextSpan(
                              text :'                 for a',
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColor.darkGreyColor
                              )
                            ),
                            TextSpan(
                              text :' "Personal Training Session".',
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.darkGreyColor
                              )
                            ),
                          ]
                        )
                      ),
                    ),
                    SizedBox(height: 60.h,),
                    //okay button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.w),
                      child: RebrandedReusableButton(
                        textColor: AppColor.bgColor,
                        color: AppColor.mainColor, 
                        text: "Okay", 
                        onPressed: () {
                          signMeUpBottomSheet(context: context);
                          //.then((value) => Get.offAll(() => MainPageAccViewer()));
                          //Get.offAll(() => MainPageAccViewer());
                        }
                      ),
                    ),
                  ],
                ),
              ),
    
            ]
          )
        )
      )
    );
  }
}