import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soch_ke_bataunga/models/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              Constants.backgroundImage,
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white.withOpacity(0.85),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Undercover",
                  style: GoogleFonts.luckiestGuy(fontSize: 30),
                ),
                const SizedBox(
                  height: 50,
                ),
                const SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
