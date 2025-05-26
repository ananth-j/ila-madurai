import 'package:flutter/material.dart';

class TextFeildDubX extends StatelessWidget {
  final controller;
  final String hint;
  final keybord;
  const TextFeildDubX(
      {super.key,
      required this.controller,
      required this.hint,
      required this.keybord});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: TextField(
        cursorHeight: 20,
        style: TextStyle(),
        keyboardType: keybord,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          label: Text(hint),
          hintStyle: TextStyle(color: Color.fromARGB(234, 0, 0, 0)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide:
                BorderSide(width: 1.5, color: Color.fromARGB(255, 10, 67, 223)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(
                width: 1.5, color: Color.fromARGB(255, 137, 163, 211)),
          ),
        ),
      ),
    );
  }
}
