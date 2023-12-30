import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/more/transactions_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/accounts_tab/screen/select_account_screen.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/select_country/country_field_flipper.dart';
import 'package:country_picker/country_picker.dart';








class SelectCountryPage extends StatefulWidget {
  SelectCountryPage({super.key, required this.wallet_balance});
  final int wallet_balance;

  @override
  State<SelectCountryPage> createState() => _SelectCountryPageState();
}

class _SelectCountryPageState extends State<SelectCountryPage> {
  var controller = Get.put(TransactionsController());

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
        title: CustomAppBarTitle(text: 'Withdraw',),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.h),
          Container(
            color: AppColor.greyColor,
            width: double.infinity,
            height: 7.h,
          ),
          SizedBox(height: 20.h,),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      'Select your country*',
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      )
                    ),
                    SizedBox(height: 20.h),
                  
                    CountryFieldFlipper(
                      text: controller.selectedCountryController.text.isEmpty ? "Tap to select" : controller.selectedCountryController.text,
                      onFlip: () {

                        setState(() {
                          controller.isCountrySelected.value = true;
                        });
                              
                        showCountryPicker(
                          context: context,
                          showPhoneCode: false, // optional. Shows phone code before the country name.
                          onSelect: (Country country) {
                            setState(() {
                              controller.isCountrySelected.value = false;
                              controller.selectedCountryController.text = country.displayNameNoCountryCode;
                            });
                            print('Select country: ${controller.selectedCountryController.text}');
                          },
                        );
                                            
                      }
                    ),

                    SizedBox(height: 580.h),

                    ReusableButton(
                      color: AppColor.mainColor,
                      text: 'Next',
                      onPressed: () async{
                        if(controller.selectedCountryController.text.isNotEmpty) {
                          Get.to(() => SelectAccountPage(
                            wallet_balance: widget.wallet_balance,
                          ));
                        }
                        else {
                          showMySnackBar(
                            context: context,
                            backgroundColor: AppColor.redColor,
                            message: "please select your country"
                          );
                        }
                      },
                    ),

                  ]
                )
              )
            )
          )
        ]
      )
    );
  }
}