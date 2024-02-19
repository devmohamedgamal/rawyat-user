import 'package:flutter/material.dart';

import 'comments_view_body.dart';

class CommentsView extends StatelessWidget {
  const CommentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('التعليقات'),
        centerTitle: true,
      ),
      body: const CommentsViewBody(),
    );
  }
}