import 'package:flutter/material.dart';

import '../features/feature_bottom_nav/screens/bottom_nav.dart';

class Main extends StatelessWidget {
  const Main({super.key});
static const String  mainId='main_id';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const Scaffold(
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
