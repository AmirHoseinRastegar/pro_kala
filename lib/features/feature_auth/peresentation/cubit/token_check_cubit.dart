import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/widgets/secure_storage_func.dart';

part 'token_check_state.dart';

class TokenCheckCubit extends Cubit<TokenCheckState> {
  TokenCheckCubit() : super(TokenCheckInitial());

 checkToken() async {
    final status = await SecureStorageClass().getUserToken();
    if(status != null){
      emit(TokenIsLoggedIn());
      print('true');
    }else{
      emit(TokenIsNotLoggedIn());
      print('false');
    }

  }
}
