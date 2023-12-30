import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen/quotes_screen/requested_quotes/requested_quotes.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen/quotes_screen/sent_qoutes/sent_quote_screen.dart';



class QuoteScreenTab extends StatefulWidget {
  const QuoteScreenTab({super.key});

  @override
  State<QuoteScreenTab> createState() => _QuoteScreenTabState();
}

class _QuoteScreenTabState extends State<QuoteScreenTab> with SingleTickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h,),
          Row(
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
                "Quotes",
                style: GoogleFonts.inter(
                  color: AppColor.blackColor,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.h),
                  child: AnimatedContainer(
                    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.bgColor,
                      borderRadius: BorderRadius.circular(50.r),
                      border: Border.all(color: AppColor.navyBlue)
                    ),
                    duration: const Duration(milliseconds: 100),
                    child: Column(
                      children: [
                        //added
                        TabBar(                    
                          physics: const BouncingScrollPhysics(),
                          indicatorColor: AppColor.navyBlue,
                          indicatorSize: TabBarIndicatorSize.tab,
                          //indicatorWeight: 0.1,
                          labelStyle: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: AppColor.bgColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          unselectedLabelColor: AppColor.navyBlue,
                          labelColor: AppColor.bgColor,
                          //padding: EdgeInsets.symmetric(horizontal: 10),
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.r),
                            color: AppColor.navyBlue,
                            shape: BoxShape.rectangle,
                          ),
                          controller: tabController,
                          isScrollable: false,
                          tabs: const [
                            Tab(text: 'Sent',),
                            Tab(text: 'Requests',),
                            Tab(text: 'Drafts',),
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
                      SentQuotesPage(),
                      RequestedQuotesPage(),
                      SizedBox()
                    ]
                  ),
                ),
              ]
            )
          )
      
        ],
      ),
    );
  }
}