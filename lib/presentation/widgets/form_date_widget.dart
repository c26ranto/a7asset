import 'package:assets_mobile/presentation/widgets/custom_formfield_widget.dart';
import 'package:assets_mobile/utils/app_colors.dart';
import 'package:assets_mobile/utils/app_text_Style.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter/material.dart';

class FormFieldDateWidget extends StatelessWidget {
  const FormFieldDateWidget(
      {super.key, required this.title, required this.label, this.icon, this.disabled, this.onTap, this.fill, this.outlineBorder, this.fillColor});

  final String label;
  final String title;

  final bool? fill;
  final Color? fillColor;
  final InputBorder? outlineBorder;
  final bool? disabled;

  final Widget? icon;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.lightBlue.withOpacity(0.3),
            ),
            child: Center(
                child: icon ??
                    const Icon(
                      Icons.date_range_outlined,
                      size: 18,
                      color: Colors.white,
                    )),
          ),
          15.w,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.subTitleTextStyle.copyWith(color: Colors.white),
                ),
                7.h,
                CustomFormfieldWidget(
                  enabled: disabled,
                  fill: fill,
                  fillColor: fillColor,
                  outlineBorder: outlineBorder,
                  titleStyle: AppTextStyle.commonTextStyle.copyWith(
                    color: AppColors.borderColor,
                  ),
                  label: label,
                  conditionColor: false,
                  labelStyle: AppTextStyle.commonTextStyle.copyWith(
                    color: AppColors.borderColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
