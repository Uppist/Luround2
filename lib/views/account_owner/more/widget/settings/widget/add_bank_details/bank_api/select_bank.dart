import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/more/transactions_controller.dart';
import 'package:luround/services/account_owner/more/settings/settings_service.dart';
import 'package:luround/services/account_owner/more/transactions/withdrawal_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/add_bank_details/search_bank_textfield_2.dart';






class SelectBankScreenForSettings extends StatefulWidget{
  const SelectBankScreenForSettings({super.key});

  @override
  State<SelectBankScreenForSettings> createState() => _SelectBankScreenForSettingsState();
}

class _SelectBankScreenForSettingsState extends State<SelectBankScreenForSettings> {
  //final controller = Get.put(TransactionsController());

  final service = Get.put(SettingsService());

  final withdrawalService = Get.put(WithdrawalService());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              //header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Bank",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    )
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      CupertinoIcons.xmark,
                      color: AppColor.darkGreyColor,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.h),
              Divider(color: AppColor.textGreyColor, thickness: 0.3,),
              SizedBox(height: 30.h),

              //Search textfield//
              SearchBankTextField2(
                onFieldSubmitted: (p0) {},
                onChanged: (p0) {
                  service.searchBankController.text = p0;
                  //print("searched bank: ${controller.selectedBank.value}");
                  withdrawalService.filterForSelectBankScreen(p0);
                },
                hintText: 'Search',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                textController: service.searchBankController,
              ),

              SizedBox(height: 30.h,),
              
              Obx(
                () {
                  return withdrawalService .filteredBankList.isNotEmpty ? Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (context, index) => Divider(color: AppColor.darkGreyColor, thickness: 0.1,),
                      itemCount: withdrawalService .filteredBankList.length, //data.length,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      itemBuilder: (context, index) {
                        final item = withdrawalService .filteredBankList[index];
                        if(withdrawalService.filteredBankList.isEmpty) {
                          return SizedBox.shrink();
                        }
                        else{
                          // Update the selected index
                          return InkWell(
                            onTap: () {                               
                              // Update the selected index
                              service.selectedIndex.value = index;
                              service.selectedBank.value = item.name;
                              service.enterBankCodeController.text = item.code;
                              // Print the selected item
                              log('Selected Bank Info: ${service.selectedBank.value}/${service.enterBankCodeController.text}');
                              Get.back();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.name,
                                        //data[index]['name'],
                                        style: GoogleFonts.inter(
                                          color: AppColor.darkGreyColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                    service.selectedIndex.value == index 
                                    ?Icon(
                                      CupertinoIcons.check_mark,
                                      color: AppColor.blackColor,
                                    ) : SizedBox.shrink(),
                                  ],
                                ),
                                SizedBox(height: 15.h,)
                              ],
                            ),
                          );
              
                          
                        }
                      }
                    ),
                    ) : //Expanded(child: Loader());
                    Expanded(
                      child: Text(
                      "Couldn't Fetch Bank",
                      style: GoogleFonts.inter(
                        color: AppColor.darkGreyColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600
                      ),
                      ),
                    );
                  
                }
              )  
            ],
          ),
        )
      ),
    );
  }
}