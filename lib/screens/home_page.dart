import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trivia/screens/question_page.dart';
import 'package:trivia/services/api.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 38, 0, 90),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(child: Lottie.asset("assets/money.json")),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/logo.png"),
                  const Text(
                    "MILLIONAIRE",
                    style: TextStyle(
                        shadows: [
                          Shadow(
                            blurRadius: 10.0, // shadow blur
                            color: Color.fromARGB(255, 0, 0, 0), // shadow color
                            offset: Offset(3.0, 3.0), // how much shadow will be shown
                          )
                        ],
                        fontSize: 40,
                        color: Color.fromARGB(255, 222, 222, 222),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomElevatedButton(
                      text: "Start",
                      onTap: () async {
                        EasyLoading.show();
                        final questions = await Api.getQuestions();
                        EasyLoading.dismiss();
                        Get.to(QuestionPage(
                          questions: questions,
                        ));
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
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
