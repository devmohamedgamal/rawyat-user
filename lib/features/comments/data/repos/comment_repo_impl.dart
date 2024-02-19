import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/constants.dart';
import 'comment_repo.dart';

class CommentRepoImpl implements CommentRepo {
  @override
  Future<Either<String, CollectionReference>> addComment(
      {required String comment, required DateTime date}) async {
    try {
      CollectionReference comments =
          FirebaseFirestore.instance.collection(keyCollectionComments);
      comments
          .add({
            "comment": comment,
            "date": "$date",
          })
          .then((DocumentReference doc) =>
              log('DocumentSnapshot added with ID: ${doc.id}'))
          .catchError((error) => log(error.toString()));

      return right(comments);
    } on FirebaseException catch (e) {
      log(e.message!);
      return left(e.message!.toString());
    } catch (e) {
      log(e.toString());
      return left(e.toString());
    }
  }
}
