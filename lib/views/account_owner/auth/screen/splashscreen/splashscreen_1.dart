import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luround/controllers/account_owner/auth/authentication_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/auth/screen/splashscreen/splashscreen_2.dart';







class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {

  //var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Image.asset("assets/splash/splash_2.png")
      ), 
      nextScreen: SplashScreen2(),
      duration: 1000, //4000
      backgroundColor: AppColor.mainColor,
      centered: true,
      //splashIconSize: 500,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(milliseconds: 1000),  //2
    );
  }
}