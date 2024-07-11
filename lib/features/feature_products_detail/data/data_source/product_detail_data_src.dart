import 'package:dio/dio.dart';
import 'package:pro_kala/core/const/constants/constants.dart';
import 'package:pro_kala/core/widgets/secure_storage_func.dart';

class ProductDetailDataSrc {
  final Dio _dio = Dio();

  Future<Response> callProductDetailApi(String id)async{
final token=await SecureStorageClass().getUserToken();
    final Response response= await _dio.get('$apiUrl/product/$id/$token');

return response;
  }
}
