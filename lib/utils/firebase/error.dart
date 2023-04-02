import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toastMessage(String message) {
  Fluttertoast.showToast(msg: message.toString(),
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.SNACKBAR,
  timeInSecForIosWeb: 1,
  backgroundColor: Colors.grey,
  textColor: Colors.black,
  fontSize: 16,

  );
}
