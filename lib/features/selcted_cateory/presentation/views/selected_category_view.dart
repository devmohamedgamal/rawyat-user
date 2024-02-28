import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/presentation/manger/fetch_novels_cubit/fetch_novels_cubit.dart';
import '../../../home/presentation/widgets/custom_navigation_drawer.dart';
import 'widgets/selected_category_view_body.dart';

class SelectedCategoryView extends StatelessWidget {
  const SelectedCategoryView({super.key, required this.nameOfCateory});
  final String nameOfCateory;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        log('hello mather funcker');
        context.read<FetchNovelsCubit>().fetchNovels();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(nameOfCateory),
          centerTitle: true,
        ),
        drawer: const CustomNavigationDrawer(),
        body: const SelectedCategoryViewBody(),
      ),
    );
  }
}
