import 'package:dio/dio.dart';
import 'package:pro_kala/core/const/constants/constants.dart';

class AuthDataSrc {
  final Dio _dio = Dio();

  Future<Response> callAuthApi(String phoneNumber) async {
    final response = await _dio.post('$apiUrl/login', queryParameters: {
      'mobile': phoneNumber,
    });
    return response;
  }
}
