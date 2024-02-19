import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class CommentRepo{
  Future<Either<String,CollectionReference>> addComment({required String comment,required DateTime date});
}