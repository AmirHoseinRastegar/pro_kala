import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_kala/core/widgets/error_screen_widget.dart';
import 'package:pro_kala/features/feature_products_detail/peresentation/bloc/product_detail_bloc.dart';

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
              final helper=state.productDetailModel.product!;
              return SingleChildScrollView(
                child: Column(
                  children: [


                    Text(helper.enName!),
                    Text(helper.title!),
                    Text(helper.productBody!),
                  ],
                ),
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
            }
            else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
