import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  MyTextField({Key? key, required this.controller, required this.hintText, required this.obscureText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style:  TextStyle(
        color: Colors.brown[700]
      ),
      // with controller, we can access what is inside
      controller: controller,

      // if we want to hide the characters, for example for password
      obscureText: obscureText,

      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          )
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
        ),
        fillColor: Colors.brown[100],
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.brown[300],
        )
      ),
    );
  }
}
