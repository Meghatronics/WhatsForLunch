import 'package:flutter/material.dart';

export 'package:google_fonts/google_fonts.dart';

const logoAsset = AssetImage('assets/images/logo_white.png');

//* COLORS
const themePrimaryColor = Color(0xFFFF5959);
const themeTextHeaderColor = Color(0xFF092C4C);
const themeTextBodyColor = Color(0xFF969696);
const themeTextGrey = Color(0xFFC7C6C6);
const themeGreen = Color(0xFF01B820);
//?
const backgroundWhite = Color(0xFFF7F8FA);
const backgroundBlack = Color(0xFF4A4A4A);
const errorRed = Color(0xFFE04F5F);
const successGreen = Color(0xFF3BB54A);
const inactiveGrey = Color(0xFFEEEEEE);
const textBlack = Color(0xFF333333);
const textWhite = Color(0xFFFFFFFF);

//* TEXTSTYLES
const hintTextStyle = TextStyle(
  color: themeTextGrey,
  fontSize: 14,
);

const inputTextStyle = TextStyle(
  color: themeTextHeaderColor,
  fontSize: 14,
);

//* DECORATION
const inputFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
  isDense: true,
  filled: true,
  fillColor: backgroundWhite,
  focusColor: backgroundWhite,
  hintStyle: hintTextStyle,
  labelStyle: hintTextStyle,
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(
        color: themePrimaryColor,
      )),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide.none,
  ),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(
        color: errorRed,
        width: 0.5,
      )),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(
      color: Color(0xFFC4C4C4),
      width: 1,
    ),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(
      color: Color(0xFFC4C4C4),
      width: 1,
    ),
  ),
);

