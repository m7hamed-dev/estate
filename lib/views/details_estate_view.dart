import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate_app/APIs/helper_method.dart';
import 'package:estate_app/widgets/btn.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_img.dart';
import '../widgets/txt.dart';

class DetailsEstate extends StatelessWidget {
  //
  const DetailsEstate({Key? key, required this.data}) : super(key: key);
  final QueryDocumentSnapshot<Object?> data;
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          data.get('name'),
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.fade,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomImg(
              height: 120,
              imageUrl: data.get('img_path'),
            ),
            // name
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Txt(
                data.get('name'),
                fontSize: 15.0,
              ),
            ), // name
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Txt(
                data.get('size') + ' مساحة',
                fontSize: 15.0,
              ),
            ),
            // price
            Txt(
              'SDG ${data.get('price')} ',
              fontSize: 40.0,
            ),
            const Txt(
              'العدد',
              fontSize: 40.0,
            ),

            _detailsEstate(),
          ],
        ),
      ),
      floatingActionButton: Btn(
        title: 'طلب العقار',
        onPressed: () {
          final _db = FirebaseFirestore.instance;
          // final _categoryNameController = TextEditingController();
          Map<String, dynamic> _map = <String, dynamic>{
            // 'order_id': data.get('id'),
            'name': data.get('name'),
            'price': data.get('price'),
            'size': data.get('size'),
            'img_path': data.get('img_path'),
          };

          _db.collection('order_collectionPath').add(_map).then((value) {
            HelperMethod.showMotionToast(
              context,
              isSuccess: true,
              description: 'سيتم مراجعة طلبك',
            );
          });
        },
      ),
    );
  }

  Padding _detailsEstate() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Txt(
            data.get('rooms') + ' الغرف ',
            fontSize: 15.0,
          ),
          Txt(
            data.get('bath_room') + ' الحمامات  ',
            fontSize: 15.0,
          ),
          Txt(
            data.get('kitchen') + '  المطبخ  ',
            fontSize: 15.0,
          ),
        ].map((e) {
          return Card(
            elevation: 10.0,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: e,
            ),
          );
        }).toList(),
      ),
    );
  }
}
