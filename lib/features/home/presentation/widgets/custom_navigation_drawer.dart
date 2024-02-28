import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rwayat/core/utils/assets_manger.dart';
import 'package:rwayat/features/selcted_cateory/presentation/manger/fetch_category_cubit/fetch_category_cubit.dart';
import '../../../../core/functions/helper_func.dart';
import '../../../../core/functions/launch_url.dart';
import '../../../../core/functions/login_with_gmail.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/custom_error_widget.dart';
import '../../../../core/utils/custom_loading_indecator.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../../core/utils/subtitle_text.dart';
import '../manger/fetch_novels_cubit/fetch_novels_cubit.dart';
import 'drawer_items.dart';
import 'social_media_accounts_bootom_sheet.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final Authentication authentication = Authentication();
    return Drawer(
      child: SingleChildScrollView(
        child: BlocConsumer<FetchCategoryCubit, FetchCategoryState>(
            listener: (context, state) {
          if (state is DeleteCategorySuccess) {
            context.read<FetchCategoryCubit>().fetchCategory();
            customSnackBar(context, "تم الحذف");
          }
        }, builder: (context, state) {
          if (state is FetchCategorySuccess) {
            bool notyAloow = false;
            requestTONotification(context).then((value) {
              notyAloow = value;
            });
            return Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                  bottom: 24.h,
                  right: 24.h,
                  left: 24.h),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 50,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        authentication.user != null
                            ? authentication.user!.displayName!
                            : 'تسجيل الدخول',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.pink,
                        ),
                      ),
                      leading: const Icon(Icons.person_2),
                      tileColor: Colors.transparent,
                      onTap: () {
                        context.push(AppRouter.kLoginView);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.home_outlined),
                      title: Text(
                        "الصفحة الرئيسية",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.blue,
                        ),
                      ),
                      onTap: () {
                        categoryIndex = 0;
                        context.pushReplacement('/');
                        context.read<FetchNovelsCubit>().fetchNovels();
                      },
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: SubTitleTextWidget(
                        lebal: "التصنيفات",
                        color: Colors.purple,
                      ),
                    ),
                    buildMenuItems(
                      context: context,
                      categorys: state.cateorys,
                    ),
                    Visibility(
                      visible: notyAloow,
                      child: ListTile(
                        leading: const Icon(Icons.notifications_active),
                        title: Text(
                          "تفعيل الاشعارات",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.blue,
                          ),
                        ),
                        onTap: () async {
                          requestTONotification(context);
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'مواقع التواصل الاجتماعي',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.blue,
                        ),
                      ),
                      leading: const Icon(Icons.person),
                      tileColor: Colors.transparent,
                      onTap: () {
                        socialMediaAccountsBottomSheet(context);
                      },
                    ),
                    ListTile(
                      title: Text(
                        'الاكثر قراءة',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.red,
                        ),
                      ),
                      leading: const Icon(Icons.watch_later),
                      tileColor: Colors.transparent,
                      onTap: () {
                        context.pushReplacement(
                          AppRouter.kSelectedCategoryView,
                          extra: 'الاكثر قراءة',
                        );
                        context.read<FetchNovelsCubit>().fetchFilterNovels();
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.comment),
                      title: Text(
                        "التعليقات",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.purple,
                        ),
                      ),
                      onTap: () {
                        context.push(AppRouter.kCommentView);
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (state is FetchCategoryFailure) {
            return CustomErrorWidget(errMessage: state.errMessage);
          } else {
            return const CustomLoadingIndecator();
          }
        }),
      ),
    );
  }
}
