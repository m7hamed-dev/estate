import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate_app/widgets/btn.dart';
import 'package:flutter/material.dart';

import '../widgets/txt.dart';

class ManageUserView extends StatefulWidget {
  const ManageUserView({Key? key}) : super(key: key);

  @override
  State<ManageUserView> createState() => _ManageUserViewState();
}

class _ManageUserViewState extends State<ManageUserView> {
  //
  final db = FirebaseFirestore.instance;
  //
  Stream<QuerySnapshot> _getData() {
    final _data = db.collection("user_collection").snapshots();
    debugPrint('data from resource ${_data.length}');
    return _data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Txt('ادارة المستخدمين')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _getData(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //
          if (snapshot.data == null) {
            return const Center(child: Text('no data'));
          }
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final data = snapshot.data!.docs;
          //

          // for (var i = 0; i < data.length; i++) {
          //   return Center(child: Text(data[i].get('order_status').toString()));
          // }

          return ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final _permissionType = data[index].get('permission');
              // ui
              return InkWell(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // CustomImg(
                      //   height: 90.0,
                      //   imageUrl: data[index].get('img_path'),
                      // ),
                      Txt(
                        data[index].get('full_name'),
                        fontSize: 17.0,
                      ),
                      Txt(data[index].get('phone')),
                      const SizedBox(height: 20.0),
                      Txt(_permissionType),
                      const SizedBox(height: 20.0),
                      Btn(
                        title: _permissionType == 'user'
                            ? 'change to admin'
                            : 'change to user',
                        color: Colors.green.shade100,
                        onPressed: () async {
                          final id = data[index].get('phone');
                          _changePermission(id, _permissionType, data[index]);
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Btn(
                              title: 'تعديل',
                              color: Colors.green,
                              onPressed: () async {
                                _hundlerFunc('id');
                              },
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Btn(
                              title: 'حذف',
                              color: Colors.red,
                              onPressed: () {
                                final id = data[index].get('phone');
                                _hundlerFunc(id);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _hundlerFunc(String id) async {
    await db.collection('user_collection').doc(id).delete().then((value) {});
  }

  void _changePermission(
      String id, String _permissionType, QueryDocumentSnapshot data) async {
    final _newDaya = <String, dynamic>{
      'phone': data.get('phone'),
      'full_name': data.get('full_name'),
      'password': data.get('password'),
      'permission': _permissionType == 'user' ? 'admin' : 'user',
    };
    await db
        .collection('user_collection')
        .doc(id)
        .update(_newDaya)
        .then((value) {});
  }
}
