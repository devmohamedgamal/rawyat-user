import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rwayat/core/functions/login_with_gmail.dart';

import '../../../novels_details/presentation/manger/bookmark_cubit/bookmark_cubit.dart';

class BookmarkListViweItem extends StatelessWidget {
  const BookmarkListViweItem(
      {super.key, required this.text, this.onTap, required this.number});
  final String text;
  final int number;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      splashColor: Colors.blue,
      // selectedColor: Colors.blue,
      onTap: onTap,
      tileColor: Colors.grey.withOpacity(0.4),
      title: SizedBox(
        width: 250,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      leading: Text(
        'رقم $number',
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
      trailing: SizedBox(
        width: 80.w,
        child: Row(
          children: [
            const Icon(Icons.arrow_forward_ios),
            IconButton(
                onPressed: () {
                  context.read<BookmarkCubit>().addBookmark(
                        uid: Authentication().user!.uid,
                        name: text,
                        number: number,
                      );
                  context
                      .read<BookmarkCubit>()
                      .fetchBookmarks(uid: Authentication().user!.uid);
                },
                icon: const Icon(
                  Icons.clear,
                  color: Colors.red,
                )),
          ],
        ),
      ),
    );
  }
}
