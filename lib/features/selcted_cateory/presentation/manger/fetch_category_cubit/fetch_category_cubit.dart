// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../data/repos/category_repo_impl.dart';

part 'fetch_category_state.dart';

class FetchCategoryCubit extends Cubit<FetchCategoryState> {
  FetchCategoryCubit(this.categoryRepoImpl) : super(FetchCategoryInitial());
  CategoryRepoImpl categoryRepoImpl;

  Future<void> fetchCategory() async {
    emit(FetchCategoryLoading());
    var result = await categoryRepoImpl.fetchCategory();
    result.fold((failure) {
      emit(FetchCategoryFailure(errMessage: failure));
    }, (success) {
      emit(FetchCategorySuccess(cateorys: success));
    });
  }
  
}
