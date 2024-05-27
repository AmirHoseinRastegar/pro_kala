import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/const/shape/media_query.dart';

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({super.key});
  static const String unknownScreenId = '/unknown_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/dontknow.png',width: getWidth(context, 0.5),),
            SizedBox(height: 10.sp,),
            Text('صفحه مورد نظر یافت نشد!!',style: TextStyle(
              fontWeight: FontWeight.normal,
              fontFamily: 'normal',
              fontSize: 18.sp,
              color: const Color(0xff000000),


            ),),
          ],
        ),
      ),
    );
  }
}
