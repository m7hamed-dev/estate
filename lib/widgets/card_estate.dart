import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate_app/views/details_estate_view.dart';
import 'package:flutter/material.dart';
import 'custom_img.dart';
import 'txt.dart';

class CardEstate extends StatelessWidget {
  //
  const CardEstate({Key? key, required this.data}) : super(key: key);
  final QueryDocumentSnapshot<Object?> data;
  //
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => DetailsEstate(data: data),
          ),
        );
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
            CustomImg(
              height: 70.0,
              imageUrl: data.get('img_path'),
            ),
            Txt(
              data.get('name'),
              fontSize: 17.0,
            ),
            Txt(
              data.get('size') + ' مساحة ',
            ),
            Txt(
              '${data.get('price')} SDG',
            ),
          ],
        ),
      ),
    );
  }
}
