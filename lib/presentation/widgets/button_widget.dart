import 'package:assets_mobile/utils/app_colors.dart';
import 'package:assets_mobile/utils/app_text_Style.dart';
import 'package:flutter/material.dart';

class ButtonReusableWidget extends StatelessWidget {
  const ButtonReusableWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.height,
    this.width,
    this.disabled,
    this.textStyle,
    this.padding,
    this.backgroundColor,
  });

  final String title;
  final VoidCallback onPressed;

  final double? width;
  final double? height;
  final bool? disabled;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: disabled != null && disabled == true ? null : onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize:
              Size(width ?? MediaQuery.sizeOf(context).width, height ?? 50),
          padding: padding ?? const EdgeInsets.symmetric(vertical: 8),
          backgroundColor: backgroundColor ?? AppColors.thirdColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: textStyle ??
                AppTextStyle.subTitleTextStyle.copyWith(
                  color: Colors.white,
                ),
          ),
        ));
  }
}
