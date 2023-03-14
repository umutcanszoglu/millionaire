import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trivia/controllers/question_controller.dart';

class PhoneContainer extends StatelessWidget {
  const PhoneContainer({super.key, required this.isCorrect});

  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuesitonController(null));
    final availableAnswers =
        controller.currentAnswers.where((p0) => !controller.deactivatedQuestions.contains(p0));

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 241, 241, 241),
          borderRadius: BorderRadius.circular(26),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 120, 120, 120),
              blurRadius: 4,
              offset: Offset(4, 8), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Lottie.asset("assets/think.json", width: 200, height: 200),
              const SizedBox(height: 30),
              Text(isCorrect
                  ? "Answer: ${controller.questions[controller.questionCounter.value].correctAnswer}"
                  : "Answer: ${availableAnswers.elementAt(Random().nextInt(availableAnswers.length))}"),
            ],
          ),
        ),
      ),
    );
  }
}
