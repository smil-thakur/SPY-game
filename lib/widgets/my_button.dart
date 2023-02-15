import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartoonButton extends StatefulWidget {
  final Function() function;
  final String title;
  const CartoonButton({super.key, required this.function, required this.title});

  @override
  State<CartoonButton> createState() => _CartoonButtonState();
}

class _CartoonButtonState extends State<CartoonButton> {
  double x = -5.0;
  double y = 5.0;

  void ontap() async {
    x = 0;
    y = 0;
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 100));
    x = -5;
    y = 5;
    setState(() {});
    widget.function();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 2),
            boxShadow: [
              BoxShadow(
                offset: Offset(x, y),
                color: Colors.black,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.title,
              style: GoogleFonts.luckiestGuy(
                fontSize: 15,
              ),
            ),
          )),
    );
  }
}
