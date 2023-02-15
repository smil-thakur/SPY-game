import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContainerText extends StatelessWidget {
  final String text;
  const ContainerText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: GoogleFonts.luckiestGuy(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
