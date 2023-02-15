import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soch_ke_bataunga/controller/firebase_methods.dart';

class LobbyScreen extends StatefulWidget {
  final String code;
  const LobbyScreen({super.key, required this.code});

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  bool hideNames = true;
  bool isLeader = false;

  void checkLeader() async {
    bool tempisLeader = await MyfirebaseMethods().isLeader(widget.code);
    bool temphideNames = await MyfirebaseMethods().isNameHidden(widget.code);
    if (temphideNames != hideNames) {
      hideNames = temphideNames;
      setState(() {});
    }
    if (tempisLeader != isLeader) {
      isLeader = tempisLeader;
      setState(() {});
    }
  }

  @override
  void initState() {
    checkLeader();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final stream = FirebaseFirestore.instance
        .collection('Rooms')
        .doc(widget.code)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Room code: ${widget.code}",
          style: GoogleFonts.luckiestGuy(),
        ),
        actions: [
          isLeader
              ? IconButton(
                  onPressed: () async {
                    hideNames = hideNames ? false : true;
                    MyfirebaseMethods()
                        .changeHiddenName(widget.code, hideNames);
                    setState(() {});
                  },
                  icon: Icon(hideNames ? Icons.hide_source : Icons.circle))
              : const SizedBox()
        ],
      ),
      body: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          Map<String, dynamic>? data = snapshot.data!.data();
          print("updating");
          List<String> players =
              (data!['players'] as List).map((item) => item as String).toList();
          List<String> randomPlayer = List.generate(
              players.length, (index) => "Random$index",
              growable: true);
          randomPlayer.shuffle();
          checkLeader();
          return ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                return Text(hideNames ? randomPlayer[index] : players[index]);
              });
        },
      ),
    );
  }
}
