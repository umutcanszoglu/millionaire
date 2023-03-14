import 'package:flutter/material.dart';

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
