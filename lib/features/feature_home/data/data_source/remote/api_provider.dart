import 'package:dio/dio.dart';

import '../../../../../core/const/constants/constants.dart';

class ApiProvider {

  final Dio _dio = Dio();

  Future<Response> get() async {


    try {

      final response = await _dio.get('$apiUrl/index');
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}