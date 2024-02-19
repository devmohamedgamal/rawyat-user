part of 'add_comment_cubit.dart';

@immutable
sealed class AddCommentState {}

final class AddCommentInitial extends AddCommentState {}

final class AddCommentLoading extends AddCommentState {}

final class AddCommentFailure extends AddCommentState {
  final String errMessage;

  AddCommentFailure({required this.errMessage});
}

final class AddCommentSuccess extends AddCommentState {}


final class DeleteCommentLoading extends AddCommentState {}

final class DeleteCommentFailure extends AddCommentState {
  final String errMessage;

  DeleteCommentFailure({required this.errMessage});
}

final class DeleteCommentSuccess extends AddCommentState {}
