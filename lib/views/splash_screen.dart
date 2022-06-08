import 'dart:async';
import 'package:estate_app/widgets/txt.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // function no1
  @override
  void initState() {
    super.initState();
    const delay = Duration(seconds: 3);
    Future.delayed(delay, () => onTimerFinished());
  }

  // function no2
  void onTimerFinished() {
    // تستخذم للتنقل بين الواجهات او الشاشات
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (BuildContext context) {
        return const SelectView();
        // return const HomeView();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.primaryColor,
      body: splashScreenIcon(context),
    );
  }
}

Widget splashScreenIcon(BuildContext context) {
  String iconPath = 'assets/images/main_logo.jpeg';
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
        child: Image.asset(
          iconPath,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 3,
        ),
      ),
      const Txt('تطبيق عقارك', fontSize: 30.0)
    ],
  );
}
