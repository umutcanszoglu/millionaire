import 'dart:convert';

import 'package:html_character_entities/html_character_entities.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Question {
  final String category;
  final String type;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  Question({
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  List<String> answers() {
    final result = <String>[];
    result.addAll(incorrectAnswers);
    result.add(correctAnswer);
    result.shuffle();
    return result;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'type': type,
      'difficulty': difficulty,
      'question': question,
      'correctAnswer': correctAnswer,
      'incorrectAnswer': incorrectAnswers,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      category: map['category'] as String,
      type: map['type'] as String,
      difficulty: map['difficulty'] as String,
      question: HtmlCharacterEntities.decode(map['question'] as String),
      correctAnswer: HtmlCharacterEntities.decode(map['correct_answer'] as String),
      incorrectAnswers: List<String>.from(
        (map['incorrect_answers'] as List<dynamic>),
      ).map((e) => HtmlCharacterEntities.decode(e)).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Question(category: $category, type: $type, difficulty: $difficulty, question: $question, correctAnswer: $correctAnswer, incorrectAnswers: $incorrectAnswers)';
  }
}
