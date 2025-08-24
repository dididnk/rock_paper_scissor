import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String choice;
  final String image;
  final Color color;
  final Function()? onTap;

  const CustomButton({
    super.key,
    required this.choice,
    required this.image,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Image.asset(image, height: 40, width: 40),
      ),
    );
  }
}
