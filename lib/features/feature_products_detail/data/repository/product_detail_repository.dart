import 'package:dio/dio.dart';
import 'package:pro_kala/features/feature_products_detail/data/data_source/product_detail_data_src.dart';

import '../model/product_detail_model.dart';

class ProductDetailRepository {
    ProductDetailDataSrc productDetailDataSrc = ProductDetailDataSrc();

  Future<ProductDetailModel> fetchProductDetailRepository(String id) async {
    Response response = await productDetailDataSrc.callProductDetailApi(id);
   final ProductDetailModel productDetailModel =
        ProductDetailModel.fromJson(response.data);
   print(response.data['product']['title']);

    return productDetailModel;
  }
}
