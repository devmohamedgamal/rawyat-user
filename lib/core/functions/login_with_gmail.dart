import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final FirebaseAuth auth = FirebaseAuth.instance;

  User? get user => auth.currentUser;

  Future<dynamic> signInWithGoogle({required Function onSignIn}) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          try {
            CollectionReference users =
                FirebaseFirestore.instance.collection('users');
            await users.doc(user.uid).set({
              'name': user.displayName,
              'uid': user.uid,
              'bookmarks' : [],
              'email': user.email,
              'photoUrl': user.photoURL,
            });
          } catch (e) {
            log('catch error: $e');
          }
        }
        onSignIn();
      }
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      log('exception-> $e');
    } catch (e) {
      log('exception-> $e');
    }
  }

  static Future<bool> signOutFromGoogle({required Function onSignIn}) async {
    try {
      await FirebaseAuth.instance.signOut();
      onSignIn();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
