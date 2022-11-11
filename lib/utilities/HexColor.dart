
import 'dart:ui';

import 'package:flutter/material.dart';

class HexColor extends Color{

  HexColor(String value) : super(getColorFromHex(value));

   static int getColorFromHex(String hexColor) {
     if(hexColor[0]!='#'){
       hexColor = '#ffffff';
     }
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

}

Text appBarTitle(String title, {Color? color, FontWeight? fontWeight}) {
  return Text(
    title,
    style: TextStyle(fontSize: 15, color: color ?? Colors.white, fontWeight: fontWeight ?? FontWeight.w600),
    textAlign: TextAlign.center,
  );
}