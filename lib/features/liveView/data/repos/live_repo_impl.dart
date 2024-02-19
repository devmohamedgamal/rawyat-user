import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rwayat/core/utils/constants.dart';

import 'live_repo.dart';

class LiveRepoImpl implements LiveRepo {
  @override
  Future<Either<String, String>> getLiveUrl() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(kSettingsKey).get();
      log(" url for Live View ${querySnapshot.docs[0]['liveUrl'].toString()}");
      return right(querySnapshot.docs[0]['liveUrl']);
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
