import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rwayat/core/functions/appodeal.dart';
import 'package:rwayat/core/utils/assets_manger.dart';
import 'package:rwayat/core/utils/custom_error_widget.dart';
import 'package:rwayat/core/utils/custom_loading_indecator.dart';
import 'package:rwayat/features/liveView/presentation/manger/cubit/live_cubit.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/functions/global_var.dart';
import '../../../../core/functions/helper_func.dart';

class LiveViewBody extends StatefulWidget {
  const LiveViewBody({super.key, required this.url});
  final String url;

  @override
  State<LiveViewBody> createState() => _LiveViewBodyState();
}

class _LiveViewBodyState extends State<LiveViewBody> {
  late WebViewController _controller;
  @override
  void initState() {
    context.read<LiveCubit>().getEmojeAdsCounter();
    AppodealFunc.loadBannerAd();
    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..loadRequest(Uri.parse(widget.url));
    _controller = controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: WebViewWidget(controller: _controller)),
        BlocBuilder<LiveCubit, LiveState>(
          builder: (context, state) {
            if (state is EmojeAdsCounterSuccess) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: AssetsManger.icons.length,
                  padding: const EdgeInsets.only(left: 20),
                  itemBuilder: (context, i) {
                    return ValueListenableBuilder(
                        valueListenable:
                            Hive.box<AdsCounter>('adsCounter').listenable(),
                        builder: (context, Box<AdsCounter> box, child) {
                          final adsCounterVar = box.get(0) ?? AdsCounter();
                          final variableValue = adsCounterVar
                                  .adsCounterMap[AssetsManger.icons[i]]
                                  ?.values
                                  .first ??
                              0;
                          return IconButton(
                            onPressed: () {
                              if (variableValue == state.adsCounter) {
                                adsCounterVar
                                    .adsCounterMap[AssetsManger.icons[i]] = {
                                  'counter': 0,
                                };
                                box.put(0, adsCounterVar);
                              }
                              adsCounter(
                                context: context,
                                counter: variableValue,
                                closeAd: () {},
                                incresCounter: () {
                                  adsCounterVar
                                      .adsCounterMap[AssetsManger.icons[i]] = {
                                    'counter': variableValue + 1
                                  };
                                  box.put(0, adsCounterVar);
                                  log('incress 1 count');
                                },
                                adsCounter: state.adsCounter,
                              );
                            },
                            icon: SvgPicture.asset(
                              AssetsManger.icons[i],
                              height: 60,
                            ),
                          );
                        });
                  },
                ),
              );
            } else if (state is EmojeAdsCounterLoading) {
              return const CustomLoadingIndecator();
            } else {
              return const CustomErrorWidget(errMessage: 'errMessage');
            }
          },
        ),
        SizedBox(
          height: 50.h,
          child: const AppodealBanner(
            adSize: AppodealBannerSize.BANNER,
            placement: "default",
          ),
        ),
      ],
    );
  }
}
