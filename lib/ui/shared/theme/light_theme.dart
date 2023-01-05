import 'package:flutter/material.dart';

ThemeData get lightTheme => ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black));
