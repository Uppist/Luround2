import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/services/user_services._service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/services/service_type/event_service_list.dart';
import 'package:luround/views/account_owner/services/service_type/retainer_service_list.dart';
import 'package:luround/views/account_owner/services/service_type/program_service_list.dart';
import 'package:luround/views/account_owner/services/service_type/oneoff_service_list.dart';





class ServiceScreenTab extends StatefulWidget {
  const ServiceScreenTab({super.key});

  @override
  State<ServiceScreenTab> createState() => _ServiceScreenTabState();
}

class _ServiceScreenTabState extends State<ServiceScreenTab> with SingleTickerProviderStateMixin{
  
  final service = Get.put(AccOwnerServicePageService());


  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          //added
          TabBar(    
            enableFeedback: true, 
            dividerColor: AppColor.bgColor,               
            physics: const BouncingScrollPhysics(),
            indicatorColor: AppColor.darkGreyColor,
            indicatorSize: TabBarIndicatorSize.label,
            //indicatorWeight: 0.1,
            labelStyle: GoogleFonts.inter(
              textStyle: TextStyle(
                color: AppColor.darkGreyColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            unselectedLabelColor: AppColor.textGreyColor,
            labelColor: AppColor.darkGreyColor,
            //padding: EdgeInsets.symmetric(horizontal: 10),
            /*indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              color: AppColor.navyBlue,
              shape: BoxShape.rectangle,
            ),*/
            controller: tabController,
            isScrollable: false,
            tabs: const [
              Tab(text: 'One-off',),
              Tab(text: 'Retainer',),
              Tab(text: 'Program',),
              Tab(text: 'Event',),
            ],
            onTap: (index) {
              setState(() {
                // Update active tab index and current items
                service.activeTabIndex = index;
                //run checks
                if (index == 0) {
                  //one-off service
                  service.filterSearchServicesList.clear();
                  service.filterSearchServicesList.addAll(service.servicesList);
                } 
                else if (index == 1) {
                  //retainer service
                  service.filterSearchServicesList.clear();
                  service.filterSearchServicesList.addAll(service.servicesListRetainer);
                } 
                else if(index == 2) {
                  //program service
                  service.filterSearchServicesList.clear();
                  service.filterSearchServicesList.addAll(service.servicesListProgram);
                }
                else if(index == 3) {
                  //event service
                  service.filterSearchServicesList.clear();
                  service.filterSearchServicesList.addAll(service.servicesListEvent);
                }
                else {
                  print('no more indices to check');
                }
                // Apply search filter
                //service.filterItems(service.searchServicesList);
              }
            );
          },
          ),
      
          SizedBox(height: 20.h,),
            
          //tabbar content here //wrap with future builder
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: const BouncingScrollPhysics(),
              children: const [
                RegularServiceList(),
                PackageServiceList(),
                ProgramServiceList(), 
                EventServiceList(),    
              ]
            ),
          ),
            
        ],
      ),
    );
  }
}