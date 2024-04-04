import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/services/account_viewer/services/get_user_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_viewer/services/screen/search_textfield.dart';
import 'package:luround/views/account_viewer/services/service_tab/service_screen_tab.dart';









class AccViewerServicesPage extends StatelessWidget {
  AccViewerServicesPage({super.key,});

  final controller = Get.put(AccViewerServicesController());
  final service = Get.put(AccViewerService());


  @override
  Widget build(BuildContext context) {
    
    // Access the parameter using Get.parameters['userName']
    String userName = Get.parameters['user'] ?? 'DefaultUserName';
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
            ///Header Section
            Container(
              color: AppColor.bgColor,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/luround_logo.png'),
                    ]
                  ),
                  SizedBox(height: 30.h,),
                  Center(
                    child: Text(
                      "Services",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  //SizedBox(height: 10,),
                ],
              ),
            ),        
            /////////////////
          
            //search textfield
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: SearchTextFieldWeb(
                onFocusChanged: (val) {},
                onFieldSubmitted: (val) {
                  if(service.activeTabIndex == 0) {
                    service.filterRegularServices(val);
                  }
                  else if(service.activeTabIndex == 1){
                    print('func for filtering package service');
                  }
                  else if(service.activeTabIndex == 2){
                    print('func for filtering program service');
                  }
                  else {
                    print('no more func');
                  }
                },
                hintText: "Search",
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                textController: service.searchServiceController,
                onTap: () {},
              ),
            ),
                
            //SizedBox(height: 20.h,),

            //SERVICE TAB
            ServiceScreenTabForWeb(userName: userName),
            
            ///
          ]
        )
      ),
    );
  }
}