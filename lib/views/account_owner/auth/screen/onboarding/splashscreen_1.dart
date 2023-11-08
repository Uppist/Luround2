import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/auth/screen/onboarding/splashscreen_2.dart';







class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: SvgPicture.asset("assets/splash/splash_1.png")
      ), 
      nextScreen: SplashScreen2()  ,
      duration: 2000, //4000
      backgroundColor: AppColor.bgColor,
      centered: true,
      //splashIconSize: 500,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(seconds: 2),  //2
    );
  }
}