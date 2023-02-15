import 'dart:math';

class GameMethods {
  String generateRoomCode() {
    Random random = Random();
    int code = random.nextInt(99999) + 10000;
    return code.toString();
  }
}
