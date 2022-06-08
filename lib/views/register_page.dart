import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate_app/views/home_view.dart';
import 'package:flutter/material.dart';

import '../widgets/btn.dart';
import '../widgets/input.dart';
import '../widgets/txt.dart';
import 'admin_home_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static final _phone = TextEditingController();
  static final _fullName = TextEditingController();
  static final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Container(
              height: 100.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/user_image.png'),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Input(
              hintText: 'full name',
              controller: _fullName,
            ),
            Input(
              hintText: 'phone',
              controller: _phone,
              isNumberKeyBoard: true,
            ),
            Input(
              hintText: 'password',
              controller: _password,
              isPassword: true,
            ),
            InkWell(
              child: const Txt('login'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 20.0),
            Btn(
              title: 'Register now',
              onPressed: () {
                final db = FirebaseFirestore.instance;
                //
                final _map = <String, dynamic>{
                  'phone': _phone.text,
                  'full_name': _fullName.text,
                  'password': _password.text,
                  'permission': 'admin',
                  // 'permission': 'user',
                };
                db
                    .collection('user_collection')
                    .doc(_phone.text + _password.text)
                    .set(_map)
                    .then((value) {
                  if (_map['permission'] == 'admin') {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const AdminHomePage();
                      },
                    ));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const HomeView();
                      },
                    ));
                  }
                }).catchError((onError) {
                  debugPrint('onError $onError');
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
