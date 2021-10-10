import 'package:flutter/material.dart';

ButtonStyle buttonStyle(Color color) => ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only(left: 5)),
    backgroundColor: MaterialStateProperty.all<Color>(color),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))));

RoundedRectangleBorder roundedCardTopOnly = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)));

RoundedRectangleBorder roundedCard =
    RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)));
