import 'package:quiz/src/enums.dart';

class QuizListEvent {}

class QuizListStarted extends QuizListEvent {
  QuizCategory? quizCategory;
  QuizDifficulty? quizDifficulty;

  QuizListStarted({required this.quizCategory, required this.quizDifficulty});
}

class QuizListQuestionAnswered extends QuizListEvent {
  final int answerIndex;
  QuizListQuestionAnswered({required this.answerIndex});
}

class QuizListCleared extends QuizListEvent {}