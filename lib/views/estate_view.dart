import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate_app/widgets/card_estate.dart';
import 'package:flutter/material.dart';

class Estateview extends StatefulWidget {
  const Estateview({Key? key}) : super(key: key);

  @override
  State<Estateview> createState() => _EstateviewState();
}

class _EstateviewState extends State<Estateview> {
  //
  final db = FirebaseFirestore.instance;
  //
  Stream<QuerySnapshot> _getEstateData() {
    final _data = db.collection("estate_collection").snapshots();
    debugPrint('data from resource ${_data.length}');
    return _data;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _getEstateData(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //
        if (snapshot.data == null) {
          return const Center(child: Text('no data'));
        }
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final _data = snapshot.data!.docs;
        //
        return GridView.builder(
          itemCount: _data.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          // shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            // ui
            return CardEstate(data: _data[index]);
          },
        );
      },
    );
  }
}
