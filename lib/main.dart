import 'package:estate_app/APIs/helper_method.dart';
import 'package:estate_app/views/admin_home_page.dart';
import 'package:estate_app/views/home_view.dart';
import 'package:estate_app/views/splash_screen.dart';
import 'package:estate_app/widgets/btn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    return MaterialApp(
      title: 'تطبيق عقار',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey.shade100,
        appBarTheme: const AppBarTheme(elevation: 0.0, centerTitle: true),
      ),
      // be comment
      // home: const ConfirmOrderView(),
      // home: const RegisterPage(),
      // home: const LoginPage(),
      // home: const AddEstateView(),
      home: const SplashScreen(),
      // home: const AddEstateView(),
    );
  }
}

class SelectView extends StatelessWidget {
  const SelectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //
          Btn(
            title: 'user',
            onPressed: () {
              HelperMethod.toPage(context, const HomeView());
            },
          ),
          Btn(
            title: 'admin',
            onPressed: () {
              HelperMethod.toPage(context, const AdminHomePage());
            },
          ),
        ],
      ),
    );
  }
}

final imagesEstate = <String>[
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXnGnYZMb2sJhJ1tlcUsA6VRfZM3NtdKMeig&usqp=CAU',
  'https://images.unsplash.com/photo-1582268611958-ebfd161ef9cf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGVzdGF0ZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
  'https://media.istockphoto.com/photos/triangular-modern-lake-house-picture-id1296723838?b=1&k=20&m=1296723838&s=170667a&w=0&h=ypMLh0bMVdTYbeaYwUe6HhLVsxEmtHkz42zlAJWWBsU=',
  'https://images.unsplash.com/photo-1464146072230-91cabc968266?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fGVzdGF0ZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
  'https://images.unsplash.com/photo-1512915922686-57c11dde9b6b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTl8fGVzdGF0ZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
];
