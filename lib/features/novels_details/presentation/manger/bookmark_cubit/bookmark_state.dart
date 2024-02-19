part of 'bookmark_cubit.dart';

@immutable
sealed class BookmarkState {}

final class BookmarkInitial extends BookmarkState {}

final class BookmarkLoading extends BookmarkState {}

final class BookmarkFailure extends BookmarkState {
  final String errMessage;

  BookmarkFailure({required this.errMessage});
}

final class Bookmarksuccess extends BookmarkState {
  final List bookmarks;
  Bookmarksuccess({required this.bookmarks});
}

