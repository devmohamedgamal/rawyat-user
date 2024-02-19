import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget({
    super.key,
    this.fontSize = 20,
    this.fontWeight = FontWeight.bold,
    this.color,
    this.fontStyle = FontStyle.normal,
    this.textDecoration = TextDecoration.none,
    required this.lebal,
    this.maxLine,
    this.height = 1,
    this.shadows, this.onTap,
  });
  final String lebal;
  final double fontSize, height;
  final FontWeight? fontWeight;
  final Color? color;
  final FontStyle fontStyle;
  final TextDecoration textDecoration;
  final int? maxLine;
  final List<Shadow>? shadows;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        lebal,
        maxLines: maxLine,
        textAlign: TextAlign.center,
        style: TextStyle(
          height: height,
          fontSize: fontSize.sp,
          fontWeight: fontWeight,
          color: color,
          fontStyle: fontStyle,
          decoration: textDecoration,
          overflow: TextOverflow.ellipsis,
          shadows: shadows,
        ),
      ),
    );
  }
}
