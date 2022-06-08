import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/txt.dart';

class MyOrderView extends StatefulWidget {
  const MyOrderView({Key? key}) : super(key: key);

  @override
  State<MyOrderView> createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView> {
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
      appBar: AppBar(title: const Txt('طلباتي')),
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
          return ListView.separated(
            itemCount: data.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              bool _orderStatus = data[index].get('order_status');
              // ui
              return InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute<void>(
                  //     builder: (BuildContext context) =>
                  //         DetailsEstate(data: data),
                  //   ),
                  // );
                },
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
                        fontSize: 20.0,
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey.shade200,
              thickness: 4.0,
            ),
          );
        },
      ),
    );
  }
}
