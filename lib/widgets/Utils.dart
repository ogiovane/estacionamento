import 'package:flutter/material.dart';

class Utils{
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text, {backgroundColorReceived = Colors.red}){
    if(text == null) return;
    // Color notificationColor = receivedColor;

    final snackBar = SnackBar(content: Text(text), backgroundColor: backgroundColorReceived,);

    messengerKey.currentState!
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
  }
 }