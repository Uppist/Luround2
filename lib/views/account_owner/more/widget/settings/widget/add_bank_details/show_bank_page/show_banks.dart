import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/models/account_owner/more/transactions/saved_banks_response.dart';
import 'package:luround/services/account_owner/more/settings/settings_service.dart';
import 'package:luround/services/account_owner/more/transactions/withdrawal_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/add_bank_details/add_bank_functionalities/add_new_bank_from_button.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/add_bank_details/empty_states/no_saved_accounts.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/add_bank_details/search_bank_textfield_2.dart';







class ShowBanks extends StatefulWidget {
  const ShowBanks({super.key,});

  @override
  State<ShowBanks> createState() => _ShowBanksState();
}

class _ShowBanksState extends State<ShowBanks> {

  final service = Get.put(SettingsService());
  final TextEditingController searchBankTextController = TextEditingController();

  Future<void> fetchData() async {
    try {
      List<SavedBanks> data = await service.getUserSavedAccounts();
      data.sort((a, b) => a.account_name.toLowerCase().compareTo(b.account_name.toLowerCase()));
      service.filteredSavedAccounts.clear();
      service.filteredSavedAccounts.addAll(data);
    } catch (error) {
      log("Error fetching data: $error");
    } finally {
      log("done");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((val) {
      fetchData();
    });
    //fetchData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchBankTextController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            SearchBankTextField2(
              onFieldSubmitted: (p0) {},
              onChanged: (p0) {
                service.filterSavedBank(p0);
              },
              hintText: 'Search',
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              textController: searchBankTextController,
            ),        
            SizedBox(height: 40.h,),      
            //LIST OF SAVED BANKS GOTTEN FROM BACKEND API/
            Obx(
              () {
                return service.filteredSavedAccounts.isNotEmpty ?
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (context, index) => SizedBox(height: 30.h),
                      itemCount: service.filteredSavedAccounts.length,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      itemBuilder: (context, index) {

                        final item = service.filteredSavedAccounts[index];              
                        if(service.filteredSavedAccounts.isEmpty) {
                          return NoSavedAccounts(
                            onPressed: () {
                              Get.to(() => AddAccountForSettings2());
                            },
                          );
                        }
                
                        if(service.filteredSavedAccounts.isNotEmpty) {
                          return Dismissible(
                            direction: DismissDirection.endToStart,
                            key: UniqueKey(),
                            onDismissed: (direction) {
                              service.deleteBankDetails(
                                context: context, 
                                account_name: item.account_name,
                                account_number: item.account_number,
                                bank_name: item.bank_name,
                                bank_code: item.bank_code,
                                country: item.country
                              );
                            },
                            background: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.delete_outline_rounded,
                                  color: AppColor.redColor,
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                                alignment: Alignment.center,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColor.greyColor
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset("assets/svg/bank.svg"),
                                    SizedBox(width: 20.w,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.account_name,
                                            style: GoogleFonts.inter(
                                              color: AppColor.blackColor,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          SizedBox(height: 10.h,),
                                          Text(
                                            "${item.bank_name} | ${item.account_number}",
                                            style: GoogleFonts.inter(
                                              color: AppColor.darkGreyColor,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ],
                                      )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }          
                        return NoSavedAccounts(
                          onPressed: () {
                            Get.to(() => AddAccountForSettings2(), transition: Transition.rightToLeft); //AddAccountForSettings
                          },
                        ); 
                      }
                    ),
                  ):NoSavedAccounts(
                   onPressed: () {
                    Get.to(() => AddAccountForSettings2(), transition: Transition.rightToLeft);
                  },
                );
              }
            )
          ]
        ),
      )
      
      
    );
  }
}