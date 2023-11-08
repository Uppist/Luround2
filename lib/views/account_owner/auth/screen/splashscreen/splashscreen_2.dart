import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/auth/screen/onboarding/screen/onboarding_screen.dart';







class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Image.asset("assets/splash/splash_2.png")
      ), 
      nextScreen: OnBoardingPage()  ,
      duration: 1000, //4000
      backgroundColor: AppColor.mainColor,
      centered: true,
      //splashIconSize: 500,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(milliseconds: 1000),  //2
    );
  }
}