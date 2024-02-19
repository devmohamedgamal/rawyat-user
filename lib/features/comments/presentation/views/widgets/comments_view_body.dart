import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rwayat/features/comments/presentation/manger/cubit/add_comment_cubit.dart';
import '../../../../../core/functions/helper_func.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/custom_loading_indecator.dart';
import '../../../../../core/utils/custom_snackbar.dart';
import '../../../../../core/utils/custom_text_form_field.dart';
import '../../../../../core/utils/my_app_methods.dart';
import '../../../../../core/utils/subtitle_text.dart';
import '../../../../../core/utils/title_text.dart';

class CommentsViewBody extends StatelessWidget {
  const CommentsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController commentController = TextEditingController();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(keyCollectionComments)
              .orderBy("date")
              .snapshots(),
          builder: (context, snapshot) {
            List<QueryDocumentSnapshot> comments = [];
            if (snapshot.connectionState != ConnectionState.waiting) {
              comments.addAll(snapshot.data!.docs);
            } else {
              const CustomLoadingIndecator();
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: comments.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: Colors.blue,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 7.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TitleTextWidget(
                                  lebal: comments[i]['comment'],
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                SubTitleTextWidget(
                                  lebal: getFormatedDate(comments[i]['date']),
                                  fontSize: 10.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                BlocListener<AddCommentCubit, AddCommentState>(
                  listener: (context, state) {
                    if (state is AddCommentFailure) {
                      customSnackBar(context, state.errMessage);
                    }
                  },
                  child: ListTile(
                    title: CustomTextFormField(
                      hint: "اكتب تعليقك",
                      controller: commentController,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        context.read<AddCommentCubit>().addComment(
                            comment: commentController.text,
                            date: DateTime.now());
                        commentController.clear();
                      },
                      icon: const Icon(
                        Icons.send,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
