import 'package:dio/dio.dart';

import '../../feature_bottom_nav/data/models/api_model.dart';
import '../data_source/remote/api_provider.dart';

class CategoryRepository {
  final CategoryApiProvider categoryApiProvider = CategoryApiProvider();

  Future<dynamic> get() async {
    final Response response = await categoryApiProvider.callApi();
    final HomeModel homeModel = HomeModel.fromJson(response.data);
    return homeModel;
  }
}
