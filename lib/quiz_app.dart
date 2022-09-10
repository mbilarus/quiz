import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/src/screens.dart';
import 'package:quiz/src/bloc.dart';

import 'quiz_theme.dart';

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizThemeData = QuizThemeData().materialTheme;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quiz App',
        theme: quizThemeData,
        home: MultiProvider(
          providers: [
            Provider<QuizListBloc>(
              create: (_) => QuizListBloc(),
            ),
            Provider<GameModeCubit>(
              create: (_) => GameModeCubit(),
            ),
          ],
            child: const QuizHomePage(),
        ));

  }
}
