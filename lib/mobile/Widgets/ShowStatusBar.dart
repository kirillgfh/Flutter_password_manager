import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showErrorBar(BuildContext context, String errorMessage, [var color = Colors.red, var k = 0.11]) {
  k ?? 0.11;
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*k),
    messageText: Container(child: Center(child: Text(errorMessage, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)),),
    // leftBarIndicatorColor: Colors.blue[300],
    duration: Duration(seconds: 3),
    backgroundColor: color ?? Colors.red,
  ).show(context);
}
