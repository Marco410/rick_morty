import 'package:flutter/material.dart';
import 'package:sizer_pro/sizer.dart';

class ColorStyle {
  static const primaryColor = Color(0xff3A71FB);
  static const blackColor = Color(0xff28292C);
  static const blackSecondaryColor = Color(0xff37393F);
  static const whiteBackground = Color(0xFFF4F5F7);
}

class TxtStyle {
  static final headerStyle = TextStyle(
      fontFamily: "Poppins",
      fontSize: 8.sp,
      fontWeight: FontWeight.w800,
      color: ColorStyle.whiteBackground,
      letterSpacing: 1.5);
  static final labelStyle = TextStyle(
      fontFamily: "Poppins",
      color: ColorStyle.whiteBackground,
      fontWeight: FontWeight.bold,
      fontSize: 5.sp);
}

class ShadowStyle {
  static BoxShadow generalShadow = BoxShadow(
    color: ColorStyle.primaryColor.withOpacity(0.4),
    blurRadius: 8,
    spreadRadius: 2,
    offset: Offset(0, 6),
  );

  static BoxShadow containerShadow = BoxShadow(
      color: ColorStyle.primaryColor.withOpacity(0.4),
      blurRadius: 4,
      spreadRadius: 0,
      offset: const Offset(0, 0));
}