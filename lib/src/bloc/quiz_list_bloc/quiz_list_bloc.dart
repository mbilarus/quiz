import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/src/models.dart';
import 'package:quiz/src/clients.dart';

import './quiz_list_bloc_event.dart';
import './quiz_list_bloc_state.dart';

export './quiz_list_bloc_event.dart';
export './quiz_list_bloc_state.dart';

class QuizListBloc extends Bloc<QuizListEvent, QuizListState> {
  final QuizItemsClient quizItemsClient = QuizItemsClient();

  QuizListBloc() : super(const QuizListStateInitial()) {
    on<QuizListStarted>((event, emit) async {
      List<QuizItem> quizItems = await quizItemsClient.find(
        limit: 10,
        quizCategory: event.quizCategory,
        quizDifficulty: event.quizDifficulty,
      );

      emit(QuizListStateSuccess(
          quizItems: List.of(quizItems), selectedIndex: 0));
    });

    on<QuizListQuestionAnswered>((event, emit) async {
      final index = state.selectedIndex;

      QuizItem currentItem = state.quizItems[index];
      final answerIsTrue =
          currentItem.correctAnswers.values.toList()[event.answerIndex] ==
              "true";
      final itemWithAnswer = QuizItem(
        question: currentItem.question,
        answers: currentItem.answers,
        correctAnswers: currentItem.correctAnswers,
        isAnsweredTrue: answerIsTrue,
      );
      List<QuizItem> currentItems = state.quizItems;
      currentItems[index] = itemWithAnswer;
      emit(
        QuizListStateSuccess(
          quizItems: currentItems,
          selectedIndex: index + 1 < state.quizItems.length ? index + 1 : index,
        ),
      );
    });

    on<QuizListCleared>((event, emit) {
      emit(const QuizListStateSuccess(quizItems: [], selectedIndex: 0));
    });
  }
}
