import 'dart:convert';

import 'package:assets_mobile/data/models/auth_state.dart';
import 'package:assets_mobile/data/models/checklist_state.dart';
import 'package:assets_mobile/data/models/generate_clhead_state.dart';
import 'package:assets_mobile/presentation/checklist/provider/checklist_provider.dart';
import 'package:assets_mobile/presentation/scan/provider/scan_provider.dart';
import 'package:assets_mobile/presentation/shift/provider/shift_provider.dart';
import 'package:assets_mobile/presentation/widgets/background_image_image.dart';
import 'package:assets_mobile/presentation/widgets/button_widget.dart';
import 'package:assets_mobile/presentation/widgets/card_status_widget.dart';
import 'package:assets_mobile/presentation/widgets/custom_appbar_widget.dart';
import 'package:assets_mobile/presentation/widgets/custom_long_card_widget.dart';
import 'package:assets_mobile/presentation/widgets/loading_shimmer.dart';
import 'package:assets_mobile/route/route_name.dart';
import 'package:assets_mobile/route/route_provider.dart';
import 'package:assets_mobile/utils/app_dialog.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:assets_mobile/utils/app_text_Style.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ResultScanMachineScreen extends ConsumerStatefulWidget {
  const ResultScanMachineScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResultScanMachineScreenState();
}

