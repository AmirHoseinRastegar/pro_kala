import 'package:dio/dio.dart';

import '../../../feature_bottom_nav/data/models/api_model.dart';
import '../../../feature_home/data/data_source/remote/api_provider.dart';

class HomeRepository {
  final ApiProvider apiProvider = ApiProvider();

  Future<dynamic> get() async {
    Response response = await apiProvider.get();
    final HomeModel homeModel = HomeModel.fromJson(response.data);
    return homeModel;
  }
}
