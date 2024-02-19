// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import '../../../data/repos/category_repo_impl.dart';

part 'fetch_top_category_state.dart';

class FetchTopCategoryCubit extends Cubit<FetchTopCategoryState> {
  FetchTopCategoryCubit(this.categoryRepoImpl) : super(FetchTopCategoryInitial());
  CategoryRepoImpl categoryRepoImpl;
  Future<void> fetchTopCategory() async {
    emit(FetchTopCategoryLoading());
    log('fetch top category');
    var result = await categoryRepoImpl.fetchTopCategory();
    result.fold((failure) {
      emit(FetchTopCategoryFailure(errMessage: failure));
    }, (success) {
      emit(FetchTopCategorySuccess(topCateorys: success));
    });
  }
}
