import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../models/post_model.dart';

class PostService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<bool> addPost(PostModel post, String uid) async {
    DocumentReference documentReference = _firestore.collection("Posts").doc();
    await FirebaseFirestore.instance
        .runTransaction((transaction) async {
          transaction.set(
            documentReference,
            post
                .copyWith(
                    uid: uid,
                    id: documentReference.id,
                    createdAt: DateTime.now())
                .toMap(),
          );
        })
        .onError((error, stackTrace) {
          EasyLoading.showError("Error");
          EasyLoading.dismiss();
        })
        .then((value) => EasyLoading.showSuccess("Post Added"))
        .catchError((error) {
          EasyLoading.dismiss();
          return EasyLoading.showError("Error : $error");
        });
    return true;
  }

  static updatePost(String postId, PostModel post) {
    DocumentReference documentReference =
        _firestore.collection("Posts").doc(postId);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(
        documentReference,
        post.toMap(),
      );
    });
    return null;
  }

  static Future<bool> addReactionToPost(
      String postId, Reaction reaction) async {
    try {
      DocumentReference documentReference =
          _firestore.collection("Posts").doc(postId);
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.update(
          documentReference,
          {
            "reactions": FieldValue.arrayUnion([reaction.toMap()]),
          },
        );
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> addCommentToPost(String postId, Comment comment) async {
    DocumentReference documentReference =
        _firestore.collection("Posts").doc(postId);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(
        documentReference,
        {
          "comments": FieldValue.arrayUnion([comment.toMap()])
        },
      );
    });
    return true;
  }

  Stream<List<Comment>> getComments(String postId) {
    return _firestore.collection("Posts").doc(postId).snapshots().map((event) =>
        event
            .data()!["comments"]
            ?.map<Comment>((e) => Comment.fromMap(e))
            .toList() ??
        []);
  }

  static Future deletePostToUser({required String postId}) async {
    await _firestore.collection("Posts").doc(postId).delete();

    // ignore: avoid_print
    print("Deleted");
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllUserPosts() async {


    final data = await _firestore
        .collection("Posts")
        .orderBy("createdAt", descending: true)
        .get();
    return data;
  }

  static Future removeReactionFromPost(String postId, String uid) async {
    DocumentReference documentReference =
        _firestore.collection("Posts").doc(postId);
    return await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(
        documentReference,
        {
          "reactions": FieldValue.arrayRemove([
            {
              "uid": uid,
            }
          ])
        },
      );
    });
  }
}
