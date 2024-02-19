import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rwayat/features/liveView/presentation/views/live_view.dart';
import 'package:rwayat/features/novels_details/presentation/views/novel_details_view.dart';
import '../../features/Auth/presentation/views/login_view.dart';
import '../../features/comments/data/repos/comment_repo_impl.dart';
import '../../features/comments/presentation/manger/cubit/add_comment_cubit.dart';
import '../../features/comments/presentation/views/widgets/comments_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/search/presentation/views/search_view.dart';
import '../../features/selcted_cateory/presentation/views/selected_category_view.dart';

abstract class AppRouter {
  static String kNovelDetailsView = '/novelDetailsView';
  static String kSelectedCategoryView = '/selectedCategoryView';
  static String kSearchView = '/searchView';
  static String kCommentView = '/commentView';
  static String kTopRankView = '/TopRankView';
  static String kLoginView = '/LoginView';
  static String kLiveView = '/LiveView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: kSelectedCategoryView,
        builder: (context, state) => SelectedCategoryView(
          nameOfCateory: state.extra as String,
        ),
      ),
      GoRoute(
        path: kSearchView,
        builder: (context, state) => const SearchView(),
      ),
      GoRoute(
          path: kNovelDetailsView,
          builder: (context, state) {
            final novel = (state.extra as Map<String, dynamic>)['novel']
                as QueryDocumentSnapshot;
            final index = (state.extra as Map<String, dynamic>)['index'] as int;
            return NovelDetailsView(
              novel: novel,
              index: index,
            );
          }),
      GoRoute(
        path: kCommentView,
        builder: (context, state) => BlocProvider(
          create: (context) => AddCommentCubit(CommentRepoImpl()),
          child: const CommentsView(),
        ),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: kLiveView,
        builder: (context, state) => LiveView(
          url: state.extra as String,
        ),
      ),
    ],
  );
}
