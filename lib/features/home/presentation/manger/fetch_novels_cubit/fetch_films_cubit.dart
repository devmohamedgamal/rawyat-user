// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repos/fetch_novels_repo_impl.dart';

part 'fetch_films_state.dart';

class FetchNovelsCubit extends Cubit<FetchNovelsState> {
  FetchNovelsRepoImpl fetchNovelsRepoImpl;
  FetchNovelsCubit(this.fetchNovelsRepoImpl) : super(FetchNovelsInitial());
  Future<void> fetchNovels() async {
    emit(FetchNovelsLoading());
    var result = await fetchNovelsRepoImpl.fetchNovels();
    result.fold((failure) {
      emit(FetchNovelsFailure(errMessage: failure));
    }, (success) {
      emit(FetchNovelsSuccess(novels: success));
    });
  }

  Future<void> fetchFilterNovels({String? category}) async {
    emit(FetchFilterNovelsLoading());
    var result =
        await fetchNovelsRepoImpl.fetchFilterNovels(category: category);
    result.fold((failure) {
      emit(FetchFilterNovelsFailure(errMessage: failure));
    }, (success) {
      emit(FetchFilterNovelsSuccess(films: success));
    });
  }

  Future<void> fetchCanDownload() async {
    var result = await fetchNovelsRepoImpl.fetchCanDownload();
    result.fold((failure) {
      return;
    }, (success) {
      emit(FetchCanDownloadSuccess(canDownload: success));
    });
  }
}
