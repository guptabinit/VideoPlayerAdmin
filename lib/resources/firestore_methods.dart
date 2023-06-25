import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:video_player_admin/resources/storage_methods.dart';

import '../utils/utils.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final curUser = FirebaseAuth.instance.currentUser!.uid;


  Future<void> uploadVideo({
    required String vid,
    required String uid,
    required String videoLink,
    required Uint8List? file,
    required String description,
    required String title,
    required context,
  }) async {
    try {

      String thumbnailUrl = await StorageMethods().uploadImageToStorage(file!, vid);

      await _firestore.collection('users').doc(curUser).update({
        'videos': FieldValue.arrayUnion([
          {
            'uid': uid,
            'vid': vid,
            'video_link': videoLink,
            'thumbnail': thumbnailUrl,
            'description': description,
            'title': title
          }
        ])
      });

      await _firestore.collection('videos').doc(vid).set({
        'uid': uid,
        'vid': vid,
        'video_link': videoLink,
        'thumbnail': thumbnailUrl,
        'description': description,
        'title': title
      }).then((value) => showSnackBar("Uploaded Successfully", context));

    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  Future<void> deleteVideo(
      {
        required String vid,
        required String uid,
        required String videoLink,
        required String thumbnail,
        required String description,
        required String title,
        required context
      }) async {
    try {
      await _firestore.collection('videos').doc(vid).delete();

      await _firestore.collection('users').doc(curUser).set({
        'videos': FieldValue.arrayRemove([
          {
            'uid': uid,
            'vid': vid,
            'video_link': videoLink,
            'thumbnail': thumbnail,
            'description': description,
            'title': title
          }
        ])
      }, SetOptions(merge: true));

    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }
}