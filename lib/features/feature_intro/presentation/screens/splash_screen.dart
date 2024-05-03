import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:animate_do/animate_do.dart';


import '../../../../core/const/responsive/responsive.dart';
import '../../../../core/const/shape/media_query.dart';
import '../../../../core/const/theme/colors.dart';
import '../../../../core/widgets/shared_preferences.dart';
import '../../../feature_home/presentation/screen/home_screen.dart';
import 'intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String splashScreenId = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigateTimer() async {
    Timer(const Duration(seconds: 3), () async{
      if (await SharedPref().getData()) {
        Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.homeScreenId,    (Route<dynamic> route) => false);
      } else {
      Navigator.of(context)
          .pushReplacementNamed(IntroScreen.introScreenId);
      }
    });
  }

  @override
  void initState() {
    navigateTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final isDesktop= Responsive.isDesktop(context);
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: FadeInDown(
          duration: const Duration(milliseconds: 850),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: theme.scaffoldBackgroundColor,
                radius: isDesktop?getWidth(context, 0.05):getWidth(context, 0.175),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: isDesktop?getWidth(context, 0.05):getWidth(context, 0.175),
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Text(
                'Prokala',
                style: TextStyle(
                    color: whiteColor,
                    fontSize:isDesktop?8.sp: 16.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'bold'),
              ),
              SizedBox(
                height: 3.sp,
              ),
              Text(
                'www.github.com',
                style: TextStyle(
                    color: whiteColor,
                    fontSize: isDesktop?6.sp:12.sp,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'bold'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
