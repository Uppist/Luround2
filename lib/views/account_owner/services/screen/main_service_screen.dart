import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/services/user_services._service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/bookings/widget/search_textfield.dart';
import 'package:luround/views/account_owner/services/service_tab/service_screen_tab.dart';
import 'package:luround/views/account_owner/services/widget/screen_widget/channel/choose_service_type_screen.dart';










class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {

  final userService = Get.put(AccOwnerServicePageService());

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColor.bgColor,
        statusBarColor: AppColor.bgColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Header Section
            Container(
              color: AppColor.bgColor,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                   
                      Text(
                        "Services",
                        style: GoogleFonts.inter(
                          color: AppColor.blackColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      InkWell(
                        onTap: () async{
                          Get.to(() => const ChooseServiceTypePage());
                        },
                        child: SvgPicture.asset("assets/svg/add_service.svg"),
                      ),
                    ]
                  ),
                ],
              ),
            ),         
                 
            //SizedBox(height: 15.h,),      
            
            //search textfield
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: SearchTextField(
                onFocusChanged: (val) {},
                onFieldSubmitted: (val) {
                  if(userService.activeTabIndex == 0) {
                    //one-off
                    userService.filterRegularServices(val);
                  }
                  else if(userService.activeTabIndex == 1){
                    //retainer
                    userService.filterPackageServices(val);
                  }
                  else if(userService.activeTabIndex == 2){
                    //program
                    userService.filterProgramServices(val);
                  }
                  else if(userService.activeTabIndex == 3){
                    //event
                    //userService.filterEventServices(val);
                  }
                  else {
                    print('no more func');
                  }
                },
                hintText: "Search",
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                textController: userService.searchServiceController,
                onTap: () {
                  //service.searchContactController.clear();
                },
              ),
            ),
            
            //SizedBox(height: 10.h,), 
      
            //service tab here
            const ServiceScreenTab()
            
                
          ]
        )
      ),
    );
  }
}