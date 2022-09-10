import '../../enums.dart';

class GameModeCubitState {
  QuizCategory? quizCategory;
  QuizDifficulty? quizDifficulty;
  GameModeCubitState(this.quizCategory, this.quizDifficulty);
}

class GameModeCubitInitial extends GameModeCubitState {
  GameModeCubitInitial({QuizCategory? quizCategory, QuizDifficulty? quizDifficulty})
      : super(quizCategory, quizDifficulty);
}

class GameModeCubitChanged extends GameModeCubitState {
  GameModeCubitChanged({QuizCategory? quizCategory, QuizDifficulty? quizDifficulty})
      : super(quizCategory, quizDifficulty);
}
