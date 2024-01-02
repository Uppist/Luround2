import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/more/transactions_controller.dart';
import 'package:luround/models/account_owner/more/saved_banks_response.dart';
import 'package:luround/services/account_owner/more/transactions/withdrawal_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/accounts_tab/empty_states/no_saved_accounts.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/accounts_tab/tabs/tab_1/screen/add_account_screen.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/accounts_tab/tabs/tab_1/widget/search_bank_textfield.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/wallet/screen/transfer_screen.dart';





class ShowSavedBanks extends StatefulWidget {
  ShowSavedBanks({super.key, required this.wallet_balance});
  final int wallet_balance;

  @override
  State<ShowSavedBanks> createState() => _ShowSavedBanksState();
}

class _ShowSavedBanksState extends State<ShowSavedBanks> {

  var controller = Get.put(TransactionsController());
  var service = Get.put(WithdrawalService());

  @override
  void initState() {
    super.initState();
    service.loadSavedBanksData().then(
      (value) => print("Saved Banks Loaded into the Widget Tree: $value")
    );
    
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Obx(
        () {
          return service.isLoading.value ? Loader() : Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                SearchBankTextField(
                  onFieldSubmitted: (p0) {
                    setState(() {
                      service.filterSavedBank(p0);
                    });
                  },
                  hintText: 'Search',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.go,
                  textController: controller.searchSavedBankController,
                ),        
                SizedBox(height: 40.h,),      
                //LIST OF SAVED BANKS GOTTEN FROM BACKEND API/
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
                            Get.to(() => AddAccountPageFromButton());
                          },
                        );
                      }

                      if(service.filteredSavedAccounts.isNotEmpty) {
                        return Dismissible(
                          direction: DismissDirection.endToStart,
                          key: UniqueKey(),
                          onDismissed: (direction) {},
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
                            onTap: () {
                              Get.to(() => TransferScreen(
                                wallet_balance: widget.wallet_balance,
                                bankCode: item.bank_code, //fetch from db
                                accountName: item.account_name,  //fetch from db
                                accountNumber: item.account_number,
                                bankName: item.bank_name,
                              ));
                            },
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
                          Get.to(() => AddAccountPageFromButton());
                        },
                      );

                    }
                  ),
                )
              ]
            ),
          );
        }
      )   
    );
  }
}