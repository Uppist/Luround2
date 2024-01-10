import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/add_bank_details/add_new_bank.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/add_bank_details/show_banks.dart';







class BankDetailsPage extends StatefulWidget {
  const BankDetailsPage({super.key,});

  @override
  State<BankDetailsPage> createState() => _BankDetailsPageState();
}
 
class _BankDetailsPageState extends State<BankDetailsPage> with SingleTickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

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
        title: CustomAppBarTitle(text: 'Account details',),
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
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: AnimatedContainer(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.bgColor,
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(color: AppColor.mainColor)
                    ),
                    duration: const Duration(milliseconds: 100),
                    child: Column(
                      children: [

                        //added
                        TabBar(                    
                          physics: const BouncingScrollPhysics(),
                          indicatorColor: AppColor.mainColor,
                          indicatorSize: TabBarIndicatorSize.tab,
                          //indicatorWeight: 0.1,
                          labelStyle: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: AppColor.bgColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          unselectedLabelColor: AppColor.mainColor,
                          labelColor: AppColor.bgColor,
                          //padding: EdgeInsets.symmetric(horizontal: 10),
                          indicator: BoxDecoration(
                            //borderRadius: BorderRadius.circular(5.r),
                            color: AppColor.mainColor
                          ),
                          controller: tabController,
                          isScrollable: false,
                          tabs: const [
                            Tab(text: 'Saved Accounts',),
                            Tab(text: 'New Account',)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                //tabbar content here //wrap with future builder
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      //empty state
                      /*NoSavedAccounts(
                        onPressed: () {
                          Get.to(() => AddAccountPageFromButton());
                        },
                      ),*/
                      ShowBanks(),
                      
                      AddAccountForSettings()    
                    ]
                  ),
                )

              ],
            ),
          ),
        ]
      )
    );
  }
}