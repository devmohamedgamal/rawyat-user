import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../../core/functions/helper_func.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/firebase_api.dart';
import 'fetch_novels_repo.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class FetchNovelsRepoImpl extends FetchNovelsRepo {
  @override
  Future<Either<String, CollectionReference>> addNovel({
    required String name,
    required String kind,
    required String desc,
    required List<String> categorys,
    required File image,
    required bool isMostRead,
    int? adsCounter,
  }) async {
    try {
      CollectionReference novels =
          FirebaseFirestore.instance.collection(keyCollectionNovels);
      var imageName = basename(image.path);
      var refStorge = FirebaseStorage.instance.ref(imageName);
      await refStorge.putFile(image);
      var url = await refStorge.getDownloadURL();

      
      await novels
          .add({
            "name": name,
            'kind': kind,
            'description': desc,
            'category': categorys,
            'image': url,
            "adsCounter": adsCounter ?? 1,
            'isMostRead': isMostRead,
            "addDate": DateTime.now(),
          })
          .then((DocumentReference doc) =>
              log('DocumentSnapshot added with ID: ${doc.id}'))
          .catchError((error) => log(error.toString()));
      FirebaseApi().sendMessageToTopic(name, desc, kTopicNotify, url);
      return right(novels);
    } on FirebaseException catch (e) {
      log(e.message!);
      return left(e.message!.toString());
    } catch (e) {
      log(e.toString());
      return left(e.toString());
    }
  }

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
          for (var categoryName in item['category']) {
            if (categoryName == category) {
              filterNovels.add(item);
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

  @override
  Future<Either<String, bool>> editNovels({
    required String name,
    required String kind,
    required String desc,
    required List<String> categorys,
    required File? image,
    required String docId,
    required bool isMostRead,
    int? adsCounter,
  }) async {
    try {
      if (image != null) {
        var imageName = basename(image.path);
        var refStorge = FirebaseStorage.instance.ref(imageName);
        await refStorge.putFile(image);
        var url = await refStorge.getDownloadURL();
        CollectionReference imageRefrence =
            FirebaseFirestore.instance.collection(keyCollectionNovels);
        await imageRefrence.doc(docId).update({
          "image": url,
        });
      }
      CollectionReference novels =
          FirebaseFirestore.instance.collection(keyCollectionNovels);
      await novels.doc(docId).update({
        "name": name,
        'kind': kind,
        'description': desc,
        'category': categorys,
        'adsCounter': adsCounter,
        'isMostRead': isMostRead,
        'updatedAt': DateTime.now(),
      });
      return right(true);
    } on FirebaseException catch (e) {
      log(e.message!);
      return left(e.message!.toString());
    } catch (e) {
      log(e.toString());
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> deleteNovel({required String docId}) async {
    try {
      CollectionReference novels =
          FirebaseFirestore.instance.collection(keyCollectionNovels);
      await novels.doc(docId).delete();
      return right(true);
    } on FirebaseException catch (e) {
      log(e.message!);
      return left(e.message!.toString());
    } catch (e) {
      log(e.toString());
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> updateCanDownload() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("canDownload").get();
      CollectionReference canDownloadColl =
          FirebaseFirestore.instance.collection("canDownload");

      if (querySnapshot.docs.first['canDownload'] == true) {
        await canDownloadColl.doc('canDownload').update({
          "canDownload": false,
        });
        return right(false);
      } else {
        await canDownloadColl.doc('canDownload').update({
          "canDownload": true,
        });
        return right(true);
      }
    } on FirebaseException catch (e) {
      log(e.message!);
      return left(e.message!.toString());
    } catch (e) {
      log(e.toString());
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<QueryDocumentSnapshot>>> fetchCanDownload() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("canDownload").get();
      log(querySnapshot.docs.first.toString());
      return right(querySnapshot.docs);
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
      fetchUsers() async {
    try {
      List<QueryDocumentSnapshot> users = [];
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .orderBy('points', descending: true)
          .get();
      users.addAll(querySnapshot.docs);
      log(querySnapshot.docs[1]['name']);
      return right(users);
    } on FirebaseException catch (e) {
      log("${e.message!} FireBaseException");
      return left(e.message!);
    } catch (e) {
      log("${e.toString()} elseException");
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> deletePointsForUser(
      {required String uid}) async {
    try {
      CollectionReference user = FirebaseFirestore.instance.collection('users');
      await user.doc(uid).update({
        'points': 0,
      });
      return right(true);
    } on FirebaseException catch (e) {
      log(e.message!);
      return left(e.message!.toString());
    } catch (e) {
      log(e.toString());
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> clearAllPoints() async {
    try {
      CollectionReference userCollextion =
          FirebaseFirestore.instance.collection('users');
      QuerySnapshot users =
          await FirebaseFirestore.instance.collection('users').get();
      for (var user in users.docs) {
        await userCollextion.doc(user['uid']).update({
          'points': 0,
        });
      }
      return right(true);
    } on FirebaseException catch (e) {
      log(e.message!);
      return left(e.message!.toString());
    } catch (e) {
      log(e.toString());
      return left(e.toString());
    }
  }
}
