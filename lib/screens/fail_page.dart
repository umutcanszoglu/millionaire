import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../models/question.dart';

class FailPage extends StatelessWidget {
  const FailPage({super.key, required this.question, required this.datamap});
  final Question question;
  final Map<String, double> datamap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 38, 0, 90),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Lottie.asset("assets/over.json"),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 300,
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
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "You Failed!",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Difficulty: ${question.difficulty}",
                          style: const TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Category: ${question.category}",
                          style: const TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Correct Answer: ${question.correctAnswer}",
                          style: const TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: CustomElevatedButton(
                            text: "Try Again",
                            onTap: () {
                              Get.back();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
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
