import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/custom_error_widget.dart';
import '../../../../../core/utils/custom_loading_indecator.dart';
import '../../../../../core/utils/title_text.dart';
import '../../../../home/presentation/manger/fetch_novels_cubit/fetch_novels_cubit.dart';
import '../../../../home/presentation/widgets/item_widget.dart';

class SelectedCategoryViewBody extends StatelessWidget {
  const SelectedCategoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchNovelsCubit, FetchNovelsState>(
      builder: (context, state) {
        if (state is FetchFilterNovelsSuccess) {
          return state.novels.isEmpty
              ? const Center(
                  child: TitleTextWidget(
                    lebal: "لا يوجد روايات هنا",
                  ),
                )
              : GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.64 / 3,
                  ),
                  itemCount: state.novels.length,
                  itemBuilder: (context, i) {
                    return ItemWidget(
                      novel: state.novels[i],
                      kindOfNovel: 'مكتوب',
                    );
                  },
                );
        } else if (state is FetchFilterNovelsFailure) {
          return CustomErrorWidget(errMessage: state.errMessage);
        } else {
          return const CustomLoadingIndecator();
        }
      },
    );
  }
}
