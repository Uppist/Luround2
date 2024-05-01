import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/auth_service/auth_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/utils_textfield.dart';
import 'package:luround/views/account_owner/services/widget/package/add_service/step_tabs/step_3/new/custom_checkbox.dart';








class DeleteAccountScreen2 extends StatefulWidget {
  const DeleteAccountScreen2({super.key});

  @override
  State<DeleteAccountScreen2> createState() => _DeleteAccountScreen2State();
}

class _DeleteAccountScreen2State extends State<DeleteAccountScreen2> {
  final authService = Get.put(AuthService());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: AppColor.bgColor,
      statusBarColor: Colors.transparent, //AppColor.bgColor,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.h,),
            //Header
            /////////////
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: AppColor.blackColor,
                    )
                  ),
                  SizedBox(width: 3.w,),
                  Text(
                    "Delete account",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: SingleChildScrollView(
                //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                physics: BouncingScrollPhysics(), //NeverScrollableScrollPhysics()
                child: Container(
                  color: AppColor.greyColor,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Container(
                        color: AppColor.greyColor,
                        width: double.infinity,
                        height: 7.h,
                      ),        
                      SizedBox(height: 10.h,),
        
                      //checkbox listview
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          "Why are you deleting your account?",
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        separatorBuilder: (context, index) => SizedBox(height: 10.h,),
                        itemCount: authService.deletionReasonsList.length,
                        itemBuilder: (context, index) {
                          
                          return CustomCheckBox(
                            checkbox: Checkbox.adaptive(
                              checkColor: AppColor.bgColor,
                              activeColor: AppColor.mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r)
                              ),
                              value: authService.deletionReasonsList[index]["isChecked"],
                              onChanged: (value){
                                setState(() {
                                  authService.isDeletionCheckBoxActive.value = true;
                                  authService.toggleCheckbox(index, value);
                                  print("selected reason: ${authService.selectedReason}");
                                  
                                  //checks for dweller
                                  if(authService.deletionReasonsList[index]['reason'] == "Another reason") {
                                    //authService.showReasonTextField.value = true;
                                    authService.showReasonTextField.value = !authService.showReasonTextField.value;
                                  } 
                                });
                              },
                            ),
                            title: Text(
                              authService.deletionReasonsList[index]["reason"],
                              style: GoogleFonts.inter(
                                color: AppColor.textGreyColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400
                              ),
                            )
                          );  
                        }, 
                      ),
        
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01), 
        
                      Obx(
                        () {
                          return authService.showReasonTextField.value ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: UtilsTextField3(
                              onChanged: (p0) {},
                              hintText: "Type it here",
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              textController: authService.anotherReasonController,
                              
                            ),
                          ) : SizedBox();
                        }
                      ),
        
                      SizedBox(height: MediaQuery.of(context).size.height * 0.21), //0.22
        
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: CustomCheckBox(
                          checkbox: Checkbox.adaptive(
                            checkColor: AppColor.bgColor,
                            activeColor: AppColor.mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r)
                            ),
                            value: authService.isChecked.value,
                            onChanged: (value){
                              setState(() {
                                authService.isChecked.value = value!;
                                print(authService.isChecked.value);   
                              });
                            },
                          ),
                          title: Text(
                            "By continuing, you wish to delete your\naccount permanently.",
                            style: GoogleFonts.inter(
                              color: AppColor.textGreyColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400
                            ),
                            textAlign: TextAlign.start,
                          )
                        ),
                      ),
                      
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02), //0.26
                          
                      Container(
                        alignment: Alignment.center,
                        height: 100.h, //100.h,
                        color: AppColor.bgColor,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Obx(
                          () {
                            return authService.isLoading.value ? const Loader2() : RebrandedReusableButton(
                              textColor: AppColor.bgColor,
                              color: AppColor.mainColor,
                              text: "Delete", 
                              onPressed: () {
                                if(authService.selectedReason.isNotEmpty) {
                                  if (authService.isChecked.value) {
                                    // Perform actions when terms and conditions are accepted
                                    print('Terms and conditions accepted!');
                                    authService.deleteUserAccount(context: context);
                                  } else {
                                    // Show a message or dialog prompting to accept terms and conditions
                                    showMySnackBar(
                                      context: context, 
                                      message: "Please accept the terms and conditions", 
                                      backgroundColor: AppColor.redColor
                                    );
                                  }
                                }
                                else{
                                  showMySnackBar(
                                    context: context, 
                                    message: "Please select a reason for deletion", 
                                    backgroundColor: AppColor.redColor
                                  );
                                }
                              }
                            );
                          }
                        ),
                      ),
                              
                      //SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
            //
                      
          ]
        ),
      )
    );
  }
}