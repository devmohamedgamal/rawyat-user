part of 'fetch_novels_cubit.dart';

@immutable
sealed class FetchNovelsState {}

final class FetchNovelsInitial extends FetchNovelsState {}

final class FetchNovelsFailure extends FetchNovelsState {
  final String errMessage;

  FetchNovelsFailure({required this.errMessage});
}

final class FetchNovelsLoading extends FetchNovelsState {}

final class FetchNovelsSuccess extends FetchNovelsState {
  final List novels;

  FetchNovelsSuccess({required this.novels});
}

final class FetchFilterNovelsFailure extends FetchNovelsState {
  final String errMessage;

  FetchFilterNovelsFailure({required this.errMessage});
}

final class FetchFilterNovelsLoading extends FetchNovelsState {}

final class FetchFilterNovelsSuccess extends FetchNovelsState {
  final List novels;
  FetchFilterNovelsSuccess({required this.novels});
}
