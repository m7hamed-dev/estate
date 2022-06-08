import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate_app/widgets/btn.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_img.dart';
import '../widgets/txt.dart';

class ConfirmOrderView extends StatefulWidget {
  const ConfirmOrderView({Key? key}) : super(key: key);

  @override
  State<ConfirmOrderView> createState() => _ConfirmOrderViewState();
}

class _ConfirmOrderViewState extends State<ConfirmOrderView> {
  //
  final db = FirebaseFirestore.instance;
  //
  Stream<QuerySnapshot> _getEstateData() {
    final _data = db.collection("order_collectionPath").snapshots();
    debugPrint('data from resource ${_data.length}');
    return _data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Txt('مراجعة الطلبات')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _getEstateData(),
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
              bool _orderStatus = data[index].get('order_status');
              // ui
              return InkWell(
                // onTap: () {
                //   // Navigator.push(
                //   //   context,
                //   //   MaterialPageRoute<void>(
                //   //     builder: (BuildContext context) =>
                //   //         DetailsEstate(data: data),
                //   //   ),
                //   // );
                // },
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
                      CustomImg(
                        height: 90.0,
                        imageUrl: data[index].get('img_path'),
                      ),
                      Txt(
                        data[index].get('name'),
                        fontSize: 17.0,
                      ),
                      Txt(
                        data[index].get('size') + ' مساحة ',
                      ),
                      Txt(
                        '${data[index].get('price')} SDG',
                      ),
                      Txt(
                        _orderStatus ? 'accepted' : 'pendding',
                        color: _orderStatus ? Colors.green : Colors.red,
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          Expanded(
                            child: Btn(
                              title: 'accepted',
                              color: Colors.green,
                              onPressed: () {
                                const id = 'a5PSmajFkteAitoEYhxc';

                                final _body = {
                                  'name': data[index].get('name'),
                                  'size': data[index].get('size'),
                                  'price': data[index].get('price'),
                                  'order_status': true,
                                  // 'img_path': imagesEstate[0]
                                };
                                _hundlerFunc(id, _body);
                              },
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Btn(
                              title: 'rejecte',
                              color: Colors.red,
                              onPressed: () {
                                const id = 'a5PSmajFkteAitoEYhxc';

                                final _body = {
                                  'name': data[index].get('name'),
                                  'size': data[index].get('size'),
                                  'price': data[index].get('price'),
                                  'order_status': false,
                                  // 'img_path': imagesEstate[0]
                                };
                                _hundlerFunc(id, _body);
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

  void _hundlerFunc(id, data) async {
    await db
        .collection('order_collectionPath')
        .doc(id)
        .update(data)
        .then((value) {});
  }
}
