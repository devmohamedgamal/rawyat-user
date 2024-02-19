import 'package:flutter/material.dart';

class BookmarkListViweItem extends StatelessWidget {
  const BookmarkListViweItem({super.key, required this.text, this.onTap});
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      splashColor: Colors.blue,
      // selectedColor: Colors.blue,
      onTap: onTap,
      tileColor: Colors.grey.withOpacity(0.4),
      title: SizedBox(
        width: 250,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
