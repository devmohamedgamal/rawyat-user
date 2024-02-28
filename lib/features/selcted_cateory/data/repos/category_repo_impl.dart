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
}
