import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen/main_screen_container.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen/quotes_screen.dart';




class FirstScreenForFinancials extends StatelessWidget {
  const FirstScreenForFinancials({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor,
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
        title: CustomAppBarTitle(text: 'Financials',),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //CUSTOM CONTAINER()
            SizedBox(height: 10.h,),
            MainScreenContainer(
              text: 'Quotes',
              onTap: () {
                Get.to(() => QuotesPage());
              },
            ),
            SizedBox(height: 30.h,),
            MainScreenContainer(
              text: 'Invoices',
              onTap: () {},
            ),
            SizedBox(height: 30.h,),
            MainScreenContainer(
              text: 'Receipts',
              onTap: () {},
            ),
            SizedBox(height: 30.h,),
          ]
        ),
      ),
    );
  }
}