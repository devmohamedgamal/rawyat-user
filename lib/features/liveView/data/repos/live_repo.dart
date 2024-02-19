import 'package:dartz/dartz.dart';

abstract class LiveRepo {
  Future<Either<String, String>> getLiveUrl();
  Future<Either<String, int>> getEmojeAdsCounter();
}
