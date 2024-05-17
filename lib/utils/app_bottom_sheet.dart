import 'package:assets_mobile/presentation/history/provider/history_provider.dart';
import 'package:assets_mobile/presentation/widgets/button_widget.dart';
import 'package:assets_mobile/utils/app_colors.dart';
import 'package:assets_mobile/utils/app_text_Style.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AppBottomSheet {
  static void closeModal(void value, WidgetRef ref) {
    ref.invalidate(startDateBottomSheetProvider);
    ref.invalidate(endDateBottomSheetProvider);
  }

  static Future<void> showAddFilter(BuildContext context) async {
    await showModalBottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Consumer(builder: (context, ref, child) {
            final startDate = ref.watch(startDateBottomSheetProvider);
            final endDate = ref.watch(endDateBottomSheetProvider);
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          Text(
                            "Filter",
                            style: AppTextStyle.subTitleTextStyle.copyWith(),
                          ),
                          const SizedBox(width: 26),
                          InkWell(
                            onTap: () {
                              ref.read(startDateBottomSheetProvider.notifier).update((state) => DateTime.now().formatDate);
                              ref.read(endDateBottomSheetProvider.notifier).update((state) => DateTime.now().formatDate);
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.refresh, color: Colors.red),
                                const SizedBox(width: 5),
                                Text(
                                  "Reset Filter",
                                  style: AppTextStyle.commonTextStyle.copyWith(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Checklist type",
                    style: AppTextStyle.commonTextStyle.copyWith(
                      color: AppColors.textDisableColor,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        "Machine",
                        style: AppTextStyle.subTitleTextStyle.copyWith(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            style: AppTextStyle.commonTextStyle.copyWith(),
                            decoration: InputDecoration(
                                hintText: "",
                                filled: true,
                                fillColor: AppColors.borderColor.withOpacity(0.3),
                                prefixIcon: const Icon(Icons.settings, color: AppColors.textDisableColor),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIconColor: AppColors.textDisableColor),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        // CustomButton(
                        //     text: "",
                        //     onpress: () async {
                        //       dynamic hasil = await popupDataA5(context, 'cEQUIMP', 'e1e1noiy', 'e1equi', 'e1asno', '', '', {});
                        //       if (hasil != null) {
                        //         mesin.text = hasil['code'] + " - " + hasil['name'];
                        //         mesin_iy = hasil['iy'];
                        //       }
                        //     },
                        //     radius: BorderRadius.circular(10.0),
                        //     icon: Icons.search,
                        //     isLoading: false),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Start Date",
                    style: AppTextStyle.commonTextStyle.copyWith(),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    readOnly: true,
                    onTap: () async {
                      DateTime? dt = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          lastDate: DateTime(int.parse(DateFormat('yyyy').format(DateTime.now())) + 1));

                      if (dt != null) {
                        ref.read(startDateBottomSheetProvider.notifier).update((state) => dt.formatDate);
                      }
                    },
                    style: AppTextStyle.subTitleTextStyle.copyWith(),
                    decoration: InputDecoration(
                        hintText: startDate,
                        filled: true,
                        fillColor: AppColors.borderColor.withOpacity(0.3),
                        prefixIcon: const Icon(Icons.calendar_month, color: AppColors.textDisableColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        prefixIconColor: AppColors.textDisableColor),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "End Date",
                    style: AppTextStyle.commonTextStyle.copyWith(),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    readOnly: true,
                    onTap: () async {
                      DateTime? dt = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          lastDate: DateTime(int.parse(DateFormat('yyyy').format(DateTime.now())) + 1));

                      if (dt != null) {
                        ref.read(endDateBottomSheetProvider.notifier).update((state) => dt.formatDate);
                      }
                    },
                    style: AppTextStyle.subTitleTextStyle.copyWith(),
                    decoration: InputDecoration(
                        hintText: endDate,
                        filled: true,
                        fillColor: AppColors.borderColor.withOpacity(0.3),
                        prefixIcon: const Icon(Icons.calendar_month, color: AppColors.textDisableColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        prefixIconColor: AppColors.textDisableColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // PrimaryButton(
                  //     text: "APPLY",
                  //     icon: Icons.search,
                  //     onpress: () {
                  //       setState(() {
                  //         tanggal_a = tgl_a.text;
                  //         tanggal_b = tgl_b.text;
                  //         Navigator.pop(context);
                  //       });
                  //       getChecklistData();
                  //     },
                  //     is_loading: false),
                  ButtonReusableWidget(onPressed: () {}, title: "APPLY"),

                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          });
        });
  }
}
