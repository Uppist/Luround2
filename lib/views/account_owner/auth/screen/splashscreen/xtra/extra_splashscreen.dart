import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/auth/screen/login/page/login_screen.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';
import 'package:luround/views/account_viewer/mainpage/screen/layout_builder.dart';




//when your token is expired
class SplashScreenTokenExpired extends StatelessWidget {
  const SplashScreenTokenExpired({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Image.asset("assets/splash/splash_1.png")
      ), 
      nextScreen: LoginPage(),
      duration: 500, //4000
      backgroundColor: AppColor.bgColor,
      centered: true,
      //splashIconSize: 500,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(milliseconds: 500),  //2
    );
  }
}

//for norml app entry
class SplashScreenXtra extends StatelessWidget {
  const SplashScreenXtra({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Image.asset("assets/splash/splash_1.png")
      ), 
      nextScreen: MainPage(),
      duration: 500, //4000
      backgroundColor: AppColor.bgColor,
      centered: true,
      //splashIconSize: 500,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(milliseconds: 500),  //2
    );
  }
}

//for web view
class SplashScreenXtra2 extends StatelessWidget {
  const SplashScreenXtra2({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Image.asset("assets/splash/splash_1.png")
      ), 
      nextScreen: LayoutWidget(),
      duration: 200, //4000
      backgroundColor: AppColor.bgColor,
      centered: true,
      //splashIconSize: 500,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(milliseconds: 200),  //2
    );
  }
}