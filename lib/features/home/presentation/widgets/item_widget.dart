import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../../core/functions/global_var.dart';
import '../../../../core/functions/helper_func.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/assets_manger.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/subtitle_text.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.novel, required this.kindOfNovel});
  final QueryDocumentSnapshot? novel;
  final String kindOfNovel;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<AdsCounter>('adsCounter').listenable(),
      builder: (context, Box<AdsCounter> box, child) {
        final adsCounterVar = box.get(0) ?? AdsCounter();
        final variableValue =
            adsCounterVar.adsCounterMap[novel?['name']]?.values.first ?? 0;
        return InkWell(
          onTap: () {
            if (variableValue == novel?['adsCounter']) {
              adsCounterVar.adsCounterMap[novel?['name']] = {
                'counter': 0,
              };
              box.put(0, adsCounterVar);
            }
            adsCounter(
              context: context,
              counter: variableValue,
              closeAd: () {
                context.push(AppRouter.kNovelDetailsView, extra: {
                  'novel': novel,
                  'index': 0,
                });
              },
              incresCounter: () {
                adsCounterVar.adsCounterMap[novel?['name']] = {
                  'counter': variableValue + 1
                };
                box.put(0, adsCounterVar);
                log('incress 1 count');
              },
              adsCounter: novel?['adsCounter'] ?? 1,
            );
          },
          child: SizedBox(
            height: kindOfNovel == 'صوت' ? 150.h : 260.h,
            width: kindOfNovel == 'صوت' ? 120.h : 150.w,
            child: Card(
              color: Colors.transparent,
              elevation: 0,
              child: Column(
                children: [
                  SizedBox(
                    height: kindOfNovel == 'صوت' ? 120.h : 200.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Hero(
                        tag: novel?['name'] ?? 'لا يوجد اسم',
                        child: CachedNetworkImage(
                          imageUrl: novel?['image'] ?? kNetworkImageNotFound,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Image.asset(AssetsManger.noImageFound),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  SubTitleTextWidget(
                    lebal: novel?['name'] ?? 'ارض زيكولا',
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
