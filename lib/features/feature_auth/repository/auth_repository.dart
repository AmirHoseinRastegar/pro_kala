import 'package:dio/dio.dart';
import 'package:pro_kala/features/feature_auth/data_source/auth_data_source.dart';

class AuthRepository {
  final AuthDataSrc authDataSrc = AuthDataSrc();

  Future<String> fetchAuthApi(String phoneNumber) async {
    final Response response = await authDataSrc.callAuthApi(phoneNumber);
    final String token = response.data['token'];
    return token;
  }
}
