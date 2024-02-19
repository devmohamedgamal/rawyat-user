import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rwayat/core/functions/login_with_gmail.dart';
import 'package:rwayat/core/utils/custom_snackbar.dart';
import 'package:rwayat/features/home/presentation/manger/fetch_novels_cubit/fetch_films_cubit.dart';
import 'package:rwayat/features/novels_details/presentation/manger/bookmark_cubit/bookmark_cubit.dart';
import '../../../../core/utils/app_router.dart';
import '../widgets/build_pop_up.dart';
import '../widgets/custom_navigation_drawer.dart';
import '../widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final Authentication authentication = Authentication();
    return BlocBuilder<FetchNovelsCubit, FetchNovelsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("main menu"),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  if (authentication.user != null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => buildPopupDialog(
                        context: context,
                        novels: (state as FetchNovelsSuccess).novels
                            as List<QueryDocumentSnapshot>,
                      ),
                    );
                    context
                        .read<BookmarkCubit>()
                        .fetchBookmarks(uid: authentication.user!.uid);
                  } else {
                    customSnackBar(context, 'يرجي تسجيل الدخول اولا');
                  }
                },
                icon: const Icon(
                  Icons.bookmark_added,
                  size: 35,
                  color: Colors.blue,
                ),
              ),
              IconButton(
                onPressed: () {
                  context.push(AppRouter.kSearchView);
                },
                icon: const Icon(
                  Icons.search,
                  size: 35,
                ),
              ),
            ],
          ),
          drawer: const CustomNavigationDrawer(),
          body: const HomeViewBody(),
        );
      },
    );
  }
}
