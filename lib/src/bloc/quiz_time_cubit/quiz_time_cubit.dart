import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/src/enums.dart';


class QuizTimeCubit extends Cubit<QuizTimeCubitState> {
  QuizTimeCubit()
      : super(
    QuizTimeCubitInitial(
      start: DateTime.now(),
    ),
  );

  int getQuizPassageTime(DateTime end) {
    emit(QuizTimeCubitTimeSaved(start: state.start, end: end));
    return end.difference(state.start).inSeconds;
  }
}

class QuizTimeCubitState {
  DateTime start;
  DateTime? end;
  QuizTimeCubitState({required this.start, this.end});
}

class QuizTimeCubitInitial extends QuizTimeCubitState {
  QuizTimeCubitInitial({required DateTime start, DateTime? end}): super(start:start,end:end);
}

class QuizTimeCubitTimeSaved extends QuizTimeCubitState {
  QuizTimeCubitTimeSaved({required DateTime start, DateTime? end}): super(start:start,end:end);
}