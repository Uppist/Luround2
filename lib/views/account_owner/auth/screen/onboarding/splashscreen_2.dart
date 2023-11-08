import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luround/utils/colors/app_theme.dart';







class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: SvgPicture.asset("assets/splash/splash_2.png")
      ), 
      nextScreen: SizedBox()  ,
      duration: 2000, //4000
      backgroundColor: AppColor.mainColor,
      centered: true,
      //splashIconSize: 500,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(seconds: 2),  //2
    );
  }
}