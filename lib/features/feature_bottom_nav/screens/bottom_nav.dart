import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/const/theme/colors.dart';
import '../../feature_category/peresentation/screens/category_screen.dart';
import '../../feature_home/presentation/bloc/home_bloc.dart';
import '../../feature_home/presentation/screen/home_screen.dart';
import '../bloc/bottomnav_cubit.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  static const String bottomNavBarId = '/bottom_nav';

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {

    super.initState();
    BlocProvider.of<HomeBloc>(context).add(CallApiEvent());

  }
  List<Widget> screens = [
    const HomeScreen(),
    const CategoryScreen(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: primaryColor,
                unselectedItemColor: Theme
                    .of(context)
                    .iconTheme
                    .color,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      label: 'خانه',
                      activeIcon: Icon(Icons.home)),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.category_outlined),
                    label: 'دسته بندیها',
                    activeIcon: Icon(Icons.category),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    label: 'سبد خرید',
                    activeIcon: Icon(Icons.shopping_cart),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'پروفایل',
                    activeIcon: Icon(Icons.person),
                  ),
                ],
                currentIndex: BlocProvider
                    .of<BottomNavCubit>(context)
                    .screenIndex,
          
                onTap: (value) {
          BlocProvider.of<BottomNavCubit>(context).changeBottomNav(value);
          },
          ),
          body: screens
              .elementAt(BlocProvider.of<BottomNavCubit>(context).screenIndex),
          ),
        );
      },
    );
  }
}
