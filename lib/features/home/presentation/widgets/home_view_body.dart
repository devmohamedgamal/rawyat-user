import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/custom_error_widget.dart';
import '../../../../core/utils/custom_loading_indecator.dart';
import '../manger/fetch_novels_cubit/fetch_novels_cubit.dart';
import 'home_top_category.dart';
import 'item_widget.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchNovelsCubit, FetchNovelsState>(
        builder: (context, state) {
      if (state is FetchNovelsSuccess) {
        List<QueryDocumentSnapshot> soundNovels = [];
        List<QueryDocumentSnapshot> novels = [];

        for (var nov in state.novels) {
          if (nov['kind'] == 'صوت') {
            soundNovels.add(nov);
          } else {
            novels.add(nov);
          }
        }
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const HomeTopCategory(),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  'روايات صوتية',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 160.h,
                child: soundNovels.isEmpty
                    ? Center(
                        child: Text(
                          'لا يوجد روايات صوتية',
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: soundNovels.length,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, i) {
                          return ItemWidget(
                            novel: soundNovels[i],
                            kindOfNovel: 'صوت',
                          );
                        },
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  'روايات كتابية',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.64 / 3,
                  ),
                  itemCount: novels.length,
                  itemBuilder: (context, i) {
                    return ItemWidget(
                      novel: novels[i],
                      kindOfNovel: 'مكتوب',
                    );
                  },
                ),
              ),
            ],
          ),
        );
      } else if (state is FetchNovelsFailure) {
        return CustomErrorWidget(errMessage: state.errMessage);
      } else if (state is FetchNovelsLoading) {
        return const CustomLoadingIndecator();
      } else {
        return const CustomErrorWidget(errMessage: "Else error ");
      }
    });
  }
}
