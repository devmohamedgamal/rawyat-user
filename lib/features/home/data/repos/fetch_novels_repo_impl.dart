import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/utils/constants.dart';
import 'fetch_novels_repo.dart';
// ignore: depend_on_referenced_packages

class FetchNovelsRepoImpl extends FetchNovelsRepo {
  @override
  Future<Either<String, List<QueryDocumentSnapshot>>> fetchNovels() async {
    try {
      List<QueryDocumentSnapshot> novels = [];
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(keyCollectionNovels)
          .orderBy('addDate', descending: true)
          .get();
      novels.addAll(querySnapshot.docs);
      log(querySnapshot.docs[1].toString());
      return right(novels);
    } on FirebaseException catch (e) {
      log(e.message!);
      return left(e.message!);
    } catch (e) {
      log(e.toString());
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<QueryDocumentSnapshot<Object?>>>>
      fetchFilterNovels({String? category}) async {
    try {
      List<QueryDocumentSnapshot> filterNovels = [];
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(keyCollectionNovels)
          .get();
      if (category != null) {
        for (var item in querySnapshot.docs) {
          if (category == 'روايات كتابية') {
            if (item['kind'] == 'مكتوب') {
              filterNovels.add(item);
            }
          } else if (category == 'روايات صوتية') {
            if (item['kind'] == 'صوت') {
              filterNovels.add(item);
            }
          } else {
            for (var categoryName in item['category']) {
              if (categoryName == category) {
                filterNovels.add(item);
              }
            }
          }
        }
      } else {
        for (var item in querySnapshot.docs) {
          if (item.exists) {
            var data = item.data();
            var res = data as Map<String, dynamic>;
            if (res.containsKey('isMostRead')) {
              if (item['isMostRead']) {
                filterNovels.add(item);
              }
            }
          }
        }
      }
      log(querySnapshot.docs[1].toString());
      return right(filterNovels);
    } on FirebaseException catch (e) {
      log(e.message!);
      return left(e.message!);
    } catch (e) {
      log(e.toString());
      return left(e.toString());
    }
  }
}
