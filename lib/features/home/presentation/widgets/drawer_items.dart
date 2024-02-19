import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_router.dart';
import '../manger/fetch_novels_cubit/fetch_films_cubit.dart';

int categoryIndex = 0;

Widget buildMenuItems(
        {required BuildContext context,
        required List<QueryDocumentSnapshot> categorys}) =>
    Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: categorys.length,
          itemBuilder: (context, i) {
            return ListTile(
              title: Text(
                categorys[i]['name'],
                style: TextStyle(
                  fontSize: 20.sp,
                ),
              ),
              tileColor: categoryIndex == i + 1
                  ? Colors.grey.withOpacity(0.4)
                  : Colors.transparent,
              onTap: () {
                categoryIndex = i + 1;
                context.pushReplacement(
                  AppRouter.kSelectedCategoryView,
                  extra: categorys[i]['name'],
                );
                context
                    .read<FetchNovelsCubit>()
                    .fetchFilterNovels(category: categorys[i]['name']);
              },
            );
          }),
    );
