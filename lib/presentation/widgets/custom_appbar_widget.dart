import 'package:assets_mobile/utils/app_colors.dart';
import 'package:assets_mobile/utils/app_text_Style.dart';
import 'package:flutter/material.dart';

class CustomAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbarWidget({required this.title, this.titleSpacing, this.isCenter, this.titleStye, this.iconThemeData, this.actions, this.leading, super.key});

  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final IconThemeData? iconThemeData;
  final double? titleSpacing;
  final TextStyle? titleStye;
  final bool? isCenter;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: isCenter,
      title: Text(
        title,
        style: titleStye ??
            AppTextStyle.subTitleTextStyle.copyWith(
              color: Colors.white,
            ),
      ),
      leading: leading,
      actions: actions,
      iconTheme: iconThemeData ?? const IconThemeData(color: Colors.white, size: 18),
      titleSpacing: 1,
      backgroundColor: AppColors.appBarColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
