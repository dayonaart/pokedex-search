import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension BCOLOR on String {
  Color get color {
    switch (this) {
      case "green":
        return Colors.green;
        break;
      case "orange":
        return Colors.orange;
        break;
      case "blue":
        return Colors.blue;
        break;
      case "red":
        return Colors.red;
        break;
      case "yellow":
        return Colors.yellow;
        break;
      case "pink":
        return Colors.pink;
        break;
      case "black":
        return Colors.black;
        break;
      case "purple":
        return Colors.purple;
        break;
      case "brown":
        return Colors.brown;
        break;
      case "gray":
        return Colors.grey;
        break;
      default:
        return Colors.tealAccent;
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

extension ACCENTCOLOR on String {
  Color get color {
    switch (this) {
      case "green":
        return Colors.greenAccent[200];
        break;
      case "orange":
        return Colors.orangeAccent[100];
        break;
      case "blue":
        return Colors.blueAccent[100];
        break;
      case "red":
        return Colors.redAccent[100];
        break;
      case "yellow":
        return Colors.yellow[800];
        break;
      case "pink":
        return Colors.pinkAccent[100];
        break;
      case "black":
        return Colors.grey[500];
        break;
      case "purple":
        return Colors.purpleAccent[100];
        break;
      case "brown":
        return Colors.brown[100];
        break;
      case "gray":
        return Colors.grey[300];
        break;
      default:
        return Colors.tealAccent;
    }
  }
}
