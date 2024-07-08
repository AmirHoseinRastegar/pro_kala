import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageClass {

  Future<String?> getUserToken () async {
    final  token = await const FlutterSecureStorage().read(key: 'token');
    return token;

  }


  Future<void> saveUserToken (String token) async {
    await const FlutterSecureStorage().write(key: 'token',value:token );

  }


  Future<void> deleteUserToken () async {
   await const FlutterSecureStorage().delete(key: 'token');


  }
}