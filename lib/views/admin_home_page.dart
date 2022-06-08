import 'package:estate_app/views/add_estate_view.dart';
import 'package:estate_app/views/estate_view.dart';
import 'package:estate_app/views/manage_user_view.dart';
import 'package:estate_app/widgets/txt.dart';
import 'package:flutter/material.dart';

import 'confirm_order_view.dart';

class Item {
  final String title;
  final Widget page;
  final IconData iconData;
  const Item(this.title, this.page, this.iconData);
}

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final _items = <Item>[
    const Item(
      'اضافة عقار',
      AddEstateView(),
      Icons.add,
    ),
    Item(
      'ادارة عقار',
      Scaffold(
        appBar: AppBar(
          title: const Txt(
            'ادارة عقار',
          ),
        ),
        body: const Estateview(),
      ),
      Icons.add,
    ),
    //
    const Item(
      'الطلبات',
      ConfirmOrderView(),
      Icons.category,
    ),
    //
    const Item(
      'ادارة المستخذمين',
      ManageUserView(),
      Icons.supervised_user_circle_rounded,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Txt('admin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 10.0,
          ),
          itemCount: _items.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return _items[index].page;
                  },
                ));
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.green.shade100,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _items[index].iconData,
                      size: 50.0,
                    ),
                    const SizedBox(height: 20),
                    Txt(_items[index].title),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
