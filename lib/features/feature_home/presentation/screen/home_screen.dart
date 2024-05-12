import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_kala/core/widgets/price_number_seperator.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/const/responsive/responsive.dart';
import '../../../../core/const/shape/border_radius.dart';
import '../../../../core/const/shape/media_query.dart';
import '../../../../core/const/theme/colors.dart';
import '../../../../core/widgets/error_screen_widget.dart';
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
                    SizedBox(
                      height: 17.sp,
                    ),
                    BrandsSection(homeModel: homeModel, theme: theme),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Container(
                      width: getAllWidth(context),
                      height: getWidth(context, 0.65),
                      color: primaryColor,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              width: getWidth(context, 0.25),
                              margin: EdgeInsets.symmetric(
                                  horizontal: getWidth(context, 0.02)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'پیشنهادات ویژه',
                                    style: TextStyle(
                                        color: theme.scaffoldBackgroundColor,
                                        fontFamily: 'bold',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp),
                                  ),
                                  FadeInImage(
                                    placeholder: const AssetImage(
                                        'assets/images/logo.png'),
                                    image: const AssetImage(
                                      'assets/images/amazing/amazing_box.png',
                                    ),
                                    width: getWidth(context, 0.25),
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getWidth(context, 0.02)),
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: homeModel.amazing!.length,
                              itemBuilder: (context, index) {
                                final helper = homeModel.amazing![index];
                                return AmazingItems(
                                  theme: theme,
                                  helper: helper,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is HomeError) {
                return ErrorScreenWidget(
                  errorMsg: state.exceptionMessage.errorMsg.toString(),
                  function: () {
                    BlocProvider.of<HomeBloc>(context).add(CallApiEvent());
                  },
                );
              }
              return const SizedBox.shrink();
            }),
          ]))
        ],
      ),
    );
  }
}

class AmazingItems extends StatelessWidget {
  const AmazingItems({super.key, required this.theme, required this.helper});

  final ThemeData theme;
  final Amazing helper;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getWidth(context, 0.01)),
      margin: EdgeInsets.all(getWidth(context, 0.01)),
      width: getWidth(context, 0.375),
      decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: getBorderRadiusFunc(7)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Center(
            child: Padding(
              padding:  EdgeInsets.all(6.sp),
              child: ClipRRect(
                borderRadius: getBorderRadiusFunc(10),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/images/logo.png'),
                  image: NetworkImage(helper.image!),
                  width: getWidth(context, 0.275),
                  height: getWidth(context, 0.275),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              helper.title!,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
              maxLines: 2,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 17.sp,
                  backgroundColor: primaryColor,
                  child: Text(
                    '%${helper.percent!}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'bold',
                        fontSize: 13.sp),
                  ),
                ),
                SizedBox(
                  width: getWidth(context, 0.02),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getNumberFormat(helper.defaultPrice!),
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'normal',
                          fontSize: 12.sp,
                          decoration: TextDecoration.lineThrough),
                    ),
                    Text(
                      getNumberFormat(helper.percentPrice.toString()),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'bold',
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
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
      margin: EdgeInsets.symmetric(horizontal: getWidth(context, 0.04)),
      width: getAllWidth(context),
      child: GridView.builder(
        itemCount: homeModel.brands!.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10, crossAxisSpacing: 55, crossAxisCount: 4),
        itemBuilder: (context, index) {
          return Container(
            decoration: ShapeDecoration(
                color: theme.scaffoldBackgroundColor,
                shape: ContinuousRectangleBorder(
                  borderRadius: getBorderRadiusFunc(40),
                ),
                shadows: [
                  BoxShadow(
                      color: theme.shadowColor.withOpacity(0.7),
                      spreadRadius: -12,
                      blurRadius: 10,
                      offset: const Offset(0.1, 10))
                ]),
            child: Container(
              margin: EdgeInsets.all(8),
              child: FadeInImage(
                placeholder: const AssetImage('assets/images/logo.png'),
                image: NetworkImage(homeModel.brands![index].image!),
              ),
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
