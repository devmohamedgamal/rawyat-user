import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'widgets/novel_details_view_body.dart';

class NovelDetailsView extends StatelessWidget {
  const NovelDetailsView({super.key, required this.novel, required this.index});
  final QueryDocumentSnapshot novel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          novel['name'],
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: NovelDetailsViewBody(
        novel: novel,
        index: index,
      ),
    );
  }
}
