import 'package:dio/dio.dart';
import 'package:pro_kala/features/feature_category/data_source/model/category_model.dart';

import '../../feature_bottom_nav/data/models/api_model.dart';
import '../data_source/remote/api_provider.dart';

class CategoryRepository {
  final CategoryApiProvider categoryApiProvider = CategoryApiProvider();

  Future<dynamic> get() async {
    final Response response = await categoryApiProvider.callApi();
    final CategoryModel categoryModel = CategoryModel.fromJson(response.data);
    return categoryModel;
  }
}
