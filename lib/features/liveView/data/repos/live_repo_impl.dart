import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rwayat/core/utils/constants.dart';

import 'live_repo.dart';

class LiveRepoImpl implements LiveRepo {
  @override
  Future<Either<String, Map<String, dynamic>>> getLiveUrl() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection(kSettingsKey)
              .doc('w6LJBUW3OgrDXogApWT7')
              .get();
      return right(querySnapshot.data()!);
    } on FirebaseException catch (e) {
      log(e.message!);
      return left(e.message!);
    } catch (e) {
      log(e.toString());
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, int>> getEmojeAdsCounter() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(kSettingsKey).get();
      log(" Emoje Ads Counter Live View ${querySnapshot.docs[0]['EmojeAdsCounter'].toString()}");
      return right(querySnapshot.docs[0]['EmojeAdsCounter']);
    } on FirebaseException catch (e) {
      log(e.message!);
      return left(e.message!);
    } catch (e) {
      log(e.toString());
      return left(e.toString());
    }
  }

 
}
