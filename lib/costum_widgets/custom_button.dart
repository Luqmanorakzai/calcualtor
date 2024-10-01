import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final height;
  final width;
  final text;
  final fontSize;
  final isloading;
  final onPressed;
  const CustomButton(
      {super.key,
      this.height,
      this.width,
      this.text,
      this.fontSize,
      this.isloading = false,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.deepPurpleAccent,
        ),
        child: Center(
          child: isloading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  text ?? "",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500),
                ),
        ),
      ),
    );
  }
}
