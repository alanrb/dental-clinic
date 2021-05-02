import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Styles {
  static ThemeData primaryTheme(BuildContext context) {
    return ThemeData(
        buttonTheme: Theme.of(context)
            .buttonTheme
            .copyWith(highlightColor: Colors.greenAccent),
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        visualDensity: VisualDensity.adaptivePlatformDensity);
  }

  static const TextStyle appointmentFormTitle = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 0.8),
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle searchText = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 1),
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle productRowItemPrice = TextStyle(
    color: Color(0xFF8E8E93),
    fontSize: 13,
    fontWeight: FontWeight.w300,
  );

  static const EdgeInsets space = EdgeInsets.all(8);

  static const EdgeInsets space_m = EdgeInsets.all(16);

  static const EdgeInsets space_l = EdgeInsets.all(24);

  static const Color color_primary = Colors.green;

  static const Color rowDivider = Color(0xFFD9D9D9);

  static const Color scaffoldBackground = Color(0xfff0f0f0);

  static const Color searchBackground = Color(0xffe0e0e0);

  static const Color cursorColor = Colors.green;

  static const Color searchIconColor = Color.fromRGBO(128, 128, 128, 1);
}
