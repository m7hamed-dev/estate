import 'package:estate_app/views/register_page.dart';
import 'package:flutter/material.dart';

import '../APIs/helper_method.dart';
import '../widgets/btn.dart';
import '../widgets/input.dart';
import '../widgets/txt.dart';
import 'admin_home_page.dart';
import 'home_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  static final _phone = TextEditingController();
  static final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Txt('تسجيل الدخول')),
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
              hintText: 'phone',
              controller: _phone,
            ),
            Input(
              hintText: 'password',
              controller: _password,
              isPassword: true,
            ),
            InkWell(
              child: const Txt('register'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const RegisterPage();
                  },
                ));
                // Get.to(() => const RegisterPage());
              },
            ),
            const SizedBox(height: 20.0),
            Btn(
              title: 'login',
              onPressed: () async {
                //
                bool _isSuccess = await HelperMethod.checkExistDocID(
                  'user_collection',
                  _phone.text + _password.text,
                );
                //
                if (_isSuccess) {
                  // عرض الرساله
                  HelperMethod.showMotionToast(
                    context,
                    isSuccess: true,
                    description: 'login success !!',
                  );
                  // جلب نوع المستخدم
                  final _permission = await HelperMethod.getSingleObject(
                    collectionPath: 'user_collection',
                    docID: _phone.text + _password.text,
                    fieldID: 'permission',
                  );
                  // عرض الصفحه بناء علي نوع المستخدم
                  final _page = _permission == 'user'
                      ? const AdminHomePage()
                      : const HomeView();
                  // الانتقال الي الصفحه
                  HelperMethod.toPage(context, _page);
                  //
                } else {
                  HelperMethod.showMotionToast(
                    context,
                    isSuccess: false,
                    description: 'login Error !!',
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
