import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.chevron_left,
          size: 34.sp,
        ),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      title: CommonText.textBoldWeight700(
        text: title,
        fontSize: 24.sp,
        color: Palette.blackColor,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.sp);
}
