import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/custom_loading_indecator.dart';
import '../../../../../core/utils/title_text.dart';
import '../../../../home/presentation/widgets/item_widget.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(keyCollectionNovels)
          .snapshots(),
      builder: (context, snapshot) {
        List<QueryDocumentSnapshot> searchFilms = [];
        if (snapshot.connectionState != ConnectionState.waiting) {
          for (var item in snapshot.data!.docs) {
            if (item['name'].toString().toLowerCase().contains(
                  name.toLowerCase(),
                )) {
              searchFilms.add(item);
            }
          }
        } else {
          const CustomLoadingIndecator();
        }
        return (snapshot.connectionState == ConnectionState.waiting
            ? const CustomLoadingIndecator()
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.63 / 3,
                  ),
                  itemCount: searchFilms.length,
                  itemBuilder: (context, i) {
                    if (searchFilms.isNotEmpty) {
                      return ItemWidget(
                        novel: searchFilms[i],
                        kindOfNovel: 'مكتوب',
                      );
                    } else {
                      return const Center(
                        child: TitleTextWidget(lebal: 'ابحث علي ما تريد'),
                      );
                    }
                  },
                ),
              ));
      },
    );
  }
}
