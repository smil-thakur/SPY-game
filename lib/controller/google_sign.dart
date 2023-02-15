import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MySignin {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> myGoogleSignin() async {
    final GoogleSignInAccount? account = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? authentication =
        await account?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: authentication?.accessToken,
        idToken: authentication?.idToken);

    var res = await auth.signInWithCredential(credential);

    return res.user;
  }

  void myGoogleSignout() async {
    await GoogleSignIn().signOut();
    await auth.signOut();
  }
}
