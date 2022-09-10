import 'package:flutter/material.dart';

class QuizThemeData {
  ThemeData get materialTheme {
    return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.resolveWith<Size?>(
            (_) => const Size.fromHeight(45),
          ),
          textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
            (_) => const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.focused) ||
                  states.contains(MaterialState.pressed)) {
                return Colors.indigoAccent.withOpacity(0.18);
              }
              return Colors.indigoAccent; // Defer to the widget's default.
            },
          ),
        ),
      ),
      primarySwatch: Colors.indigo,
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        bodyText1: TextStyle(fontSize: 18.0),
        bodyText2: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
