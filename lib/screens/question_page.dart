import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia/const/const.dart';
import 'package:trivia/controllers/question_controller.dart';
import 'package:trivia/models/question.dart';
import 'package:trivia/screens/fail_page.dart';
import 'package:trivia/screens/win_page.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({super.key, required this.questions});

  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuesitonController(questions));
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 38, 0, 90),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(() => UpperThingsWidget(
                        text: controller.priceText.value,
                      )),
                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    height: 230,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 204, 204, 204),
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 33, 8, 54),
                          blurRadius: 4,
                          offset: Offset(4, 8), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Obx(() => CustomTextWidget(
                        txt: controller
                            .questions[controller.questionCounter.value > 11
                                ? 11
                                : controller.questionCounter.value]
                            .question)),
                  ),
                  const SizedBox(height: 30),
                  Obx(() => Column(
                        children: [
                          ...controller.currentAnswers.asMap().entries.map((e) => OptionsWidget(
                                deactivated: controller.deactivatedQuestions.contains(e.value),
                                option: e.value,
                                onTap: () {
                                  if (e.value ==
                                      controller.questions[controller.questionCounter.value]
                                          .correctAnswer) {
                                    controller.questionCounter.value += 1;

                                    if (controller.questionCounter.value == 12) {
                                      Get.off(const WinPage());
                                    } else {
                                      controller.priceText.value =
                                          Prices.moneys[controller.questionCounter.value];
                                    }
                                  } else {
                                    Get.delete<QuesitonController>();
                                    Get.off(FailPage(
                                      question:
                                          controller.questions[controller.questionCounter.value],
                                      datamap: controller.getRates(),
                                    ));
                                  }
                                },
                              ))
                        ],
                      )),
                  const Divider(
                    thickness: 2,
                    color: Color.fromARGB(255, 235, 235, 235),
                  ),
                  const SizedBox(height: 10),
                  Obx(() => JokerWidget(
                        isUsed: controller.isUsed.value,
                        isUsed2: controller.isUsed2.value,
                        isUsed3: controller.isUsed3.value,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    super.key,
    required this.txt,
  });
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          txt,
          style: const TextStyle(color: Colors.black, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class UpperThingsWidget extends StatelessWidget {
  const UpperThingsWidget({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 204, 204, 204),
              borderRadius: BorderRadius.circular(16)),
          child: Text(
            text,
            style: const TextStyle(
                shadows: [
                  Shadow(
                    blurRadius: 10.0, // shadow blur
                    color: Color.fromARGB(255, 0, 0, 0), // shadow color
                    offset: Offset(3.0, 3.0), // how much shadow will be shown
                  )
                ],
                fontSize: 40,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class JokerWidget extends StatelessWidget {
  const JokerWidget({
    super.key,
    required this.isUsed,
    required this.isUsed2,
    required this.isUsed3,
  });
  final bool isUsed;
  final bool isUsed2;
  final bool isUsed3;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuesitonController>();
    final random = Random();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: isUsed == false ? controller.audienceJoker : null,
          icon: isUsed == false
              ? const Icon(
                  Icons.people_alt,
                  color: Color.fromARGB(255, 235, 235, 235),
                  size: 40,
                )
              : const Icon(
                  Icons.person_off_rounded,
                  color: Color.fromARGB(255, 235, 235, 235),
                  size: 40,
                ),
        ),
        IconButton(
          onPressed: isUsed2 == false ? controller.telephoneJoker : null,
          icon: isUsed2 == false
              ? const Icon(
                  Icons.phone_enabled,
                  color: Color.fromARGB(255, 235, 235, 235),
                  size: 40,
                )
              : const Icon(
                  Icons.phone_disabled,
                  color: Color.fromARGB(255, 235, 235, 235),
                  size: 40,
                ),
        ),
        IconButton(
          onPressed: isUsed3 == false
              ? () async {
                  while (controller.deactivatedQuestions.length < 2) {
                    final randomAnswer = controller.questions[controller.questionCounter.value]
                        .incorrectAnswers[random.nextInt(3)];

                    if (!controller.deactivatedQuestions.contains(randomAnswer)) {
                      controller.deactivatedQuestions.add(randomAnswer);
                    }
                  }
                  controller.isUsed3.value = true;
                }
              : null,
          icon: isUsed3 == false
              ? const Icon(
                  Icons.looks_two_outlined,
                  color: Color.fromARGB(255, 235, 235, 235),
                  size: 40,
                )
              : const Icon(
                  Icons.cancel_outlined,
                  color: Color.fromARGB(255, 235, 235, 235),
                  size: 40,
                ),
        ),
      ],
    );
  }
}

class OptionsWidget extends StatelessWidget {
  const OptionsWidget({
    super.key,
    required this.option,
    required this.deactivated,
    required this.onTap,
  });
  final String option;
  final bool deactivated;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: deactivated ? null : onTap,
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: deactivated
                ? const Color.fromARGB(255, 255, 0, 0)
                : const Color.fromARGB(255, 204, 204, 204),
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16)),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 33, 8, 54),
                blurRadius: 4,
                offset: Offset(4, 8), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: Text(
              option,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
            backgroundColor: const Color.fromARGB(255, 110, 22, 188)),
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
