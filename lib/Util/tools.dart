import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToastInfo(String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

double getWidthSize(double p, BuildContext context){
  return MediaQuery.of(context).size.width * p;
}
double getHeightSize(double p, BuildContext context){
  return MediaQuery.of(context).size.height * p;
}

void navigateTo(BuildContext context, Widget screen){
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

double stringToDouble(String input) {
  try {
    return double.parse(input)/100;
  } catch (e) {
    if (kDebugMode) {
      print("Error: Unable to convert '$input' to double. Error: $e");
    }
    return 0.0; // or return a default value like 0.0 if preferred
  }
}

void navigateReplacement(BuildContext context, Widget screen){
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}