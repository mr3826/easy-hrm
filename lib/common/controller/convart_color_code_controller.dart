import 'package:flutter/animation.dart';

class HexColor extends Color {
  static int _getColor( hex) {
    dynamic formattedHex =  "FF${hex.toUpperCase().replaceAll("#", "")}";
    return int.parse(formattedHex, radix: 16);
  }
  HexColor(final  hex) : super(_getColor(hex));
}

