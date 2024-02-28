import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rwayat/core/functions/appodeal.dart';
import 'package:rwayat/core/functions/helper_func.dart';
import 'package:rwayat/features/liveView/data/repos/live_repo_impl.dart';
import 'package:rwayat/features/novels_details/data/repos/bookmark_repo_impl.dart';
import 'package:rwayat/features/novels_details/presentation/manger/bookmark_cubit/bookmark_cubit.dart';
import 'core/functions/global_var.dart';
import 'core/utils/app_router.dart';
import 'core/utils/firebase_api.dart';
import 'core/utils/observer.dart';
import 'features/home/data/repos/fetch_novels_repo_impl.dart';
import 'features/home/presentation/manger/fetch_novels_cubit/fetch_novels_cubit.dart';
import 'features/liveView/presentation/manger/cubit/live_cubit.dart';
import 'features/selcted_cateory/data/repos/category_repo_impl.dart';
import 'features/selcted_cateory/presentation/manger/fetch_category_cubit/fetch_category_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  await FirebaseApi().requestAndGetToken();
  await checkNotificationPermission();
  AppodealFunc.someMehodsBeforeInit();
  AppodealFunc.initAppodeal();
  await Hive.initFlutter();
  Hive.registerAdapter(AdsCounterAdapter());
  await Hive.openBox<AdsCounter>('adsCounter');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              FetchNovelsCubit(FetchNovelsRepoImpl())..fetchNovels(),
        ),
        BlocProvider(
          create: (context) =>
              FetchCategoryCubit(CategoryRepoImpl())..fetchCategory(),
        ),
        BlocProvider(
          create: (context) => BookmarkCubit(BookmarkRepoImpl()),
        ),
         BlocProvider(
          create: (context) => LiveCubit(LiveRepoImpl())..getLiveurl(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(432.0, 960.0),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
