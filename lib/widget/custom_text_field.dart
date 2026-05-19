import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.validator,
    this.onChanged,
  });
  final String hintText;
  final IconData icon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          border: UnderlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.blueGrey.shade300, fontSize: 18),
        ),
      ),
    );
  }
}
