import 'package:equatable/equatable.dart';
import 'package:quiz/src/models.dart';

class QuizListState extends Equatable {
  final List<QuizItem> quizItems;
  final int selectedIndex;

  const QuizListState({required this.quizItems, required this.selectedIndex});

  @override
  List<Object?> get props => [quizItems, selectedIndex];
}

class QuizListStateInitial extends QuizListState {
  const QuizListStateInitial() : super(quizItems: const [], selectedIndex: 0);
}

class QuizListStateSuccess extends QuizListState {
  const QuizListStateSuccess(
  {required super.quizItems, required super.selectedIndex});
}