// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rwayat/features/novels_details/data/repos/bookmark_repo_impl.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit(this.bookmarkRepoImpl) : super(BookmarkInitial());
  final BookmarkRepoImpl bookmarkRepoImpl;

  Future<void> fetchBookmarks({required String uid}) async {
    emit(BookmarkLoading());
    var result = await bookmarkRepoImpl.fetchBookmarks(uid: uid);
    result.fold((failure) {
      emit(BookmarkFailure(errMessage: failure));
    }, (success) {
      emit(Bookmarksuccess(bookmarks: success));
    });
  }

  Future<void> addBookmark(
      {required String uid,
      required String name,
      required int number}) async {
    emit(BookmarkLoading());
    var result = await bookmarkRepoImpl.addBookmark(
        uid: uid, name: name, number: number);
    result.fold((failure) {
      emit(BookmarkFailure(errMessage: failure));
    }, (success) {});
  }
}
