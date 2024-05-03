import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/const/theme/theme.dart';
import 'features/feature_bottom_nav/bloc/bottomnav_cubit.dart';
import 'features/feature_bottom_nav/screens/bottom_nav.dart';
import 'features/feature_home/data/repository/home_repository.dart';
import 'features/feature_home/presentation/bloc/home_bloc.dart';
import 'features/feature_home/presentation/screen/home_screen.dart';
import 'features/feature_intro/presentation/domain/bloc/cubit/intro_cubit.dart';
import 'features/feature_intro/presentation/screens/intro_screen.dart';
import 'features/feature_intro/presentation/screens/splash_screen.dart';
import 'features/feature_intro/unknown_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      designSize: const Size(360, 690),
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider<IntroCubit>(
            create: (context) => IntroCubit(),
          ),
          // BlocProvider<HomeCubit>(
          //   create: (context) => HomeCubit(),
          // ),
          BlocProvider<BottomNavCubit>(
            create: (context) => BottomNavCubit(),
          ),
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(HomeRepository()),
          ),
        ],
        child: MaterialApp(
          theme: CustomTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('fa'), //farsi
          ],
          initialRoute: BottomNavBar.bottomNavBarId,
          onUnknownRoute: (settings) => MaterialPageRoute(
              builder: (BuildContext context) => const UnknownScreen()),
          routes: {
            SplashScreen.splashScreenId: (context) => const SplashScreen(),
            IntroScreen.introScreenId: (context) => const IntroScreen(),
            HomeScreen.homeScreenId: (context) => const HomeScreen(),
            BottomNavBar.bottomNavBarId: (context) => const BottomNavBar(),
          },
        ),
      ),
    );
  }
}
