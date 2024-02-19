import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/functions/helper_func.dart';
import '../../../../../core/functions/login_with_gmail.dart';
import '../../manger/bookmark_cubit/bookmark_cubit.dart';
import 'novel_list_view_item.dart';

class NovelDetailsViewBody extends StatelessWidget {
  const NovelDetailsViewBody(
      {super.key, required this.novel, required this.index});
  final QueryDocumentSnapshot novel;
  final int index;

  @override
  Widget build(BuildContext context) {
    if (Authentication().user != null) {
      context
          .read<BookmarkCubit>()
          .fetchBookmarks(uid: Authentication().user!.uid);
    }
    final ScrollController scrollController =
        ScrollController(initialScrollOffset: (index - 1) * 125.0.h);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView.builder(
        controller: scrollController,
        itemCount: splitTextIntoWords(novel['description'], 45).length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, i) {
          final chunk = splitTextIntoWords(novel['description'], 45)[i];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CustomContainerListViewItem(
              count: i + 1,
              pherse: chunk,
              name: novel['name'],
            ),
          );
        },
      ),
    );
  }
}
