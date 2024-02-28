import 'package:dartz/dartz.dart';

abstract class BookmarkRepo {
  Future<Either<String, List>> fetchBookmarks({required String uid});
  Future<Either<String, String>> addBookmark({required String uid,required String name,required int number});
}
