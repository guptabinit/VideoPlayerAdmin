import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String vid;
  final String uid;
  final String videoLink;
  final String thumbnail;
  final String description;
  final String title;

  User({
    required this.vid,
    required this.uid,
    required this.videoLink,
    required this.thumbnail,
    required this.description,
    required this.title,
  });

  Map<String, dynamic> toJson() => {
    'vid' : vid,
    'uid' : uid,
    'video_link' : videoLink,
    'thumbnail' : thumbnail,
    'description' : description,
    'title' : title,
  };

  static User fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      vid: snapshot['vid'],
      uid: snapshot['uid'],
      videoLink: snapshot['video_link'],
      thumbnail: snapshot['thumbnail'],
      description: snapshot['description'],
      title: snapshot['title'],
    );
  }

}