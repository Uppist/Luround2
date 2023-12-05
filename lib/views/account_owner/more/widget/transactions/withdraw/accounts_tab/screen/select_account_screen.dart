import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/accounts_tab/empty_states/no_saved_accounts.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/accounts_tab/tabs/tab_1/screen/add_account_screen.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/accounts_tab/tabs/tab_1/screen/show_saved_banks.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/accounts_tab/tabs/tab_2/screen/new_account_screen.dart';





class SelectAccountPage extends StatefulWidget {
  const SelectAccountPage({super.key});

  @override
  State<SelectAccountPage> createState() => _SelectAccountPageState();
}
 
class _SelectAccountPageState extends State<SelectAccountPage> with SingleTickerProviderStateMixin {

  late TabController tabController;
  late Color firstTabBackground;
  late Color secondTabBackground;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    /*firstTabBackground = swapSpacePrimaryColor;
    secondTabBackground = swapSpaceAccentColor;
    tabController.addListener(() {
      if (tabController.index == 0) {
        setState(() {
          firstTabBackground = swapSpacePrimaryColor;
          secondTabBackground = swapSpaceAccentColor;
        });
      }
      else {
        setState(() {
          firstTabBackground = swapSpaceAccentColor;
          secondTabBackground = swapSpacePrimaryColor;
        });
      }
    });*/
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
                            borderRadius: BorderRadius.circular(5.r),
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
                      NoSavedAccounts(
                        onPressed: () {
                          Get.to(() => AddAccountPageFromButton());
                        },
                      ),
                      //ShowSavedBanks(),
                      AddNewAccount()     
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