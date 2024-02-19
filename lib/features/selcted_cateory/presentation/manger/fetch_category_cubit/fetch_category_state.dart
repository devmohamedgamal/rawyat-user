part of 'fetch_category_cubit.dart';

@immutable
sealed class FetchCategoryState {}

final class FetchCategoryInitial extends FetchCategoryState {}

final class FetchCategoryLoading extends FetchCategoryState {}

final class FetchCategoryFailure extends FetchCategoryState {
  final String errMessage;

  FetchCategoryFailure({required this.errMessage});
}

final class FetchCategorySuccess extends FetchCategoryState {
  final List<QueryDocumentSnapshot> cateorys;
  FetchCategorySuccess({required this.cateorys});
}

final class DeleteCategoryLoading extends FetchCategoryState {}

final class DeleteCategoryFailure extends FetchCategoryState {
  final String errMessage;
  DeleteCategoryFailure({required this.errMessage});
}

final class DeleteCategorySuccess extends FetchCategoryState {}




