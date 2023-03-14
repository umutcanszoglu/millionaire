import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia/controllers/question_controller.dart';

class ShadowContainer extends StatelessWidget {
  const ShadowContainer(
      {super.key, required this.name, required this.photo, required this.isCorrect});
  final String name;
  final String photo;

  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuesitonController(null));
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        width: double.infinity,
        height: 70,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(
                  photo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(name),
            IconButton(
                onPressed: () => controller.callHim(isCorrect),
                icon: const Icon(
                  Icons.phone_forwarded,
                  size: 30,
                  color: Colors.green,
                ))
          ],
        ),
      ),
    );
  }
}
