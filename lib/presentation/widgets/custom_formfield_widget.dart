import 'package:assets_mobile/utils/app_colors.dart';
import 'package:assets_mobile/utils/app_text_Style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormfieldWidget extends StatelessWidget {
  const CustomFormfieldWidget(
      {super.key,
      required this.conditionColor,
      this.disabledBorder,
      this.prefixIcon,
      this.titleStyle,
      this.labelStyle,
      this.height,
      this.width,
      this.suffixIcon,
      this.outlineBorder,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.validator,
      this.isObsecure,
      this.enabled,
      this.title,
      this.isPassword = false,
      this.onPressedObsecure,
      this.controller,
      this.fill,
      this.inputFormatters,
      this.fillColor,
      required this.label});

  final String label;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? conditionColor;
  final TextStyle? titleStyle;
  final TextStyle? labelStyle;
  final InputBorder? disabledBorder;
  final InputBorder? outlineBorder;

  final double? width;
  final double? height;

  final bool? fill;
  final Color? fillColor;

  final TextEditingController? controller;
  final bool? enabled;

  final bool? isPassword;
  final bool? isObsecure;
  final VoidCallback? onPressedObsecure;

  final String? title;

  final FormFieldValidator<String>? validator;
  final CrossAxisAlignment crossAxisAlignment;

  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        if (title != null)
          Text(
            title!,
            style: AppTextStyle.commonTextStyle,
          ),
        TextFormField(
          enabled: enabled,
          controller: controller,
          validator: validator,
          obscureText: isObsecure ?? false,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            filled: fill,
            fillColor: fillColor,
            hintText: label,
            hintStyle: labelStyle ??
                AppTextStyle.commonTextStyle.copyWith(
                  color: conditionColor != null && conditionColor!
                      ? Colors.white
                      : Colors.grey.shade300,
                  fontWeight: conditionColor != null && conditionColor!
                      ? FontWeight.w500
                      : FontWeight.w200,
                  fontSize: 12,
                ),
            prefixIcon: prefixIcon,
            suffixIcon: isPassword == false
                ? null
                : suffixIcon ??
                    IconButton(
                        onPressed: onPressedObsecure,
                        icon: const Icon(Icons.visibility)),
            border: outlineBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    color: AppColors.borderColor,
                  ),
                ),
            disabledBorder: disabledBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    color: AppColors.borderColor,
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
