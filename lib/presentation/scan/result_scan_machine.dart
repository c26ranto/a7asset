import 'dart:convert';

import 'package:assets_mobile/data/models/auth_state.dart';
import 'package:assets_mobile/data/models/checklist_state.dart';
import 'package:assets_mobile/data/models/generate_clhead_state.dart';
import 'package:assets_mobile/data/models/get_status_machine_state.dart';
import 'package:assets_mobile/data/models/save_checklist_state.dart';
import 'package:assets_mobile/presentation/checklist/provider/checklist_provider.dart';
import 'package:assets_mobile/presentation/scan/provider/scan_provider.dart';
import 'package:assets_mobile/presentation/shift/provider/shift_provider.dart';
import 'package:assets_mobile/presentation/widgets/background_image_image.dart';
import 'package:assets_mobile/presentation/widgets/button_widget.dart';
import 'package:assets_mobile/presentation/widgets/card_status_widget.dart';
import 'package:assets_mobile/presentation/widgets/custom_appbar_widget.dart';
import 'package:assets_mobile/presentation/widgets/custom_error_widget.dart';
import 'package:assets_mobile/presentation/widgets/custom_long_card_widget.dart';
import 'package:assets_mobile/presentation/widgets/loading_shimmer.dart';
import 'package:assets_mobile/route/route_name.dart';
import 'package:assets_mobile/route/route_provider.dart';
import 'package:assets_mobile/utils/app_colors.dart';
import 'package:assets_mobile/utils/app_dialog.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:assets_mobile/utils/app_text_Style.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/get_machine_progress_state.dart';

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
  void initState() {
    getAllMachines();

    super.initState();
  }

  void getAllMachines() async {
    setState(() {
      loading = true;
    });
    await Future.delayed(Duration.zero, () async {
      final shift = ref.read(dataShiftProvider);
      final id = ref.read(idQrCodeProvider);
      await ref.read(getMachineProgressProvider.notifier).call(
            machineNumber: id,
            shiftId: shift.id,
            period: shift.period,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final machineId = ref.watch(idQrCodeProvider);
    final shift = ref.watch(dataShiftProvider);
    final model = ref.watch(modelProvider);
    final statusChecklist = ref.read(statusChecklistProvider);
    final dataGetChecklist = ref.watch(dataGetChecklistProvider);
    final tssycd = ref.watch(tssycdProvider);

    Widget prevChecklistWidget = const SizedBox.shrink();

    final checklistState = ref.watch(checklistProvider);
    final getMachineProgressState = ref.watch(getMachineProgressProvider);
    final machineState = ref.watch(machinesProvider);

    ref.listen(
      getMachineProgressProvider,
      (previous, next) {
        switch (next.status) {
          case GetMachineProgressStatus.success:
            setState(() {
              loading = false;
            });
            final data = jsonDecode(next.success ?? "");
            String stat = List.from(data["data"]["Data"])
                .first["clstat"]
                .toString()
                .trim();

            switch (stat) {
              case "90":
                AppDialog.customDialog(context, "",
                    barrierDismissible: false,
                    title: Text(
                      "Machine checklist is finished\nPress create new to check again",
                      style: AppTextStyle.subTitleTextStyle.copyWith(),
                    ),
                    actions: [
                      ButtonReusableWidget(
                        onPressed: () => context.pop(),
                        title: "Back",
                      ),
                      ButtonReusableWidget(
                        onPressed: () async {
                          context.pop();
                          await ref
                              .read(checklistProvider.notifier)
                              .callChecklist(
                                id: machineId,
                                shiftId: shift.id,
                                period: shift.period,
                                statusId: tssycd,
                              );
                          await ref
                              .read(getStatusMachineProvider.notifier)
                              .getStatusMachine();
                        },
                        title: "Create New",
                      ),
                    ]);
                break;
              case "05":
                ref.read(checklistProvider.notifier).callChecklist(
                      id: machineId,
                      shiftId: shift.id,
                      period: shift.period,
                      statusId: tssycd,
                    );
              case "10":
                AppDialog.customDialog(context, "",
                    title: const SizedBox(),
                    barrierDismissible: false,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Machine Checklist is Onprogress"),
                        3.h,
                        const Text(
                            "Machine Checklist is Onprogress, you can continue or scan other machine."),
                      ],
                    ),
                    actions: [
                      Row(
                        children: [
                          Expanded(
                            child: ButtonReusableWidget(
                                onPressed: () {
                                  context.pop();
                                  context.pop();
                                },
                                backgroundColor: Colors.red,
                                title: "Cancel"),
                          ),
                          10.w,
                          Expanded(
                            child: ButtonReusableWidget(
                                onPressed: () async {
                                  context.pop();
                                  ref
                                      .read(checklistProvider.notifier)
                                      .callChecklist(
                                        id: machineId,
                                        shiftId: shift.id,
                                        period: shift.period,
                                        statusId: tssycd,
                                      );
                                  await ref
                                      .read(getStatusMachineProvider.notifier)
                                      .getStatusMachine();
                                },
                                title: "Create New"),
                          ),
                          10.w,
                          Expanded(
                            child: ButtonReusableWidget(
                                onPressed: () async {
                                  ref
                                      .read(checklistProvider.notifier)
                                      .callChecklist(
                                        id: machineId,
                                        shiftId: shift.id,
                                        period: shift.period,
                                        statusId: tssycd,
                                      );
                                  context.pop();
                                },
                                backgroundColor: Colors.green,
                                title: "Continue"),
                          ),
                        ],
                      )
                    ]);
            }
          case GetMachineProgressStatus.failure:
            setState(() {
              loading = false;
            });
            AppDialog.errorDialog(context, next.customError.errorMessage, () {
              context.pop();
              context.pop();
            });
            break;
          case _:
          // default:
          //   ref.read(checklistProvider.notifier).callChecklist(
          //         id: machineId,
          //         shiftId: shift.id,
          //         period: shift.period,
          //         statusId: tssycd,
          //       );
        }
      },
    );

    ref.listen(getStatusMachineProvider, (previous, next) {
      switch (next.status) {
        case GetStatusMachineStatus.loading:
          AppDialog.loadingDialog(context);
        case GetStatusMachineStatus.success:
          context.pop();
          final data = jsonDecode(next.success ?? "");
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
                    Expanded(
                        child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data["status"].length,
                      itemBuilder: (context, index) {
                        final status = data["status"][index];
                        return ButtonReusableWidget(
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              AppPrint.debugLog("STATUS: ${status["tssycd"]}");
                              // POP THE DIALOG
                              context.pop();
                              ref.read(tssycdProvider.notifier).update(
                                  (state) =>
                                      status["tssycd"].toString().trim());
                              await ref
                                  .read(generateClheadProvider.notifier)
                                  .callGenerateClhead(
                                    machineNumber: machineId,
                                    shiftId: shift.id,
                                    period: shift.period,
                                    statusId:
                                        status["tssycd"].toString().trim(),
                                  );
                              if (status["tssycd"] == "1") {
                                ref
                                    .read(dataGetChecklistProvider.notifier)
                                    .update((state) => {
                                          "id": machineId,
                                          "shiftId": shift.id,
                                          "period": shift.period,
                                          "statusId": status["tssycd"]
                                              .toString()
                                              .trim(),
                                        });
                              } else {
                                if (mounted) {
                                  await Future.delayed(Duration.zero, () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Checklist disimpan...")));
                                    context.pop();
                                  });
                                }
                              }
                              setState(() {
                                loading = false;
                              });
                            },
                            title: "${status["tssynm"]}");
                      },
                    )),
                  ],
                ),
              ),
              actions: []);
          break;
        case GetStatusMachineStatus.failure:
          context.pop();
          AppDialog.errorDialog(
              context, next.customError.errorMessage, () => context.pop());
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
          AppPrint.debugLog("NEXTXXXX: ${next.success}");
          final status = next.success?.first["clstat"] ?? "0";
          AppPrint.debugLog("HELLO STATUS $status");
          switch (status.trim()) {
            case "90":
              AppDialog.customDialog(context, "",
                  barrierDismissible: false,
                  title: Text(
                    "Machine checklist is finished\nPress create new to check again",
                    style: AppTextStyle.subTitleTextStyle.copyWith(),
                  ),
                  actions: [
                    ButtonReusableWidget(
                      onPressed: () => context.pop(),
                      title: "Back",
                    ),
                    ButtonReusableWidget(
                      onPressed: () async {
                        AppPrint.debugLog("STATUS: ${status["tssycd"]}");
                        // POP THE DIALOG
                        context.pop();
                        ref.read(tssycdProvider.notifier).update(
                            (state) => status["tssycd"].toString().trim());
                        await ref
                            .read(generateClheadProvider.notifier)
                            .callGenerateClhead(
                              machineNumber: machineId,
                              shiftId: shift.id,
                              period: shift.period,
                              statusId: status["tssycd"].toString().trim(),
                            );
                      },
                      title: "Create New",
                    ),
                  ]);
              break;
            case "10":
              AppDialog.customDialog(
                context,
                "",
                barrierDismissible: false,
                title: Text(
                  "Machine Checklist is Onprogress\nMachine Checklist is Onprogress, you can continue or scan other machine.",
                  style: AppTextStyle.subTitleTextStyle.copyWith(),
                ),
                actions: [
                  Row(
                    children: [
                      Expanded(
                        child: ButtonReusableWidget(
                          onPressed: () {
                            context.pop();
                            context.pop();
                          },
                          backgroundColor: Colors.red,
                          title: "Back",
                        ),
                      ),
                      10.w,
                      Expanded(
                        child: ButtonReusableWidget(
                          onPressed: () async {
                            context.pop();
                          },
                          backgroundColor: Colors.blue,
                          title: "Create New",
                        ),
                      ),
                      10.w,
                      Expanded(
                        child: ButtonReusableWidget(
                          onPressed: () async {
                            context.pop();
                          },
                          backgroundColor: Colors.green,
                          title: "Continue",
                        ),
                      ),
                    ],
                  ),
                ],
              );
              break;
          }

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
                  height: 56,
                  itemCount: 3,
                  width: MediaQuery.of(context).size.width),
            ],
          ),
        );
      case ChecklistStatus.success:
        prevChecklistWidget = checklistState.success?.isEmpty ?? [].isEmpty
            ? const SizedBox(
                height: 150,
                child: CustomErrorWidget(
                  customErrorWidgetType: CustomErrorWidgetType.widget,
                  errorMessage: "Tidak ada data, silahkan coba lagi",
                  buttonTitle: "Kembali",
                ))
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: checklistState.success?.length,
                itemBuilder: (context, index) {
                  final data = checklistState.success ?? [];

                  final idPart = data[index]["tempId"];
                  final part = data[index][idPart];
                  return CustomLongCardWidget(
                    title: part["mpmpnm"].toString().trimRight(),
                    onTap: () {
                      final dataPass = {
                        "part": part,
                        "mechineName": data[index]["trlsnm"],
                        "chchnm": part["chchnm"]
                      };

                      AppPrint.debugLog("DATA CHECKLIST SCREEN: $data");

                      ref.read(cmcmlniyProvider.notifier).update(
                          (state) => dataPass["part"]["cmcmlniy"].toString());
                      ref
                          .read(partDataProvider.notifier)
                          .update((state) => dataPass);

                      context.push(RouteName.summaryChecklist);
                    },
                    textLeading:
                        "${statusChecklist[1]["value"]}/${part["item"]?.length}",
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
                        loading
                            ? const LoadingShimmerWidget(
                                itemCount: 3,
                                height: 56,
                                width: double.infinity)
                            : prevChecklistWidget,
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
