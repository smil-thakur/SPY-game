import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soch_ke_bataunga/controller/firebase_methods.dart';
import 'package:soch_ke_bataunga/controller/game_methods.dart';
import 'package:soch_ke_bataunga/models/constants.dart';
import 'package:soch_ke_bataunga/screens/game_session.dart';
import 'package:soch_ke_bataunga/screens/lobby_screen.dart';
import 'package:soch_ke_bataunga/widgets/container_text.dart';
import 'package:soch_ke_bataunga/widgets/my_button.dart';
import 'package:soch_ke_bataunga/widgets/text_input.dart';
import 'package:get/get.dart' as getx;

class CreateRoom extends StatefulWidget {
  const CreateRoom({super.key});

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  late int r, b, g;
  late String dpIni;
  TextEditingController namecontroller = TextEditingController();
  Random random = Random();

  void changeDpColor() {
    r = random.nextInt(256);
    b = random.nextInt(256);
    g = random.nextInt(256);
    dpIni = letters[random.nextInt(letters.length)];
    setState(() {});
  }

  var letters = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "W",
    "X",
    "Y",
    "Z"
  ];
  @override
  void initState() {
    r = random.nextInt(256);
    b = random.nextInt(256);
    g = random.nextInt(256);
    dpIni = letters[random.nextInt(letters.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.black,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, r, g, b),
                  radius: 80,
                  child: Center(
                    child: Text(
                      dpIni,
                      style: GoogleFonts.luckiestGuy(fontSize: 70),
                    ),
                  ),
                ),
                CartoonButton(function: changeDpColor, title: "change dp"),
                Column(
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ContainerText(
                            text:
                                "Enter A random name, this should be a made up name!")),
                    CartoonTextField(
                      hintText: "Enter Name",
                      controller: namecontroller,
                    ),
                  ],
                ),
                CartoonButton(
                    function: () async {
                      if (namecontroller.text.isNotEmpty) {
                        String code = GameMethods().generateRoomCode();
                        int res = await MyfirebaseMethods()
                            .createRoom(code, namecontroller.text);
                        if (res == 1) {
                          getx.Get.to(() => GameSession(code: code));
                        } else {
                          print("error");
                        }
                      }
                    },
                    title: "Create Room"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
