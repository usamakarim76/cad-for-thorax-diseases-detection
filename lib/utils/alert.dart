import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Alert{
  void showAlert(text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0);
  }
}