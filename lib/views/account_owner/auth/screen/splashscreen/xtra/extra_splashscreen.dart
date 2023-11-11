import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';







class SplashScreenXtra extends StatelessWidget {
  const SplashScreenXtra({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Image.asset("assets/splash/splash_1.png")
      ), 
      nextScreen: MainPage(),
      duration: 1000, //4000
      backgroundColor: AppColor.bgColor,
      centered: true,
      //splashIconSize: 500,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(milliseconds: 1000),  //2
    );
  }
}