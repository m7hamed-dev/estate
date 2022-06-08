import 'dart:math';
import 'package:estate_app/APIs/helper_method.dart';
import 'package:estate_app/main.dart';
import 'package:estate_app/widgets/btn.dart';
import 'package:estate_app/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/txt.dart';

class AddEstateView extends StatefulWidget {
  const AddEstateView({Key? key}) : super(key: key);
  @override
  State<AddEstateView> createState() => _AddEstateViewState();
}

class _AddEstateViewState extends State<AddEstateView> {
  final db = FirebaseFirestore.instance;

  final _name = TextEditingController();
  final _size = TextEditingController();
  final _amount = TextEditingController();
  final _rooms = TextEditingController();
  final _bathRoom = TextEditingController();
  final _kitchen = TextEditingController();
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Txt('اضافة عقار'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: [
              ///
              Input(
                controller: _name,
                hintText: 'اسم المنطقه',
              ),
              Input(
                controller: _size,
                hintText: 'مساحة العقار',
                isNumberKeyBoard: true,
              ),
              Input(
                controller: _amount,
                hintText: 'سعر العقار',
                isNumberKeyBoard: true,
              ),
              const Txt('العدد', fontSize: 17.0),

              ///
              Row(
                children: [
                  Expanded(
                    child: Input(
                      controller: _rooms,
                      hintText: 'الغرف',
                      isNumberKeyBoard: true,
                    ),
                  ),
                  Expanded(
                    child: Input(
                      controller: _bathRoom,
                      hintText: 'الحمامات',
                      isNumberKeyBoard: true,
                    ),
                  ),
                  Expanded(
                    child: Input(
                      controller: _kitchen,
                      hintText: 'المطبخ',
                      isNumberKeyBoard: true,
                    ),
                  ),
                ],
              ),

              ///
              Btn(
                onPressed: () async {
                  final isExist = await HelperMethod.checkExistDocID(
                      'estate_collection', _name.text);

                  if (!isExist) {
                    Map<String, dynamic> _map = {
                      'name': _name.text,
                      'rooms': _rooms.text,
                      'bath_room': _bathRoom.text,
                      'kitchen': _kitchen.text,
                      'size': '${_size.text} ${Random().nextInt(10)}',
                      'price': '${_amount.text}  ${Random().nextInt(1000)}',
                      'img_path': imagesEstate[
                          Random().nextInt(imagesEstate.length - 1)]
                    };
                    db
                        .collection('estate_collection')
                        .doc(_name.text.trim())
                        .set(_map)
                        .then((value) {
                      HelperMethod.showMotionToast(
                        context,
                        isSuccess: true,
                        title: 'الاضافة تمت بنجاح',
                        description: 'تمت اضافة عقار جديد',
                      );
                    });
                  } else {
                    HelperMethod.showMotionToast(
                      context,
                      isSuccess: false,
                      title: 'الاضافة لم تمت بنجاح',
                      description: 'تاكد من اسم العقار',
                    );
                  }
                },
                title: "اضافة عقار",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
