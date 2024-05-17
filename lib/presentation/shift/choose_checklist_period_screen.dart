import 'package:assets_mobile/data/models/cutom_error.dart';
import 'package:assets_mobile/data/models/shift_model.dart';
import 'package:assets_mobile/presentation/shift/provider/shift_provider.dart';
import 'package:assets_mobile/presentation/widgets/background_image_image.dart';
import 'package:assets_mobile/presentation/widgets/custom_appbar_widget.dart';
import 'package:assets_mobile/presentation/widgets/custom_error_widget.dart';
import 'package:assets_mobile/presentation/widgets/custom_long_card_widget.dart';
import 'package:assets_mobile/presentation/widgets/loading_shimmer.dart';
import 'package:assets_mobile/utils/app_dialog.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:assets_mobile/utils/app_text_Style.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChooseChecklistPeriodScreen extends ConsumerStatefulWidget {
  const ChooseChecklistPeriodScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChooseChecklistPeriodScreenState();
}

class _ChooseChecklistPeriodScreenState extends ConsumerState<ChooseChecklistPeriodScreen> {
  final _machineIdC = TextEditingController();

  @override
  void dispose() {
    _machineIdC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final checklistPeriod = ref.watch(getChecklistPeriodProvider);
    final dataShift = ref.watch(dataShiftProvider);

    return Scaffold(
      appBar: CustomAppbarWidget(
        isCenter: true,
        title: "Choose Checklist Period",
        titleStye: AppTextStyle.subTitleTextStyle.copyWith(fontWeight: FontWeight.w700, color: Colors.white),
      ),
      body: Stack(
        children: [
          const BackgroundImageWidget(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Table(
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(),
                    1: FixedColumnWidth(500),
                  },
                  children: [
                    TableRow(
                      children: [
                        Text(
                          "DATE",
                          style: AppTextStyle.subTitleTextStyle.copyWith(color: Colors.white),
                        ),
                        Text(
                          ": ${dataShift.date}",
                          style: AppTextStyle.subTitleTextStyle.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text(
                          "SHIFT",
                          style: AppTextStyle.subTitleTextStyle.copyWith(color: Colors.white),
                        ),
                        Text(
                          ": ${dataShift.title}",
                          style: AppTextStyle.subTitleTextStyle.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                20.h,
                checklistPeriod.when(
                  data: (data) {
                    if (data.isEmpty) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Center(
                          child: Text(
                            "Data tidak ada tersedia, silahkan coba lagi!",
                            style: AppTextStyle.subTitleTextStyle.copyWith(color: Colors.white),
                          ),
                        ),
                      );
                    }
                    return Expanded(
                        child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) => CustomLongCardWidget(
                        title: data[index]["mtmtnm"],
                        onTap: () async {
                          AppPrint.debugLog("SHIFFT: ${data[index]}");
                          final shiftModel = ShiftModel(date: dataShift.date, id: dataShift.id, title: dataShift.title, period: data[index]["mtmtnm"]);
                          ref.read(dataShiftProvider.notifier).update((state) => shiftModel);
                          AppDialog.popupScan(context, data[index]["mtmtcdiy"].toString(), _machineIdC);
                        },
                        icon: const Icon(
                          Icons.fact_check,
                          size: 30,
                        ),
                      ),
                    ));
                  },
                  error: (error, stackTrace) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Center(
                      child: CustomErrorWidget(
                        customErrorWidgetType: CustomErrorWidgetType.widget,
                        errorMessage: (error as CustomError).errorMessage,
                        errorMessageStyle: AppTextStyle.subTitleTextStyle.copyWith(color: Colors.white),
                        action: () {
                          ref.invalidate(getChecklistPeriodProvider);
                        },
                      ),
                    ),
                  ),
                  loading: () => LoadingShimmerWidget(itemCount: 3, height: 64, width: MediaQuery.of(context).size.width),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
