import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;

  User({
    required this.uid,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    'uid' : uid,
    'email' : email,
  };

  static User fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uid: snapshot['uid'],
      email: snapshot['email'],
    );
  }

}