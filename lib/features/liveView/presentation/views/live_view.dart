import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rwayat/features/liveView/presentation/manger/cubit/live_cubit.dart';
import '../widgets/live_view_body.dart';

class LiveView extends StatelessWidget {
  const LiveView({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        log('hello mather funcker');
        context.read<LiveCubit>().getLiveurl();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('بث مباشر'),
          centerTitle: true,
        ),
        body: LiveViewBody(url: url),
      ),
    );
  }
}
