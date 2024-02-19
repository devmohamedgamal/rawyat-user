import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/custom_text_form_field.dart';

class CustomDynamicTextField extends StatefulWidget {
  const CustomDynamicTextField(
      {super.key,
      required this.categoryName,
      required this.categoryNamesCallback,
      this.editCategorys});
  final TextEditingController categoryName;
  final Function categoryNamesCallback;
  final List? editCategorys;

  @override
  State<CustomDynamicTextField> createState() => _CustomDynamicTextFieldState();
}

class _CustomDynamicTextFieldState extends State<CustomDynamicTextField> {
  List<String> categoryNames = [];

  getCategory(var categorys) {
    if (widget.editCategorys != null) {
      for (var category in categorys) {
        categoryNames.add(category);
      }
      widget.categoryNamesCallback(categoryNames);
    }
  }

  @override
  void initState() {
    getCategory(widget.editCategorys);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: CustomTextFormField(
            hint: "اسم الصنف",
            controller: widget.categoryName,
          ),
          trailing: ElevatedButton(
            onPressed: () {
              categoryNames.add(widget.categoryName.text);
              widget.categoryName.clear();
              widget.categoryNamesCallback(categoryNames);

              setState(() {});
            },
            child: const Text('Add'),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        SizedBox(
          height: categoryNames.isEmpty ? 0 : 100.h,
          child: GridView.builder(
              itemCount: categoryNames.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 2,
              ),
              itemBuilder: (context, i) {
                return categoryNames.isEmpty
                    ? Container()
                    : Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(categoryNames[i]),
                              IconButton(
                                onPressed: () {
                                  categoryNames.remove(categoryNames[i]);
                                  widget.categoryNamesCallback(categoryNames);
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 20,
                                ),
                              ),
                            ]),
                      );
              }),
        ),
      ],
    );
  }
}
