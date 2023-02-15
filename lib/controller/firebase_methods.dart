import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soch_ke_bataunga/models/user.dart';

class MyfirebaseMethods {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static final collection = firestore.collection('Rooms');

  Future<int> createRoom(String roomCode, String name) async {
    int res = 0;
    await collection.doc(roomCode).get().then((value) {
      if (value.exists) {
        return res;
      }
    });
    try {
      await collection.doc(roomCode).set({
        "players": [name],
        "leader": FirebaseAuth.instance.currentUser!.email,
        "gamemode": "lobby",
        "hideNames": true
      });
      res = 1;
    } catch (e) {
      print(e);
      res = 0;
    }
    return res;
  }

  Future<bool> isLeader(String code) async {
    String curr_leader = "";
    String user = " ";
    await collection.doc(code).get().then((value) {
      Map<String, dynamic> data = value.data()!;
      curr_leader = data["leader"];
      user = FirebaseAuth.instance.currentUser!.email!.toString();
    });
    if (curr_leader == user) {
      print("yes");
      return true;
    } else {
      return false;
    }
  }

  void changeHiddenName(String code, bool Hidden) async {
    await collection.doc(code).update({
      "hideNames": Hidden,
    });
  }

  Future<bool> isNameHidden(String code) async {
    bool res = true;
    await collection.doc(code).get().then((value) {
      Map<String, dynamic> data = value.data()!;
      res = data['hideNames'];
    });
    return res;
  }

  Future<int> joinRoom(String code, String name) async {
    bool roomExists = false;
    await collection.doc(code).get().then((value) {
      if (value.exists) {
        roomExists = true;
      }
    });
    if (roomExists == false) {
      return 0;
    } else {
      Map<String, dynamic> data = {};
      await collection.doc(code).get().then((snapshot) {
        data = snapshot.data()!;
      });
      List<String> players =
          (data['players'] as List).map((item) => item as String).toList();
      players.add(name);
      try {
        await collection.doc(code).update({"players": players});
        return 1;
      } catch (e) {
        return 0;
      }
    }
  }
}
