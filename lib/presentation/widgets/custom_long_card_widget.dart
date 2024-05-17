import 'package:assets_mobile/utils/app_colors.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter/material.dart';

class CustomLongCardWidget extends StatelessWidget {
  CustomLongCardWidget(
      {super.key,
      required this.title,
      this.isChoose = false,
      this.color = Colors.white,
      this.titleStye,
      this.textLeading,
      this.textLeadingStyle,
      this.border,
      this.icon,
      required this.onTap});

  final String title;
  final bool isChoose;
  final Icon? icon;
  void Function()? onTap;

  final TextStyle? titleStye;

  final String? textLeading;
  final TextStyle? textLeadingStyle;

  final BoxBorder? border;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
          border: border,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              icon ??
                  const Icon(
                    Icons.checklist,
                    size: 18,
                    color: Colors.black,
                  ),
              10.w,
              Text(
                title.toUpperCase(),
                style: titleStye,
              ),
              const Spacer(),
              if (isChoose)
                const Icon(
                  Icons.check,
                  size: 18,
                  color: AppColors.bgColor,
                ),
              if (textLeading != null)
                Text(
                  textLeading!,
                  style: textLeadingStyle,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
