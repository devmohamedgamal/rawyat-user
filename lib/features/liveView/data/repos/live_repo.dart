import 'package:dartz/dartz.dart';

abstract class LiveRepo {
  Future<Either<String, Map<String, dynamic>>> getLiveUrl();
  Future<Either<String, int>> getEmojeAdsCounter();
}
