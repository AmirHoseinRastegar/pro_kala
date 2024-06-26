import 'package:dio/dio.dart';
import 'package:pro_kala/core/const/constants/constants.dart';

class CategoryApiProvider {
  final _dio = Dio();

  Future<Response>  callApi() async {
    try {
      final response = await _dio.get('$apiUrl/get-menu-category');
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
