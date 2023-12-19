import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/transactions_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/accounts_tab/tabs/tab_1/widget/search_bank_textfield.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/wallet/screen/transfer_screen.dart';





class ShowSavedBanks extends StatelessWidget {
  ShowSavedBanks({super.key});

  var controller = Get.put(TransactionsController());

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
            SearchBankTextField(
              onFieldSubmitted: (p0) {},
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
                itemCount: 2,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                itemBuilder: (context, index) {
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
                          bankCode: '', //fetch from db
                          accountName: '',  //fetch from db
                          accountNumber: '',
                          bankName: '',
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
                                    "Melissa Gates",
                                    style: GoogleFonts.inter(
                                    color: AppColor.blackColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  SizedBox(height: 10.h,),
                                  Text(
                                    "Fidelity | 2022481315",
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
              ),
            )
          ]
        ),
      )
    );
  }
}