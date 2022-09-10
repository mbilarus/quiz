import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz/src/models.dart';
import 'package:quiz/src/enums.dart';

class QuizStatisticsClient {
  void create(
      {required List<QuizItem> quizItems,
        required QuizCategory? category,
        required QuizDifficulty? difficulty,
      required int passageTime}) {
    final date = DateTime.now().toUtc();
    final quizStatisticsCollection =
    FirebaseFirestore.instance.collection('quiz_statistics');
    final rightAnswersCount =
        quizItems.where((item) => item.isAnsweredTrue).length;
    final incorrectAnswersCount = quizItems.length - rightAnswersCount;
    quizStatisticsCollection.add({
      'datetime': date,
      'category': category?.value,
      'difficulty': difficulty?.value,
      'right_answered': rightAnswersCount,
      'incorrect_answered': incorrectAnswersCount,
      'passage_time': passageTime,
    });
  }
}