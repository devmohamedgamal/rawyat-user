import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/custom_error_widget.dart';
import '../../../../core/utils/custom_loading_indecator.dart';
import '../../../../core/utils/title_text.dart';
import '../../../liveView/presentation/manger/cubit/live_cubit.dart';
import '../manger/fetch_novels_cubit/fetch_novels_cubit.dart';

class HomeTopCategory extends StatelessWidget {
  const HomeTopCategory({super.key});

  @override
  Widget build(BuildContext context) {
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
                          extra: state.liveUrl['liveUrl']);
                    },
                    child: Visibility(
                      visible: state.liveUrl['liveState'],
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
                    ),
                  );
                } else if (state is LiveLoading) {
                  return const CustomLoadingIndecator();
                } else {
                  return const CustomErrorWidget(errMessage: 'errMessage');
                }
              },
            ),
            GestureDetector(
              onTap: () {
                context.pushReplacement(
                  AppRouter.kSelectedCategoryView,
                  extra: 'روايات صوتية',
                );
                context
                    .read<FetchNovelsCubit>()
                    .fetchFilterNovels(category: 'روايات صوتية');
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                width: 140.w,
                height: 30.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2.w),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: const Align(
                  alignment: Alignment.center,
                  child: TitleTextWidget(
                    lebal: 'روايات صوتية',
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.pushReplacement(
                  AppRouter.kSelectedCategoryView,
                  extra: 'روايات كتابية',
                );
                context
                    .read<FetchNovelsCubit>()
                    .fetchFilterNovels(category: 'روايات كتابية');
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                width: 140.w,
                height: 30.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2.w),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: const Align(
                  alignment: Alignment.center,
                  child: TitleTextWidget(
                    lebal: 'روايات كتابية',
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
