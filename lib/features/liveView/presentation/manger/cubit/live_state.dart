part of 'live_cubit.dart';

@immutable
sealed class LiveState {}

final class LiveInitial extends LiveState {}

final class LiveLoading extends LiveState {}

final class LiveFailure extends LiveState {
  final String errMessage;

  LiveFailure({required this.errMessage});
}

final class LiveSuccess extends LiveState {
  final Map<String,dynamic> liveUrl;

  LiveSuccess({required this.liveUrl});
}

final class EmojeAdsCounterLoading extends LiveState {}

final class EmojeAdsCounterFailure extends LiveState {
  final String errMessage;

  EmojeAdsCounterFailure({required this.errMessage});
}

final class EmojeAdsCounterSuccess extends LiveState {
  final int adsCounter;

  EmojeAdsCounterSuccess({required this.adsCounter});
}
