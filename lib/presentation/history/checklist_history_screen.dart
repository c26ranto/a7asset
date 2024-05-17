import 'package:assets_mobile/presentation/history/provider/history_provider.dart';
import 'package:assets_mobile/presentation/shift/provider/shift_provider.dart';
import 'package:assets_mobile/presentation/widgets/background_image_image.dart';
import 'package:assets_mobile/presentation/widgets/custom_appbar_widget.dart';
import 'package:assets_mobile/presentation/widgets/custom_long_card_widget.dart';
import 'package:assets_mobile/utils/app_bottom_sheet.dart';
import 'package:assets_mobile/utils/app_colors.dart';
import 'package:assets_mobile/utils/app_dialog.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:assets_mobile/utils/app_text_Style.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChecklistHistoryScreen extends ConsumerStatefulWidget {
  const ChecklistHistoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChecklistHistoryScreenState();
}

class _ChecklistHistoryScreenState extends ConsumerState<ChecklistHistoryScreen> {
  final _machineIdC = TextEditingController();

  @override
  void dispose() {
    _machineIdC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final startDate = ref.watch(startDateProvider);
    final endDate = ref.watch(endDateProvider);

    final checklistPeriod = ref.watch(getChecklistPeriodProvider);

    return Scaffold(
      appBar: CustomAppbarWidget(
        isCenter: true,
        title: "Checklist History",
        titleStye: AppTextStyle.subTitleTextStyle.copyWith(fontWeight: FontWeight.w700, color: Colors.white),
      ),
      body: Stack(
        children: [
          const BackgroundImageWidget(),
          SafeArea(
            top: false,
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const _ItemChecklistHistory(icon: Icons.layers, title: "Type:", value: "DAILY"),
                      _ItemChecklistHistory(icon: Icons.layers, title: "Start Date:", value: startDate),
                      _ItemChecklistHistory(icon: Icons.layers, title: "End Date:", value: endDate),
                    ],
                  ),
                ),
                20.h,
                checklistPeriod.when(
                  data: (data) => ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) => CustomLongCardWidget(
                      title: data[index]["mtmtnm"],
                      onTap: () async {
                        AppPrint.debugLog(data[index].toString());

                        await AppDialog.popupScan(context, data[index]["mtmtcdiy"].toString(), _machineIdC);
                      },
                      icon: const Icon(
                        Icons.fact_check,
                        size: 30,
                      ),
                    ),
                  ),
                  error: (error, stackTrace) => const SizedBox(),
                  loading: () => const SizedBox(),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () async {
          final future = AppBottomSheet.showAddFilter(context);
          future.then((value) => AppBottomSheet.closeModal(value, ref));
        },
        child: Container(
          height: 56,
          width: 100,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.blue,
          ),
          child: Center(
            child: Row(
              children: [
                const Icon(
                  Icons.sort_rounded,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Filter",
                  style: AppTextStyle.subTitleTextStyle.copyWith(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemChecklistHistory extends StatelessWidget {
  const _ItemChecklistHistory({super.key, required this.title, required this.value, required this.icon});

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.textDisableColor,
        ),
        5.w,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Text(value),
          ],
        ),
      ],
    );
  }
}
