import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
Flushbar notifSuccess (String msg){
    return Flushbar(
      message: msg,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      isDismissible: true,
      icon: const Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.white,
      ),
      leftBarIndicatorColor: Colors.green,
    );
}

Flushbar notifError (String msg){
    return Flushbar(
      message: msg,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      isDismissible: true,
      icon: const Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.white,
      ),
      leftBarIndicatorColor: Colors.red,
    );
}