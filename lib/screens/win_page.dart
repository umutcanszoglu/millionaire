import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trivia/screens/home_page.dart';

class WinPage extends StatelessWidget {
  const WinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 38, 0, 90),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Lottie.asset("assets/fireworks.json"),
                Lottie.asset("assets/congrats.json"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomElevatedButton(
                  text: "Go To Start Page",
                  onTap: Get.back,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
