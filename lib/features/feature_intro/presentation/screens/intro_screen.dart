import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/const/responsive/responsive.dart';
import '../../../../core/const/shape/media_query.dart';
import '../../../../core/const/theme/colors.dart';
import '../../../../core/widgets/shared_preferences.dart';
import '../../../feature_home/presentation/screen/home_screen.dart';
import '../domain/bloc/cubit/intro_cubit.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  static const String introScreenId = '/intro_screen';

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController pageController = PageController(initialPage: 0);
  final List<Widget> introPageView = [
    const PageViewWidget(
      title: 'اینجا همه چی پیدا میشه',
      description:
          'تمام محصولاتی که میخوای رو میتونی به راحتی و با قیمت مناسب پیدا کنی...',
      imagePath: 'assets/images/intro/iphone-x-pictures-45229.png',
    ),
    const PageViewWidget(
      title: 'خرید خوبی داشته باشی',
      description:
          'تمام محصولاتی که میخوای رو میتونی به راحتی و با قیمت مناسب پیدا کنی...',
      imagePath: 'assets/images/intro/pngwing.com.png',
    ),
    const PageViewWidget(
      title: 'یه سرچ با چیزی که نیاز داری فاصله داری',
      description:
          'تمام محصولاتی که میخوای رو میتونی به راحتی و با قیمت مناسب پیدا کنی...',
      imagePath: 'assets/images/intro/Apple-iPad-PNG-Free-Download.png',
    ),
    const PageViewWidget(
      title: 'تا دلت بخواد تخفیف داریم ',
      description:
          'تمام محصولاتی که میخوای رو میتونی به راحتی و با قیمت مناسب پیدا کنی...',
      imagePath: 'assets/images/intro/pngwing.com1.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: WaveClipperOne(),
            child: Container(
              height: 200,
              color: primaryColor,
            ),
          ),
          Center(
            child: BlocBuilder<IntroCubit, int>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 320,
                      width: getWidth(context, 0.65),
                      child: PageView.builder(
                        onPageChanged: (value) {
                          BlocProvider.of<IntroCubit>(context)
                              .changeIndex(value);
                        },
                        controller: pageController,
                        scrollDirection: Axis.horizontal,
                        itemCount: introPageView.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: introPageView[index],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: Responsive.isDesktop(context) ? 15.sp : 3.sp,
                    ),
                    SmoothPageIndicator(
                      controller: pageController,
                      count: introPageView.length,
                      effect: const ExpandingDotsEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        activeDotColor: primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(getWidth(context, 0.35), 40),
                        ),
                        onPressed: () async {
                          if (BlocProvider.of<IntroCubit>(context)
                                  .currentIndex <
                              introPageView.length - 1) {
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          } else {
                            SharedPref().setData();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                HomeScreen.homeScreenId, (route) => false);
                          }
                        },
                        child: Text(
                            BlocProvider.of<IntroCubit>(context).currentIndex <
                                    introPageView.length - 1
                                ? 'بعدی'
                                : 'برو بریم'))
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  final String title;

  final String description;

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Column(
      children: [
        Image.asset(
          imagePath,
          height: Responsive.isDesktop(context) ? 120 : 175,
        ),
        SizedBox(
          height: Responsive.isDesktop(context) ? 8.sp : 15.sp,
        ),
        Text(
          textAlign: TextAlign.center,
          title,
          style: TextStyle(
            fontSize: isDesktop ? 8.sp : 16.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'bold',
          ),
        ),

        Text(
          textAlign: TextAlign.center,
          description,
          style: TextStyle(
            fontSize: isDesktop ? 6.sp : 12.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
