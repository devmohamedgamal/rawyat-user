import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rwayat/core/utils/app_router.dart';
import 'package:rwayat/core/utils/custom_error_widget.dart';
import 'package:rwayat/core/utils/custom_loading_indecator.dart';
import 'package:rwayat/features/novels_details/presentation/manger/bookmark_cubit/bookmark_cubit.dart';
import 'bookmark_list_view_item.dart';

Widget buildPopupDialog(
    {required BuildContext context,
    required List<QueryDocumentSnapshot> novels}) {
  return BlocBuilder<BookmarkCubit, BookmarkState>(
    builder: (context, state) {
      if (state is Bookmarksuccess) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: AlertDialog(
            title: const Text('BookMarks'),
            content: SizedBox(
              height: 600.h,
              width: 300.w,
              child: state.bookmarks.isEmpty
                  ? const Center(
                      child: Text('لا يوجد علامات حفظ'),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.bookmarks.length,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemBuilder: (context, index) {
                        late QueryDocumentSnapshot novel;
                        for (var i in novels) {
                          if (i['name'] == state.bookmarks[index]['name']) {
                            novel = i;
                            log('done novel \n ${novel['name']}');
                          }
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: BookmarkListViweItem(
                            text: state.bookmarks[index]['name'],
                            number: state.bookmarks[index]['number'],
                            onTap: () {
                              context.pop();
                              context.push(
                                AppRouter.kNovelDetailsView,
                                extra: {
                                  'novel': novel,
                                  'index': state.bookmarks[index]['number'],
                                },
                              );
                            },
                          ),
                        );
                      }),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      } else if (state is BookmarkFailure) {
        return CustomErrorWidget(errMessage: state.errMessage);
      } else if (state is BookmarkLoading) {
        return const CustomLoadingIndecator();
      } else {
        return const CustomErrorWidget(errMessage: 'Else Error');
      }
    },
  );
}
