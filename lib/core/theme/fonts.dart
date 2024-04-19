import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'colors.dart';

TextStyle get textWhiteStyle => GoogleFonts.lato(
      color: whiteColor,
      fontWeight: FontWeight.normal,
      fontSize: Adaptive.sp(15),
    );

TextStyle textStyleInput(Color color) => GoogleFonts.lato(
      color: color,
      fontWeight: FontWeight.w500,
      fontSize: Adaptive.sp(17),
    );

TextStyle get textWhiteStyleSubtitle => GoogleFonts.lato(
      color: whiteColor,
      fontWeight: FontWeight.normal,
      fontSize: Adaptive.sp(17),
    );

TextStyle get textWhiteStyleTitle => GoogleFonts.lato(
      color: whiteColor,
      fontWeight: FontWeight.normal,
      fontSize: Adaptive.sp(21),
    );

TextStyle get textWhiteStyleTimer => GoogleFonts.lato(
      color: whiteColor,
      fontWeight: FontWeight.bold,
      fontSize: Adaptive.sp(40),
    );


TextStyle get textBlackStyle => GoogleFonts.lato(
      color: blackColor,
      fontWeight: FontWeight.normal,
      fontSize: Adaptive.sp(17),
    );

TextStyle get textBlackStyleTitle => GoogleFonts.lato(
      color: blackColor,
      fontWeight: FontWeight.bold,
      fontSize: Adaptive.sp(28),
    );

TextStyle get textBlackStyleSmall => GoogleFonts.lato(
      color: blackColor,
      fontWeight: FontWeight.normal,
      fontSize: Adaptive.sp(15),
    );

TextStyle get textWhiteStyleButton => GoogleFonts.lato(
      color: whiteColor,
      fontWeight: FontWeight.w600,
      fontSize: Adaptive.sp(17),
    );