class _ResultScanMachineScreenState
    extends ConsumerState<ResultScanMachineScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final machineId = ref.watch(idQrCodeProvider);
    final shift = ref.watch(dataShiftProvider);
    final model = ref.watch(modelProvider);
    final statusChecklist = ref.read(statusChecklistProvider);
    final partChecklist = ref.watch(partChecklistDataProvider);
    final dataGetChecklist = ref.watch(dataGetChecklistProvider);
    Widget prevChecklistWidget = const SizedBox.shrink();

    final checklistState = ref.watch(checklistProvider);

    ref.listen(getStatusMachineProvider, (previous, next) {
      switch (next.value?.status) {
        case AuthStatus.loading:
          Navigator.pop(context);
          AppDialog.loadingDialog(context);
          break;
        case AuthStatus.success:
          AppDialog.customDialog(context, "",
              barrierDismissible: false,
              title: Text(
                "Kondisi Mesin",
                style: AppTextStyle.subTitleTextStyle.copyWith(),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 250,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kondisi Mesin Saat Ini: ",
                      style: AppTextStyle.commonTextStyle.copyWith(),
                    ),
                    10.h,
                    next.when(
                      data: (data) {
                        final status = jsonDecode(data.result!);
                        return Expanded(
                            child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 8,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: status.length,
                          itemBuilder: (context, index) => ButtonReusableWidget(
                              onPressed: () async {
                                AppPrint.debugLog(
                                    "STATUS MACHINE: ${status[index]["tssycd"]}");
                                await ref
                                    .read(generateClheadProvider.notifier)
                                    .callGenerateClhead(
                                      machineNumber: machineId,
                                      shiftId: shift.id,
                                      period: shift.period,
                                      statusId: status[index]["tssycd"]
                                          .toString()
                                          .trim(),
                                    );
                                if (status[index]["tssycd"] == "1") {
                                  ref.read(routerProvider).pop();
                                  final shift = ref.read(dataShiftProvider);
                                  ref.read(tssycdProvider.notifier).update(
                                      (state) => status[index]["tssycd"]
                                          .toString()
                                          .trim());
                                  ref
                                      .read(dataGetChecklistProvider.notifier)
                                      .update((state) => {
                                            "id": machineId,
                                            "shiftId": shift.id,
                                            "period": shift.period,
                                            "statusId": status[index]["tssycd"]
                                                .toString()
                                                .trim(),
                                          });

                                  ref
                                      .read(checklistProvider.notifier)
                                      .callChecklist(
                                        id: machineId,
                                        shiftId: shift.id,
                                        period: shift.period,
                                        statusId: status[index]["tssycd"]
                                            .toString()
                                            .trim(),
                                      );
                                } else {
                                  ref.read(routerProvider).pop();
                                  if (mounted) {
                                    await Future.delayed(Duration.zero, () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Checklist disimpan...")));
                                      ref.read(routerProvider).pop();
                                    });
                                  }
                                }
                              },
                              title: "${status[index]["tssynm"]}"),
                        ));
                      },
                      error: (error, stackTrace) => const SizedBox(),
                      loading: () => const SizedBox(),
                    )
                  ],
                ),
              ),
              actions: []);
          break;
        case AuthStatus.failure:
          Navigator.pop(context);
          AppDialog.errorDialog(context, next.value!.error.errorMessage, () {});
        default:
      }
    });

    ref.listen<ChecklistState>(checklistProvider, (previous, next) {
      switch (next.status) {
        case ChecklistStatus.failure:
          setState(() {
            loading = false;
          });
          break;
        case ChecklistStatus.success:
          setState(() {
            loading = false;
          });
          AppPrint.debugLog("SUCCESS BOSKU: ${next.success}");
        case ChecklistStatus.loading:
          setState(() {
            loading = true;
          });
          break;
        case _:
      }
    });

    // GET WIDGET AFTER USER CHOOSE MACHINE STATUS
    switch (checklistState.status) {
      case ChecklistStatus.loading:
        prevChecklistWidget = Center(
          child: Column(
            children: [
              LoadingShimmerWidget(
                  height: 48,
                  itemCount: 3,
                  width: MediaQuery.of(context).size.width),
            ],
          ),
        );
      case ChecklistStatus.success:
        prevChecklistWidget = ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: partChecklist.length,
          itemBuilder: (context, index) {
            final idPart = partChecklist[index]["tempId"];
            final part = partChecklist[index][idPart];
            return CustomLongCardWidget(
              title: part["mpmpnm"].toString().trimRight(),
              onTap: () {
                final data = {
                  "part": part,
                  "mechineName": partChecklist[index]["trlsnm"],
                  "chchnm": part["chchnm"]
                };

                AppPrint.debugLog("DATAA: $data");

                ref
                    .read(cmcmlniyProvider.notifier)
                    .update((state) => data["part"]["cmcmlniy"].toString());
                ref.read(partDataProvider.notifier).update((state) => data);

                ref.read(routerProvider).push(RouteName.summaryChecklist);
              },
              textLeading: "0/${part["item"]?.length}",
              titleStye: AppTextStyle.subTitleTextStyle.copyWith(),
              textLeadingStyle: AppTextStyle.subTitleTextStyle.copyWith(),
            );
          },
        );
        break;
      case ChecklistStatus.failure:
        prevChecklistWidget = Center(
          child: Column(
            children: [
              Text(
                checklistState.customError.errorMessage,
                style: AppTextStyle.subTitleTextStyle
                    .copyWith(color: Colors.white),
              ),
              5.h,
              ButtonReusableWidget(
                  onPressed: () => ref
                      .read(checklistProvider.notifier)
                      .callChecklist(
                          id: dataGetChecklist["id"],
                          shiftId: dataGetChecklist["shiftId"],
                          statusId: dataGetChecklist["statusId"],
                          period: dataGetChecklist["period"]),
                  title: "Refresh"),
            ],
          ),
        );
        break;
      default:
    }

    final dataTable = ref.watch(dataTableProvider(jsonDecode(jsonEncode({
      "shift": shift.toMap(),
      "model": model,
      "machineId": machineId,
    }))));

    TableRow buildTable({required String label, required String value}) {
      return TableRow(
        children: [
          Text(
            label,
            style: AppTextStyle.subTitleTextStyle.copyWith(color: Colors.black),
          ),
          Text(
            " : $value ",
            style: AppTextStyle.subTitleTextStyle.copyWith(color: Colors.black),
          ),
        ],
      );
    }

    return PopScope(
      onPopInvoked: (didPop) {
        AppPrint.debugLog("ELLLO: $didPop");
      },
      child: Scaffold(
        appBar: CustomAppbarWidget(
          isCenter: true,
          title: "",
          actions: [
            Text(
              "Screen 1/3",
              style: AppTextStyle.subTitleTextStyle.copyWith(
                color: Colors.white,
              ),
            ),
            20.w,
          ],
          titleStye: AppTextStyle.subTitleTextStyle
              .copyWith(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        body: Stack(
          children: [
            const BackgroundImageWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Table(
                                    columnWidths: const <int, TableColumnWidth>{
                                      0: FlexColumnWidth(),
                                      1: FixedColumnWidth(420),
                                    },
                                    children: List.generate(dataTable.length,
                                        (index) {
                                      return buildTable(
                                          label:
                                              dataTable[index]["label"] ?? "",
                                          value:
                                              dataTable[index]["value"] ?? "");
                                    })),
                              ],
                            ),
                          ),
                        ),
                        10.h,
                        Column(
                          children: [
                            Text(
                              "Summary Checklist Status",
                              style: AppTextStyle.subTitleTextStyle
                                  .copyWith(color: Colors.white),
                            ),
                            5.h,
                            Row(
                              children: List.generate(
                                  statusChecklist.length,
                                  (index) => CardStatusWidget(
                                        label: statusChecklist[index]["label"]
                                            .toString(),
                                        value: statusChecklist[index]["value"]
                                            .toString(),
                                        type: statusChecklist[index]["type"],
                                      )),
                            ),
                          ],
                        ),
                        10.h,
                        prevChecklistWidget,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
