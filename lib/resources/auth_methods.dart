import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:video_player_admin/resources/storage_methods.dart';
import '../models/user_model.dart' as model;
import '../utils/utils.dart';
import '../views/home_screen.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
    await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  // signing up the user
  Future<String> signUpUser(
      {required String email,
        required String password}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // add user to the database
        model.User user = model.User(
          uid: cred.user!.uid,
          email: email,
        );

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        res = 'success';
      } else {
        res = 'Please enter all the details';
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential cred = await _auth
            .signInWithEmailAndPassword(email: email, password: password);

        model.User user = model.User(
          uid: cred.user!.uid,
          email: email,
        );

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson(), SetOptions(merge: true));

        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // signing out the user
  Future<void> signOut(context) async {
    await _auth.signOut().then((value) {}).onError((error, stackTrace) {
      showSnackBar(error.toString(), context);
    });
  }
}