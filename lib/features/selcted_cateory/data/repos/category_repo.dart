import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepo {
  Future<Either<String, List<QueryDocumentSnapshot>>> fetchCategory();
  Future<Either<String, List<QueryDocumentSnapshot>>> fetchTopCategory();
}
