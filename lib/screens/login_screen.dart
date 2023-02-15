import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soch_ke_bataunga/controller/google_sign.dart';
import 'package:soch_ke_bataunga/widgets/container_text.dart';
import 'package:soch_ke_bataunga/widgets/my_button.dart';

import '../models/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                const ContainerText(
                  text:
                      "Sign In with your google account.\nTo play with your friends",
                ),
                const SizedBox(
                  height: 50,
                ),
                CartoonButton(
                  function: () async {
                    await MySignin().myGoogleSignin();
                  },
                  title: "Google SignIn",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
