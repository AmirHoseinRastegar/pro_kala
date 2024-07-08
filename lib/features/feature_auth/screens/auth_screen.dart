import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_kala/features/feature_auth/peresentation/cubit/token_check_cubit.dart';

import '../../../core/const/responsive/responsive.dart';
import '../../../core/const/shape/media_query.dart';
import '../../../core/const/theme/colors.dart';
import '../../../core/widgets/secure_storage_func.dart';
import '../../../core/widgets/snakbar.dart';
import '../../feature_bottom_nav/screens/bottom_nav.dart';
import '../peresentation/bloc/auth_bloc.dart';
import '../repository/auth_repository.dart';
import '../widgets/text_form_feild.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const String screenId = '/auth_screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _phoneEditingController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();

    _phoneEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: WaveClipperTwo(),
          child: Container(
            height: 180.sp,
            color: primaryColor,
          ),
        ),
        BlocProvider(
          create: (context) => AuthBloc(AuthRepository()),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                getSnackBarWidget(
                    context, state.errorMessage.errorMsg!, Colors.red);
              }
              if (state is AuthSuccess) {
                SecureStorageClass().saveUserToken(state.token);
                Navigator.pushNamedAndRemoveUntil(
                    context, BottomNavBar.bottomNavBarId, (route) => false);
                getSnackBarWidget(context, 'با موفقیت وارد شدید', Colors.green);
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(
                    child: CircularProgressIndicator(color: primaryColor));
              }

              return Center(
                child: Form(
                  key: _globalKey,
                  child: Padding(
                    padding: EdgeInsets.all(15.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: getWidth(context, 0.18),
                        ),
                        SizedBox(height: 15.sp),
                        const Text(
                          'برای احراز هویت شماره موبایل را وارد کنید',
                          style: TextStyle(fontFamily: 'normal'),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10.sp),
                        TextFormFieldMobileWidget(
                          labelText: 'شماره موبایل',
                          icon: const Icon(Icons.phone_android_outlined),
                          textInputAction: TextInputAction.done,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          controller: _phoneEditingController,
                        ),
                        SizedBox(height: 25.sp),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                              getWidth(context, 0.6),
                              Responsive.isTablet(context) ? 60 : 45,
                            ),
                          ),
                          onPressed: () {
                            if (_globalKey.currentState!.validate()) {
                              BlocProvider.of<AuthBloc>(context).add(
                                  CallAuthEvent(_phoneEditingController.text));
                            }
                          },
                          child: const Text(
                            'احراز هویت',
                            style: TextStyle(fontFamily: 'bold'),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
