import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/constants.dart';
import 'category_repo.dart';

class CategoryRepoImpl implements CategoryRepo {
  @override
  Future<Either<String, List<QueryDocumentSnapshot<Object?>>>>
      fetchCategory() async {
    try {
      List<QueryDocumentSnapshot> categorys = [];
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(keyCollectionCategorys)
          .get();
      categorys.addAll(querySnapshot.docs);
      log(querySnapshot.docs[1].toString());
      return right(categorys);
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
      fetchTopCategory() async {
    try {
      List<QueryDocumentSnapshot> topCategorys = [];
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(keyCollectionTopCategorys)
          .get();
      if (querySnapshot.docs.length == 1) {
        topCategorys.add(querySnapshot.docs[0]);
      } else {
        topCategorys.addAll(querySnapshot.docs);
      }
      log("${querySnapshot.docs.first['name'].toString()} first doc in topCategorys");
      return right(topCategorys);
    } on FirebaseException catch (e) {
      log("${e.message!} topCategory error from Firebase");
      return left(e.message!);
    } catch (e) {
      log("${e.toString()} topCategory error from else Expceptions");
      return left(e.toString());
    }
  }

}
