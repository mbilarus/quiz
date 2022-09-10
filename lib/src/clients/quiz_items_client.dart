import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz/src/models.dart';
import 'package:quiz/src/enums.dart';

class QuizItemsClient {
  Future<List<QuizItem>> find(
      {int? limit,
        QuizCategory? quizCategory,
        QuizDifficulty? quizDifficulty}) async {
    final List<QuizItem> quizItems = json
        .decode((await http.get(
      Uri(
        scheme: 'https',
        host: 'quizapi.io',
        path: 'api/v1/questions',
        queryParameters: {
          'limit': '$limit',
          'category': quizCategory?.value,
          'difficulty': quizDifficulty?.value
        },
      ),
      headers: {
        'X-Api-Key': 'ELjnT6n7593qhuWLLaenyIcNQmJ5WWYF6xz7CHb8',
      },
    ))
        .body)
        .toList()
        .map<QuizItem>((json) => QuizItem.fromJson(json))
        .toList();
    return quizItems;
  }
}