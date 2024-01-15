import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/more/transactions_controller.dart';
import 'package:luround/models/account_owner/more/transactions/bank_response.dart';
import 'package:luround/services/account_owner/more/transactions/withdrawal_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/accounts_tab/tabs/tab_1/widget/search_bank_textfield.dart';







class SelectBankScreen2 extends StatefulWidget {
  SelectBankScreen2({super.key});

  @override
  State<SelectBankScreen2> createState() => _SelectBankScreen2State();
}

class _SelectBankScreen2State extends State<SelectBankScreen2> {

  var controller = Get.put(TransactionsController());
  var service = Get.put(WithdrawalService());

  Future<void> _loadData() async {
    try {
      setState(() {
        service.isLoading.value = true;
      });
      final List<dynamic> banks = await service.getBanksApi();
      banks.sort((a, b) => a['name'].toLowerCase().compareTo(b['name'].toLowerCase()));
      setState(() {
        service.isLoading.value = false;
        service.filteredBankList.value = List.from(banks);
        print("initState: ${service.filteredBankList}");
      });
    } 
    catch (error) {
      setState(() {
        service.isLoading.value = false;
      });
      print("Error loading data: $error");
      // Handle error as needed, e.g., show an error message to the user
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body:service.isLoading.value ? Loader() : SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SearchBankTextField(
                onFieldSubmitted: (p0) {
                  setState(() {
                    service.filterForSelectBankScreen2(p0);
                  });
                },
                hintText: 'Search',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                textController: controller.searchBankController2,
              ),

              SizedBox(height: 30.h,),

              
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (context, index) => Divider(color: AppColor.darkGreyColor, thickness: 0.1,),
                      itemCount: service.filteredBankList.length, //data.length,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      itemBuilder: (context, index) {
                        final item = service.filteredBankList[index];
                        if(service.filteredBankList.isEmpty) {
                          return const Loader();
                        }
                        return Obx(
                          () {
                            return InkWell(
                              onTap: () {                               
                                // Update the selected index
                                service.selectedIndex.value = index;
                                controller.enterBankController.text = item['name'];
                                controller.enterBankCodeController.text = item['code'];
                                // Print the selected item
                                print('Selected Item: ${controller.enterBankController.text}/${controller.enterBankCodeController.text}');
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
                                          item['name'],
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
                                      ) : SizedBox(),
                                    ],
                                  ),
                                  SizedBox(height: 15.h,)
                                ],
                              ),
                            );
                          }
                        );
                      }
                    ),
                  )

              
                  
                
            ],
          ),
        )
      ),
    );
  }
}