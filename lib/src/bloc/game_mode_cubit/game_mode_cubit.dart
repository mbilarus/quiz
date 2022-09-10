import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/src/enums.dart';

import './game_mode_cubit_state.dart';
export './game_mode_cubit_state.dart';
export './game_mode_cubit_state.dart';

class GameModeCubit extends Cubit<GameModeCubitState> {
  GameModeCubit()
      : super(
          GameModeCubitInitial(
            quizCategory: QuizCategory.linux,
            quizDifficulty: QuizDifficulty.easy,
          ),
        );

  void updateGameMode(
      {QuizCategory? quizCategory, QuizDifficulty? quizDifficulty}) {
    emit(
      GameModeCubitChanged(
        quizCategory: quizCategory ?? state.quizCategory,
        quizDifficulty: quizDifficulty ?? state.quizDifficulty,
      ),
    );
  }
}
