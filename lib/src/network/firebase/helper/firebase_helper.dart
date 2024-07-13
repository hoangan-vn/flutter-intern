import 'package:firebase_auth/firebase_auth.dart';
import 'package:safebump/src/dialogs/toast_wrapper.dart';
import 'package:safebump/src/utils/utils.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future<UserCredential?> signUp(
      {required String email, required String password}) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } on FirebaseAuthException catch (e) {
      XToast.error(e.message);
      return null;
    }
  }

  //SIGN IN METHOD
  Future<UserCredential?> signIn(
      {required String email, required String password}) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result;
    } on FirebaseAuthException catch (e) {
      xLog.e(e.message);
      return null;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();
  }

  //FORGOT PASSWORD METHOD
  Future sendVerifyCodeThoughEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
