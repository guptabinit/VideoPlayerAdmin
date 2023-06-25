import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final List videos;

  User({
    required this.uid,
    required this.email,
    required this.videos,
  });

  Map<String, dynamic> toJson() => {
    'uid' : uid,
    'email' : email,
    'videos' : videos,
  };

  static User fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uid: snapshot['uid'],
      email: snapshot['email'],
      videos: snapshot['videos'],
    );
  }

}