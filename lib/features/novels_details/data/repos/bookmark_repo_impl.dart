import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rwayat/features/novels_details/data/repos/bookmark_repo.dart';

import '../../../../core/functions/helper_func.dart';

class BookmarkRepoImpl implements BookmarkRepo {
  @override
  Future<Either<String, String>> addBookmark(
      {required String uid,
      required String name,
      required int number}) async {
    try {
      CollectionReference userCollection =
          FirebaseFirestore.instance.collection('users');

      var user = await userCollection.doc(uid).get();

      log("data for bookmarks ${user.data().toString()}");

      List bookmarks = (user.data() as Map<String, dynamic>)['bookmarks'];

      if (containsMap(
          bookmarks, {'name': name, 'number': number})) {
        removeMap(bookmarks, {'name': name, 'number': number});
        log('remove map from list');
      } else {
        bookmarks.add({'name': name, 'number': number});
      }
      await userCollection.doc(uid).update({
        'bookmarks': bookmarks,
      });
      return right('done');
    } on FirebaseException catch (e) {
      log(e.message!);
      return left(e.message!.toString());
    } catch (e) {
      log(e.toString());
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List>> fetchBookmarks({required String uid}) async {
    try {
      CollectionReference userCollection =
          FirebaseFirestore.instance.collection('users');
      var user = await userCollection.doc(uid).get();
      List bookmarks = (user.data() as Map<String, dynamic>)['bookmarks'];
      return right(bookmarks);
    } on FirebaseException catch (e) {
      log(e.message!);
      return left(e.message!.toString());
    } catch (e) {
      log(e.toString());
      return left(e.toString());
    }
  }
  
}
