import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleAuth {
  var instance = FirebaseAuth.instance;
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final result = await instance.signInWithCredential(credential);

    final pref = await SharedPreferences.getInstance();
    pref.setString("id", result.user?.uid ?? "");
    pref.setString("email", result.user?.email ?? "");

    return result;
  }

  Future logout() async {
    return await instance.signOut();
  }
}
