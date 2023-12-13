import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class HexColor extends Color {
//   static int _getColor( hex) {
//     String formattedHex =  "FF${hex.toUpperCase().replaceAll("#", "")}";
//     return int.parse(formattedHex, radix: 16);
//   }
//   HexColor(final  hex) : super(_getColor(hex));
// }



class ColorController extends GetxController {
  // Define your color variable with Rx type
  Rx<Color> hexColor = HexColor("#00FF00").obs;

  // Method to update the color
  void updateColor(String newHexColor) {
    hexColor.value = HexColor(newHexColor);
  }
}

class HexColor extends Color {
  static int _getColor(String hex) {
    String formattedHex = "FF${hex.toUpperCase().replaceAll("#", "")}";
    return int.parse(formattedHex, radix: 16);
  }

  HexColor(final String hex) : super(_getColor(hex));
}
