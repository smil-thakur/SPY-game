import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartoonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  const CartoonTextField({super.key, required this.hintText, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 155,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 2),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.luckiestGuy(fontSize: 12),
          ),
          maxLines: 1,
        ));
  }
}
