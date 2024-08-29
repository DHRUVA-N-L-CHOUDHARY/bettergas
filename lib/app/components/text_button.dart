import 'package:flutter/material.dart';
class CustomTextButton extends StatelessWidget {
  final String imagePath;
  final String buttonText;
  final VoidCallback onPressed;

  const CustomTextButton({
    Key? key,
    required this.imagePath,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(320, 50),
        backgroundColor: Colors.transparent,
        side: BorderSide(color: Colors.black), 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), 
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, 
        children: [
          Image.asset(
            imagePath,
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 8),
          Text(
            buttonText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
