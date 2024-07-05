import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_kala/core/const/shape/border_radius.dart';
import 'package:pro_kala/core/const/shape/media_query.dart';
import 'package:pro_kala/features/feature_category/data_source/model/category_model.dart';
import 'package:pro_kala/features/feature_category/peresentation/bloc/category_bloc.dart';
import 'package:pro_kala/features/feature_category/repository/category_repository.dart';
import 'package:shimmer/shimmer.dart';

import '../../../feature_home/presentation/screen/home_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocProvider(
      create: (context) =>
          CategoryBloc(CategoryRepository())..add(CallCategoryEvent()),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        // buildWhen: (previous, current) {
        //   if (previous != current) {
        //     return true;
        //   }
        //   return false;
        // },
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const CategoryLoadingWidget();
          }
          if (state is CategorySuccess) {
            CategoryModel categoryModel = state.categoryModel;

            return CustomScrollView(
              slivers: [
                SliverAppBarSection(theme: theme),
                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      SizedBox(
                        width: getAllWidth(context),

                        ///this ' kBottomNavigationBarHeight MediaQuery.of(context).devicePixelRatio ' is for
                        /// decreasing bottom navigation bar height from main screen to prevent it from covering
                        /// main ui

                        height: getAllHeight(context) -
                            kBottomNavigationBarHeight *
                                MediaQuery.of(context).devicePixelRatio,
                        child: ListView.builder(
                            padding: const EdgeInsets.only(bottom: 30),
                            itemCount: categoryModel.category!.length,
                            itemBuilder: (context, index) {
                              final categoryHelper =
                                  categoryModel.category![index];
                              return CategoryItems(
                                categoryHelper: categoryHelper,
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ],
            );
          }
          if (state is CategoryError) {}

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class CategoryItems extends StatelessWidget {
  const CategoryItems({
    super.key,
    required this.categoryHelper,
  });

  final Category categoryHelper;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15.sp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.sp, vertical: 5.sp),
          child: Text(
            categoryHelper.title!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
          ),
        ),
        SizedBox(
          width: getAllWidth(context),
          height: getWidth(context, 0.45),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: categoryHelper.subCategory!.length,
            itemBuilder: (context, index) {
              final subCategoryHelper = categoryHelper.subCategory![index];

              return SubCategoryItems(subCategoryHelper: subCategoryHelper);
            },
          ),
        ),
      ],
    );
  }
}

class SubCategoryItems extends StatelessWidget {
  const SubCategoryItems({
    super.key,
    required this.subCategoryHelper,
  });

  final SubCategory subCategoryHelper;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(context, 0.3),
      height: getWidth(context, 0.375),
      margin: EdgeInsets.all(5.sp),
      padding: EdgeInsets.all(5.sp),
      decoration: BoxDecoration(
          borderRadius: getBorderRadiusFunc(12.sp),
          color: Colors.grey.shade300),
      child: Column(
        children: [
          subCategoryHelper.image == null
              ? Image.asset(
                  'assets/images/logo.png',
                  width: getWidth(context, 0.25),
                  height: getWidth(context, 0.3),
                )
              : ClipRRect(
                  borderRadius: getBorderRadiusFunc(15.sp),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/images/logo.png'),
                    image: NetworkImage(subCategoryHelper.image!),
                    width: getWidth(context, 0.25),
                    height: getWidth(context, 0.325),
                    imageErrorBuilder: (context, error, stackTrace) => SizedBox(
                      width: getWidth(context, 0.25),
                      height: getWidth(context, 0.325),
                    ),
                  ),
                ),
          Text(
            subCategoryHelper.title!,
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class CategoryLoadingWidget extends StatelessWidget {
  const CategoryLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Wrap(
            runSpacing: 15.sp,
            children: const [
              ShimmerWidget(),
              ShimmerWidget(),
              ShimmerWidget(),
              ShimmerWidget(),
              ShimmerWidget(),
              ShimmerWidget(),
              ShimmerWidget(),
              ShimmerWidget(),
              ShimmerWidget(),
              ShimmerWidget(),
              ShimmerWidget(),
              ShimmerWidget(),
            ],
          ),
        ));
  }
}

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.sp),
      width: getWidth(context, 0.285),
      height: getWidth(context, 0.4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: getBorderRadiusFunc(10),
      ),
    );
  }
}
