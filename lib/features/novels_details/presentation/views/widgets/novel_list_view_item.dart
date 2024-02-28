import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rwayat/core/functions/helper_func.dart';
import 'package:rwayat/core/functions/login_with_gmail.dart';
import 'package:rwayat/core/utils/custom_snackbar.dart';
import 'package:rwayat/features/novels_details/presentation/manger/bookmark_cubit/bookmark_cubit.dart';

class CustomContainerListViewItem extends StatefulWidget {
  const CustomContainerListViewItem(
      {super.key,
      required this.count,
      required this.pherse,
      required this.name});
  final int count;
  final String pherse, name;

  @override
  State<CustomContainerListViewItem> createState() =>
      _CustomContainerListViewItemState();
}

class _CustomContainerListViewItemState
    extends State<CustomContainerListViewItem> {
  bool isSaved = false;
  final Authentication authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookmarkCubit, BookmarkState>(
      listener: (context, state) {
        if (state is Bookmarksuccess) {
          if (containsMap(state.bookmarks, {
            'name': widget.name,
            'number': widget.count,
            'text': widget.pherse,
          })) {
            setState(() {
              isSaved = true;
            });
          }
        }
      },
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 140.h,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      widget.pherse,
                      maxLines: 5,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    color: Colors.blue,
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.count}',
                          style:
                              TextStyle(color: Colors.white, fontSize: 20.sp),
                        ),
                        IconButton(
                          padding: const EdgeInsets.only(right: 10),
                          onPressed: () {
                            if (authentication.user != null) {
                              if (isSaved) {
                                setState(() {
                                  isSaved = false;
                                });
                                context.read<BookmarkCubit>().addBookmark(
                                      uid: authentication.user!.uid,
                                      name: widget.name,
                                      number: widget.count,
                                    );
                              } else {
                                setState(() {
                                  isSaved = true;
                                });
                                context.read<BookmarkCubit>().addBookmark(
                                      uid: authentication.user!.uid,
                                      name: widget.name,
                                      number: widget.count,
                                    );
                              }
                            } else {
                              customSnackBar(context, 'يرجي التسجيل اولا');
                            }
                          },
                          icon: Icon(
                            isSaved ? Icons.bookmark : Icons.bookmark_outline,
                            color: Colors.white,
                            size: 33,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Divider(
            thickness: 1,
            color: Colors.grey.withOpacity(0.4),
            endIndent: 30,
            indent: 30,
          ),
        ],
      ),
    );
  }
}
