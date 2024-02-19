part of 'fetch_top_category_cubit.dart';

@immutable
sealed class FetchTopCategoryState {}

final class FetchTopCategoryInitial extends FetchTopCategoryState {}

final class FetchTopCategoryLoading extends FetchTopCategoryState {}

final class FetchTopCategoryFailure extends FetchTopCategoryState {
  final String errMessage;

  FetchTopCategoryFailure({required this.errMessage});
}

final class FetchTopCategorySuccess extends FetchTopCategoryState {
  final List<QueryDocumentSnapshot> topCateorys;
  FetchTopCategorySuccess({required this.topCateorys});
}


final class DeleteTopCategoryLoading extends FetchTopCategoryState {}

final class DeleteTopCategoryFailure extends FetchTopCategoryState {
  final String errMessage;

  DeleteTopCategoryFailure({required this.errMessage});
}

final class DeleteTopCategorySuccess extends FetchTopCategoryState {}
