import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class HelperMethod {
  //
  static Future<bool> checkExistDocID(
      String collectionPath, String docID) async {
    return await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(docID)
        .get()
        .then((value) {
      return value.exists;
    }).catchError((onError) {
      return false;
    });
  }

  static void showMotionToast(
    BuildContext context, {
    required bool isSuccess,
    String? title,
    required String description,
  }) {
    if (isSuccess) {
      MotionToast.success(
        title: Text(title ?? 'العملية تمت بنجاح'),
        description: Text(description),
        width: 300,
        layoutOrientation: ORIENTATION.rtl,
        animationType: ANIMATION.fromTop,
        position: MOTION_TOAST_POSITION.top,
        // toastDuration: const Duration(seconds: 3),
      ).show(context);
    } else {
      MotionToast.warning(
        title: Text(title ?? 'الرجاء التحقق'),
        description: Text(description),
        width: 300,
        layoutOrientation: ORIENTATION.rtl,
        animationType: ANIMATION.fromTop,
        position: MOTION_TOAST_POSITION.top,
        // toastDuration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  static void toPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return page;
      },
    ));
  }

  static Future<String> getSingleObject({
    required String collectionPath,
    required String docID,
    required String fieldID,
  }
      // String isEqualTo,
      ) async {
    var collection = FirebaseFirestore.instance.collection(collectionPath);
    var docSnapshot = await collection.doc(docID).get();
    //
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?[fieldID];
      debugPrint('va $value');
      return value;
    }
    //
    return '';
  }
}
