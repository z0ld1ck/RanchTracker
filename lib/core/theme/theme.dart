// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final ThemeData APP_THEME = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  primaryColor: Color(0xFF006CFF),
  primaryColorLight: Color(0xffF1F8EC),
  iconTheme: IconThemeData(color: Colors.black),
  textTheme: TextTheme(
    labelLarge: TextStyle(color: Colors.black),
    labelMedium: TextStyle(color: Colors.black),
    labelSmall: TextStyle(color: Colors.black),
    titleLarge: TextStyle(color: Colors.black),
    titleMedium: TextStyle(color: Colors.black),
    titleSmall: TextStyle(color: Colors.black),
    bodySmall: TextStyle(color: Colors.black),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
    filled: true,
    fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: Color(0xffE0E2D8)),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: Color(0xffE0E2D8)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: Color(0xFF006CFF)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: Colors.red),
    ),
    labelStyle: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      // fontSize: ScreenUtil().setSp(32), // 14 by figma
      fontSize: 14,
      color: Colors.black,
      letterSpacing: -0.1,
    ),
    //AppTextStyles.paragraphSmall(context).copyWith(color: Colors.grayMedium),
    hintStyle: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      // fontSize: ScreenUtil().setSp(32), // 14 by figma
      fontSize: 14,
      color: Color(0xff878882),
      letterSpacing: -0.1,
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Color(0xFF006CFF),
    selectionColor: Color(0xFF006CFF).withOpacity(0.35),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    circularTrackColor: Colors.transparent,
    color: Color(0xFF006CFF),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF006CFF),
  ),
  appBarTheme: AppBarTheme(
    color: Colors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      // fontSize: ScreenUtil().setSp(38), // 16 by figma
      fontSize: 16,
      color: Colors.black,
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.black,
    ),
    iconTheme: const IconThemeData(color: Colors.black),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(Color(0xFF006CFF)),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      return Color(0xFFE0E2D8);
    }),
  ),
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    dividerColor: Colors.transparent,
  ),
  scrollbarTheme: ScrollbarThemeData(thumbVisibility: MaterialStateProperty.all(true), thickness: MaterialStateProperty.all(10), thumbColor: MaterialStateProperty.all(Color(0xFF006CFF)), radius: const Radius.circular(10), minThumbLength: 100),
  colorScheme: ColorScheme.light().copyWith(primary: Color(0xFF006CFF)).copyWith(background: Color(0xffF7F7F6)),
);
