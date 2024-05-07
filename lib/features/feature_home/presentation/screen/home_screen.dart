import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/const/responsive/responsive.dart';
import '../../../../core/const/shape/border_radius.dart';
import '../../../../core/const/shape/media_query.dart';
import '../../../../core/const/theme/colors.dart';
import '../../../../core/widgets/shimmer.dart';
import '../../../feature_bottom_nav/data/models/api_model.dart';
import '../bloc/home_bloc.dart';
import '../cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String homeScreenId = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(CallApiEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return RefreshIndicator(
      color: primaryColor,
      onRefresh: () async {
        BlocProvider.of<HomeBloc>(context).add(CallApiEvent());
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBarSection(theme: theme),
          SliverList(
              delegate: SliverChildListDelegate.fixed([
            BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              if (state is HomeLoading) {
                return const ShimmerLoading();
              } else if (state is HomeSuccess) {
                HomeModel homeModel = state.homeModel;
                return Column(
                  children: [
                    CarouselSection(homeModel: homeModel),
                    SizedBox(height: 15.sp,),
                    BrandsSection(homeModel: homeModel, theme: theme),
                    SizedBox(height: 12.sp,),
                  ],
                );
              } else if (state is HomeError) {
                return Center(child: Text(state.exceptionMessage));
              }
              return const SizedBox.shrink();
            }),
          ]))
        ],
      ),
    );
  }
}

class BrandsSection extends StatelessWidget {
  const BrandsSection({
    super.key,
    required this.homeModel,
    required this.theme,
  });

  final HomeModel homeModel;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
     margin: EdgeInsets.symmetric(horizontal:getWidth(context, 0.04)),
      width: getAllWidth(context),
      child: GridView.builder(

        itemCount: homeModel.brands!.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
                crossAxisSpacing: 55,
                crossAxisCount: 4),
        itemBuilder: (context, index) {

          return Container(
            decoration: ShapeDecoration(
                color: theme.scaffoldBackgroundColor,
                shape:  ContinuousRectangleBorder(
                  borderRadius: getBorderRadiusFunc(40),
                ),
            shadows:[ BoxShadow(
              color: theme.shadowColor.withOpacity(0.7),
              spreadRadius: -12,
              blurRadius: 10,
              offset: const Offset(0.1,10)

            )]
            ),
            child: FadeInImage(
              placeholder:
                  const AssetImage('assets/images/logo.png'),
              image:
                  NetworkImage(homeModel.brands![index].image!),
            ),
          );
        },

      ),
    );
  }
}

class CarouselSection extends StatelessWidget {
  const CarouselSection({
    super.key,
    required this.homeModel,
  });

  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    return homeModel.sliders == null
        ? Container()
        : BlocProvider(
            create: (context) => HomeCubit(),
            child: BlocBuilder<HomeCubit, int>(
              builder: (context, state) {
                return Column(
                  children: [
                    CarouselSlider.builder(
                        itemCount: homeModel.sliders!.length,
                        itemBuilder: (context, index, realIndex) {
                          return InkWell(
                            onTap: () async {
                              final url = homeModel.sliders![index].link!;
                              if (await canLaunchUrlString(url)) {
                                await launchUrlString(url,
                                    mode: LaunchMode.externalApplication);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ClipRRect(
                                borderRadius: getBorderRadiusFunc(10),
                                child: FadeInImage(
                                  placeholder: const AssetImage(
                                      'assets/images/logo.png'),
                                  image: NetworkImage(
                                      homeModel.sliders![index].image!),
                                  fit: BoxFit.cover,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) =>
                                          Image.asset('assets/images/logo.png'),
                                  placeholderErrorBuilder:
                                      (context, error, stackTrace) =>
                                          Container(),
                                ),
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reason) {
                            BlocProvider.of<HomeCubit>(context)
                                .changeCurrentIndex(index);
                          },
                          height: getWidth(context, 0.42),
                          autoPlay: true,
                          enlargeCenterPage: true,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlayInterval: const Duration(seconds: 5),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          scrollDirection: Axis.horizontal,
                          viewportFraction: 0.9,
                        )),
                    AnimatedSmoothIndicator(
                      activeIndex:
                          BlocProvider.of<HomeCubit>(context).currentIndex,
                      count: homeModel.sliders!.length,
                      effect: ExpandingDotsEffect(
                        activeDotColor: primaryColor,
                        dotWidth: Responsive.isTablet(context) ? 5.sp : 8.5.sp,
                        dotHeight: Responsive.isTablet(context) ? 5.sp : 8.5.sp,
                      ),
                    ),
                  ],
                );
              },
            ),
          );
  }
}

class SliverAppBarSection extends StatelessWidget {
  const SliverAppBarSection({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      forceElevated: true,
      toolbarHeight: Responsive.isTablet(context) ? 85 : 65,
      flexibleSpace: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getWidth(context, 0.02), vertical: 10.sp),
        child: InkWell(
          onTap: () {},
          child: Container(
            height: Responsive.isTablet(context) ? 60 : 45,
            decoration: BoxDecoration(
              color: textFieldColor,
              borderRadius: getBorderRadiusFunc(7.5),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: getWidth(context, 0.075),
                ),
                SizedBox(
                  width: getWidth(context, 0.01),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      ' جستجو در',
                      style: TextStyle(fontSize: 16.sp, fontFamily: 'bold'),
                    ),
                    const Text(
                      '  پروکالا',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'bold',
                          color: primaryColor),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
