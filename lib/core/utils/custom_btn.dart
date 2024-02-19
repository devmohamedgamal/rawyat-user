import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'subtitle_text.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    super.key,
    this.onTap,
    this.isLoading = false,
    required this.text,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    required this.width,
    required this.height,
    this.radius = 30,
    this.textSize,
  });
  final void Function()? onTap;
  final bool isLoading;
  final String text;
  final Color backgroundColor, textColor;
  final double width, height;
  final double radius;
  final double? textSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(radius)),
        child: Center(
          child: isLoading
              ? SizedBox(
                  height: 27.h,
                  width: 27.w,
                  child: const CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : SubTitleTextWidget(
                  lebal: text,
                  fontSize: textSize ?? 18.sp,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
        ),
      ),
    );
  }
}

class CustomIconBtn extends StatelessWidget {
  const CustomIconBtn({
    super.key,
    this.onTap,
    this.isLoading = false,
    required this.text,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    required this.icon,
    required this.width,
    required this.height,
    this.radius = 30,
    this.textSize,
  });
  final void Function()? onTap;
  final bool isLoading;
  final String text;
  final Color backgroundColor, textColor;
  final Widget icon;
  final double width, height, radius;
  final double? textSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.sp),
        child: Container(
          width: width,
          height: 50.h,
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(radius)),
          child: Center(
            child: isLoading
                ? SizedBox(
                    height: 27.h,
                    width: 27.w,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SubTitleTextWidget(
                        lebal: text,
                        fontSize: textSize ?? 18.sp,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      icon,
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
