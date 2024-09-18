import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const CustomButton({
    Key? key,
    required this.text,
    required this.color,
    required this.textColor,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor, backgroundColor: color, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height / 2), // Rounded corners
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
