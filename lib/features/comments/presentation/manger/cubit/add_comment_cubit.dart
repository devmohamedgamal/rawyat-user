// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repos/comment_repo_impl.dart';

part 'add_comment_state.dart';

class AddCommentCubit extends Cubit<AddCommentState> {
  AddCommentCubit(this.commentRepoImpl) : super(AddCommentInitial());
  CommentRepoImpl commentRepoImpl;

  Future<void> addComment(
      {required String comment, required DateTime date}) async {
    emit(AddCommentLoading());
    var result = await commentRepoImpl.addComment(comment: comment, date: date);
    result.fold((failure) {
      emit(AddCommentFailure(errMessage: failure));
    }, (success) {
      emit(AddCommentSuccess());
    });
  }
}
