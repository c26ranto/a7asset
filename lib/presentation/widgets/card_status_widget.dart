import 'package:assets_mobile/utils/app_enums.dart';
import 'package:assets_mobile/utils/app_text_Style.dart';
import 'package:flutter/material.dart';

class CardStatusWidget extends StatelessWidget {
  const CardStatusWidget({super.key, required this.label, required this.value, required this.type});

  final String label;
  final String value;
  final CardStatusType type;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                color: (() {
                  if (type == CardStatusType.total) {
                    return Colors.black54;
                  } else if (type == CardStatusType.done) {
                    return Colors.green;
                  } else {
                    return Colors.red;
                  }
                }()),
              ),
              child: Center(
                child: Text(
                  label,
                  style: AppTextStyle.commonTextStyle.copyWith(color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: Text(
                  value,
                  style: AppTextStyle.subTitleTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
