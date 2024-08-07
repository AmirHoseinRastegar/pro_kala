import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_kala/core/const/shape/media_query.dart';
import 'package:pro_kala/core/const/theme/colors.dart';
import 'package:pro_kala/core/widgets/error_screen_widget.dart';
import 'package:pro_kala/features/feature_products_detail/peresentation/bloc/product_detail_bloc.dart';

import '../../../core/widgets/price_number_seperator.dart';
import '../data/repository/product_detail_repository.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  static const String screenId = 'product_detail';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(arguments['product_id']);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: BlocProvider<ProductDetailBloc>(
        create: (context) => ProductDetailBloc(ProductDetailRepository())
          ..add(CallProductDetailEvent(arguments['product_id'].toString())),
        child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            if (state is ProductDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProductDetailSuccess) {
              final helper = state.productDetailModel;
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.sp, vertical: 10.sp),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 300,
                                  height: 300,
                                  child: ListView.builder(
                                    itemCount:
                                        BlocProvider.of<ProductDetailBloc>(
                                                context)
                                            .newGallery
                                            .length,
                                    itemBuilder: (context, index) =>
                                        Image.network(
                                      BlocProvider.of<ProductDetailBloc>(
                                              context)
                                          .newGallery[index],
                                    ),
                                  ),
                                ),
                                Text(
                                  helper.product!.title!,
                                  style: TextStyle(
                                      fontSize: 18.sp, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 2.5.sp,
                                ),
                                Text(
                                  helper.product!.enName!,
                                  style: TextStyle(
                                      fontSize: 16.sp, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 7.5.sp,
                                ),
                                ExpandableText(
                                  helper.product!.productBody!,
                                  expandText: 'بیشتر',
                                  collapseText: 'بستن',
                                  maxLines: 4,
                                  style: TextStyle(
                                      fontFamily: 'normal', fontSize: 14.sp),
                                  linkColor: primaryColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('data'),
                          ),
                          helper.percent == '0' || helper.totalPrice == 0
                              ? Text(
                                  getNumberFormat(
                                    helper.product!.defaultPrice,
                                  ),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                )
                              : Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.red,
                                      child: Text(
                                        '${helper.percent}%',
                                        style: TextStyle(
                                            fontFamily: 'bold',
                                            fontSize: 14.sp,
                                            color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: getWidth(context, 0.02),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          getNumberFormat(
                                            helper.totalPrice.toString(),
                                          ),
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                        Text(
                                          getNumberFormat(
                                            helper.product!.defaultPrice,
                                          ),
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 14.sp,
                                            color:
                                                Colors.black.withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state is ProductDetailError) {
              return ErrorScreenWidget(
                  errorMsg: state.errorMsg,
                  function: () {
                    BlocProvider.of<ProductDetailBloc>(context).add(
                      CallProductDetailEvent(
                        arguments['product_id'].toString(),
                      ),
                    );
                  });
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
