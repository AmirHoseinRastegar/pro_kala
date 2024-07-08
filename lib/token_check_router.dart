import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_kala/features/feature_auth/peresentation/cubit/token_check_cubit.dart';
import 'package:pro_kala/features/feature_auth/screens/auth_screen.dart';
import 'package:pro_kala/features/feature_cart/screen/cart_screen.dart';

class CheckCartScreen extends StatelessWidget {
  const CheckCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokenCheckCubit,TokenCheckState>(builder:

     (context, state) {
       if(state is TokenIsLoggedIn){
         return const CartScreen();
       }else{
         return const AuthScreen();
       }
     },

    );
  }
}
