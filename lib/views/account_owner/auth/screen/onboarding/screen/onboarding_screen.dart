import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luround/controllers/account_owner/authentication_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';











class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: buildBody(context),
      )
    );
  }

  Widget buildBody(BuildContext context) {

    var controller = Get.put(AuthController());
    final size = MediaQuery.of(context).size;
    int activePage = 0;
    final PageController pageViewController = PageController(initialPage: activePage);

    return Column(
      children: [        
        SizedBox(height: 110), //100.h
        //PageView.builder() Widget
        SizedBox(
          height: 400, //550
          width: size.width,  //double.infinity
          child: PageView.builder( 
            scrollDirection: Axis.horizontal,
            itemCount: controller.pages.length,
            controller: pageViewController,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (value) {
              setState(() {
                activePage = value;
              });
              debugPrint('$activePage');
            },
            itemBuilder: (context, index) {
              return controller.pages[index];
            }
          ),
        ),
        //SizedBox(height: 30),
        //SmoothPageIndicator
        SmoothPageIndicator(
          //activeIndex: activePage,
          controller: pageViewController, 
          count: controller.pages.length,  
          onDotClicked: (index) {
            pageViewController.animateToPage(
              index, 
              duration: const Duration(milliseconds: 300), 
              curve: Curves.elasticInOut
            );
          }, 
          effect: WormEffect(
            dotHeight: 10.0,  //8
            dotWidth: 10.0, //25
            dotColor: Colors.grey.withOpacity(0.2),
            activeDotColor: AppColor.mainColor,
            type: WormType.normal,
          ),
        ),                  
        SizedBox(height: 60),
        //for the two buttons
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RebrandedReusableButton(
                color: AppColor.mainColor, 
                text: "Login to Luround", 
                onPressed: () {}, 
                textColor: AppColor.bgColor
              ),
              SizedBox(height: 20),
              RebrandedReusableButton(
                color: AppColor.bgColor, 
                text: "Create account", 
                onPressed: () {}, 
                textColor: AppColor.mainColor
              )
            ],
          ),
        ),
          
      ],  
    );
  }
}