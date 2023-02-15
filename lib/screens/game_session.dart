import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soch_ke_bataunga/screens/create_room.dart';
import 'package:soch_ke_bataunga/screens/home_screen.dart';
import 'package:soch_ke_bataunga/screens/lobby_screen.dart';

class GameSession extends StatefulWidget {
  final String code;
  const GameSession({super.key, required this.code});

  @override
  State<GameSession> createState() => _GameSessionState();
}

class _GameSessionState extends State<GameSession> {
  @override
  Widget build(BuildContext context) {
    final stream = FirebaseFirestore.instance
        .collection('Rooms')
        .doc(widget.code)
        .snapshots();
    return Scaffold(
      body: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic>? data = snapshot.data!.data();
            if (data!['gamemode'] == 'lobby') {
              return LobbyScreen(code: widget.code);
            }
          }
          return const HomeScreen();
        },
      ),
    );
  }
}
