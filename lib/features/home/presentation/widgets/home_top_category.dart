import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/custom_error_widget.dart';
import '../../../../core/utils/custom_loading_indecator.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../../core/utils/title_text.dart';
import '../../../liveView/presentation/manger/cubit/live_cubit.dart';
import '../../../selcted_cateory/presentation/manger/fetch_top_category_cubit/fetch_top_category_cubit.dart';
import '../manger/fetch_novels_cubit/fetch_films_cubit.dart';

class HomeTopCategory extends StatelessWidget {
  const HomeTopCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchTopCategoryCubit, FetchTopCategoryState>(
        listener: (context, state) {
      if (state is DeleteTopCategorySuccess) {
        context.read<FetchTopCategoryCubit>().fetchTopCategory();
        customSnackBar(context, "تم الحذف");
      }
    }, builder: (context, state) {
      if (state is FetchTopCategorySuccess) {
        return SizedBox(
            height: 30.h,
            child: Row(
              children: [
                BlocBuilder<LiveCubit, LiveState>(
                  builder: (context, state) {
                    if (state is LiveSuccess) {
                      return InkWell(
                        onTap: () {
                          context.push(AppRouter.kLiveView,
                              extra: state.liveUrl);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          width: 100.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2.w),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: TitleTextWidget(
                              lebal: 'بث مباشر',
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
                    } else if (state is LiveLoading) {
                      return const CustomLoadingIndecator();
                    } else {
                      return const CustomErrorWidget(errMessage: 'errMessage');
                    }
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.topCateorys.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          context.push(
                            AppRouter.kSelectedCategoryView,
                            extra: state.topCateorys[i]['name'],
                          );
                          context.read<FetchNovelsCubit>().fetchFilterNovels(
                              category: state.topCateorys[i]['name']);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          width: 100.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2.w),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: TitleTextWidget(
                              lebal: state.topCateorys.length != 1
                                  ? state.topCateorys[i]['name']
                                  : state.topCateorys[0]['name'],
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ));
      } else if (state is FetchTopCategoryFailure) {
        return CustomErrorWidget(errMessage: state.errMessage);
      } else {
        return const CustomLoadingIndecator();
      }
    });
  }
}
