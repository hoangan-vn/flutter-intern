import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:safebump/src/network/data/sign/sign_repository.dart';
import 'package:safebump/src/network/firebase/helper/firebase_helper.dart';
import 'package:safebump/src/network/model/common/error_code.dart';
import 'package:safebump/src/network/model/domain_manager.dart';
import 'package:safebump/src/network/model/social_user/social_user.dart';
import 'package:safebump/src/network/model/user/user.dart';
import 'package:safebump/src/services/user_prefs.dart';
import 'package:safebump/src/utils/utils.dart';

import '../../model/common/result.dart';

class SignRepositoryImpl extends SignRepository {
  @override
  Future<MResult<MUser>> connectBEWithGoogle(MSocialUser user) async {
    try {
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
          accessToken: user.accessToken, idToken: user.idToken);
      // Once signed in, return the UserCredential
      final UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final firebaseUser = result.user;
      final newUser = MUser(
        id: firebaseUser?.uid ?? '',
        email: user.email,
        name: user.fullName,
      );
      final userResult = await DomainManager().user.getOrAddUser(newUser);

      // save sharepref
      UserPrefs.I.setToken(await result.user?.getIdToken());
      UserPrefs.I.setUser(userResult.data);

      return MResult.success(userResult.data ?? newUser);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  @override
  Future<MResult<bool>> forgotPassword(String email) async {
    final result =
        await AuthenticationHelper().sendVerifyCodeThoughEmail(email: email);

    if (result == null) {
      return MResult.success(true);
    } else {
      xLog.e(result);
      return MResult.error(MErrorCode.unknown);
    }
  }

  @override
  Future<MResult> logOut(MUser user) async {
    try {
      await FirebaseAuth.instance.signOut();
      return MResult.success(user);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  @override
  Future<MResult<MUser>> loginWithEmail(
      {required String email, required String password}) async {
    final result =
        await AuthenticationHelper().signIn(email: email, password: password);

    if (result != null) {
      final user = result.user;
      final token = await result.user?.getIdToken();
      final newUser = MUser(
        id: user?.uid ?? '',
        email: email,
        name: user?.displayName,
      );

      final userResult = await DomainManager().user.getOrAddUser(newUser);

      // save sharepref
      UserPrefs.I.setToken(token);
      UserPrefs.I.setUser(userResult.data);

      return MResult.success(userResult.data ?? newUser);
    } else {
      return MResult.error(MErrorCode.unknown);
    }
  }

  @override
  Future<MResult<MSocialUser>> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final bool isSignedIn = await googleSignIn.isSignedIn();
      if (isSignedIn) {
        await googleSignIn.signOut();
      }
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      if (googleUser != null && googleAuth != null) {
        return MResult.success(
            MSocialUser.fromGoogleAccount(googleUser, googleAuth));
      } else {
        return MResult.error(MErrorCode.unknown);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  @override
  Future<MResult> removeAccount(MUser user) async {
    try {
      final user = AuthenticationHelper().user;
      user?.delete();
      return MResult.success(user);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  @override
  Future<MResult<MUser>> signUpWithEmail(
      {required String email,
      required String password,
      required String name}) async {
    final result =
        await AuthenticationHelper().signUp(email: email, password: password);

    if (result != null) {
      final user = result.user;
      final token = await result.user?.getIdToken();
      final newUser = MUser(
        id: user?.uid ?? '',
        email: email,
        name: name,
      );

      // save sharepref
      UserPrefs.I.setUser(newUser);
      UserPrefs.I.setToken(token);

      final userResult = await DomainManager().user.getOrAddUser(newUser);
      return MResult.success(userResult.data ?? newUser);
    } else {
      return MResult.error(MErrorCode.unknown);
    }
  }
}
