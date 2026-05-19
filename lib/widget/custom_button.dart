import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.onPressed});
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width, 65),
          backgroundColor: Color(0xff696FDD),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),

        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 22)),
      ),
    );
  }
}
