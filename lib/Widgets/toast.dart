import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastsClass {
  static void regularToast(String text) {
    Fluttertoast.showToast(
        backgroundColor: Colors.grey[600],
        textColor: Colors.white,
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }
}
