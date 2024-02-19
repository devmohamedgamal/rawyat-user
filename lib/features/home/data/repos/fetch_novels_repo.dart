import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class FetchNovelsRepo {
  Future<Either<String, List<QueryDocumentSnapshot>>> fetchNovels();
  Future<Either<String, List<QueryDocumentSnapshot>>> fetchFilterNovels(
      {String? category});
}
