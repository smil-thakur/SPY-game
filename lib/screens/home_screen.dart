import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soch_ke_bataunga/controller/firebase_methods.dart';
import 'package:soch_ke_bataunga/controller/game_methods.dart';
import 'package:soch_ke_bataunga/controller/google_sign.dart';
import 'package:soch_ke_bataunga/screens/create_room.dart';
import 'package:soch_ke_bataunga/screens/game_session.dart';
import 'package:soch_ke_bataunga/widgets/container_text.dart';
import 'package:soch_ke_bataunga/widgets/my_button.dart';
import 'package:soch_ke_bataunga/widgets/text_input.dart';
import 'package:get/get.dart' as getx;

import '../models/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//main screen for the app
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController codecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Welcome ${user.displayName}",
          style: GoogleFonts.inter(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              MySignin().myGoogleSignout();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          )
        ],
      ),
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
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 55,
                    foregroundImage: NetworkImage(user.photoURL!),
                  ),
                  Column(
                    children: [
                      const ContainerText(text: "Create New Room?"),
                      const SizedBox(height: 10),
                      CartoonButton(
                          function: () {
                            getx.Get.to(() => const CreateRoom());
                          },
                          title: "Create Room"),
                    ],
                  ),
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ContainerText(text: "join Room?"),
                      ),
                      CartoonTextField(
                          hintText: "Enter random name",
                          controller: namecontroller),
                      CartoonTextField(
                          hintText: "Enter Room Code",
                          controller: codecontroller),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CartoonButton(
                            function: () async {
                              var res = await MyfirebaseMethods().joinRoom(
                                  codecontroller.text, namecontroller.text);

                              if (res == 1) {
                                getx.Get.to(() =>
                                    GameSession(code: codecontroller.text));
                              }
                            },
                            title: "Join Room"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
