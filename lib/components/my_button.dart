import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final void Function()? onTap;
  final String text;

  const MyButton({Key? key, this.onTap, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.brown[600],
          borderRadius: BorderRadius.circular(1000)
        ),
        child: Center(
          child: Text(text,
          style: const  TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 14
          ),) ,
        ),
      ),

    );
  }
}
