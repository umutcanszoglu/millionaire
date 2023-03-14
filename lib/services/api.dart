import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trivia/models/question.dart';

class Api {
  static Dio get dioAuth => Dio(
        BaseOptions(
          baseUrl: "https://opentdb.com",
          headers: {"Accept": "application/json", "Content-Type": "application/json"},
        ),
      );

  static Future<List<Question>?> getQuestion(String type, String difficulty, int amount) async {
    try {
      Response response = await dioAuth.get('/api.php',
          queryParameters: {"type": type, "difficulty": difficulty, "amount": amount});

      if (response.statusCode == 200) {
        List<dynamic> items = response.data["results"];
        return items.map((e) => Question.fromMap(e)).toList();
      }
      return null;
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  static Future<List<Question>> getQuestions() async {
    final questions = <Question>[];
    final results = await Future.wait([
      Api.getQuestion("multiple", "easy", 4),
      Api.getQuestion("multiple", "medium", 4),
      Api.getQuestion("multiple", "hard", 4),
    ]);
    questions.addAll(results[0] ?? []);
    questions.addAll(results[1] ?? []);
    questions.addAll(results[2] ?? []);
    return questions;
  }
}
