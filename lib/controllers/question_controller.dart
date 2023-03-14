import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:trivia/const/const.dart';
import 'package:trivia/models/question.dart';
import 'package:trivia/screens/question_page.dart';
import 'package:trivia/widgets/shadow_container.dart';

import '../widgets/phone_container.dart';

class QuesitonController extends GetxController {
  final questions = <Question>[].obs;

  final deactivatedQuestions = <String>[].obs;
  final currentAnswers = <String>[].obs;

  final questionCounter = 0.obs;

  final priceText = Prices.moneys[0].obs;

  final rnd = Random();

  final isUsed = false.obs;
  final isUsed2 = false.obs;
  final isUsed3 = false.obs;

  final isSelected = true.obs;

  List<Question>? questions2;

  QuesitonController(this.questions2) {
    questions.value = questions2 ?? [];
  }
  Map<String, double> getRates() {
    final result = <String, double>{};
    final answers = currentAnswers;
    for (int i = 0; i < answers.length; i++) {
      final option = answers[i];
      if (deactivatedQuestions.contains(option)) continue;

      if (questions[questionCounter.value].correctAnswer == option) {
        result[option] = (rnd.nextInt(60) + 40).toDouble();
      } else {
        result[option] = (rnd.nextInt(50)).toDouble();
      }
    }
    return result;
  }

  @override
  void onInit() {
    currentAnswers.value = questions[questionCounter.value].answers();

    ever(questionCounter, (_) {
      if (questionCounter.value > 11) return;
      deactivatedQuestions.clear();
      currentAnswers.value = questions[questionCounter.value].answers();
    });
    super.onInit();
  }

  void audienceJoker() {
    Get.dialog(AlertDialog(
      title: const Text(
        "Audience Answers",
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
          width: Get.width,
          height: Get.height / 2,
          child: PieChart(
            dataMap: getRates(),
            legendOptions: const LegendOptions(legendPosition: LegendPosition.bottom),
          )),
      actions: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomElevatedButton(
                text: "Go Back",
                onTap: () => Get.back(),
              ),
            ),
          ),
        )
      ],
    ));
    //isUsed.value = true;
  }

  void callHim(bool isCorrect) {
    Get.back();
    Get.dialog(AlertDialog(
      title: const Text(
        "Answer",
        textAlign: TextAlign.center,
      ),
      content: PhoneContainer(isCorrect: isCorrect),
      actions: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomElevatedButton(
                text: "Go Back",
                onTap: () => Get.back(),
              ),
            ),
          ),
        )
      ],
    ));
  }

  void telephoneJoker() {
    final rndIdx = rnd.nextInt(3);

    Get.dialog(
      AlertDialog(
        title: const Text(
          "Telephone Joker",
          textAlign: TextAlign.center,
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...PhoneJoker.jokers.asMap().entries.map((e) => ShadowContainer(
                    name: e.value.name,
                    photo: e.value.photo,
                    isCorrect: e.key != rndIdx,
                  ))
            ],
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomElevatedButton(
                  text: "Go Back",
                  onTap: () => Get.back(),
                ),
              ),
            ),
          )
        ],
      ),
    );
    isUsed2.value = true;
  }
}
