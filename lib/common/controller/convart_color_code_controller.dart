import 'package:flutter/material.dart';
import 'package:payrun_mobile/utils/app_color.dart';

class HexColor extends Color {
  HexColor(final String hex) : super(_getColor(hex));

  static int _getColor(String hex) {
    if (hex.isEmpty && hex == "null") return int.parse("FF8F99AD", radix: 16);
    String formattedHex = "FF${hex.toUpperCase().replaceAll("#", "")}";
    return int.parse(formattedHex, radix: 16);
  }
}
