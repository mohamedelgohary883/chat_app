import 'package:chat_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';

class ScreenItem extends StatefulWidget {
  const ScreenItem({
    super.key,
    required this.text,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.screenText,
  });
  final String text;
  final Function(String) onEmailChanged;
  final Function(String) onPasswordChanged;
  final String screenText;
  @override
  State<ScreenItem> createState() => _ScreenItemState();
}

class _ScreenItemState extends State<ScreenItem> {
  String? email, password;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Image.asset('assets/background.png'),
            Positioned(
              top: 260,
              left: 170,
              child: Text(
                widget.screenText,
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight(700),
                ),
              ),
            ),
            Positioned(left: 30, child: Image.asset('assets/light-1.png')),
            Positioned(left: 170, child: Image.asset('assets/light-2.png')),
            Positioned(
              right: 30,
              top: 100,
              child: Image.asset('assets/clock.png'),
            ),
          ],
        ),
        SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: BoxBorder.all(color: Colors.grey.shade300),
            ),
            child: Column(
              children: [
                CustomTextField(
                  onChanged: widget.onEmailChanged,
                  hintText: 'Email or phone Number',
                  icon: Icons.email,
                  validator: (value) {
                    email = value;
                    if ((value?.isEmpty ?? true)) {
                      return 'field is required';
                    }
                    if (!(value?.contains('@') ?? true)) {
                      return 'this field must contain @';
                    }
                    return null;
                  },
                ),
                Divider(indent: 10, endIndent: 10, thickness: 0.5),
                CustomTextField(
                  onChanged: widget.onPasswordChanged,
                  hintText: 'Password',
                  icon: Icons.password,
                  validator: (value) {
                    password = value;
                    if (value?.isEmpty ?? true) {
                      return 'field is required';
                    } else if (value!.length < 8) {
                      return 'password must at least 8 charcte';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
