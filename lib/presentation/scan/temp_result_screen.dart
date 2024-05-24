import 'dart:convert';

import 'package:assets_mobile/data/models/get_machine_progress_state.dart';
import 'package:assets_mobile/data/models/shift_model.dart';
import 'package:assets_mobile/presentation/checklist/provider/checklist_provider.dart';
import 'package:assets_mobile/presentation/scan/provider/scan_provider.dart';
import 'package:assets_mobile/presentation/shift/provider/shift_provider.dart';
import 'package:assets_mobile/presentation/widgets/button_widget.dart';
import 'package:assets_mobile/route/route_name.dart';
import 'package:assets_mobile/utils/app_dialog.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../widgets/background_image_image.dart';

class TempResultScreen extends ConsumerStatefulWidget {
  const TempResultScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TempResultScreenState();
}

class _TempResultScreenState extends ConsumerState<TempResultScreen> {
  bool loading = true;
  String machineId = "";
  ShiftModel shift = ShiftModel(date: "", id: "", period: "", title: "");

  @override
  void initState() {
    WidgetsBinding.instance.addPersistentFrameCallback(
      (timeStamp) {
        getMachineProgress();
      },
    );
    super.initState();
  }

  void getMachineProgress() async {
    shift = ref.read(dataShiftProvider);
    machineId = ref.read(idQrCodeProvider);
    try {
      await ref.read(getMachineProgressProvider.notifier).call(
            machineNumber: machineId,
            shiftId: shift.id,
            period: shift.period,
          );
    } catch (e) {
      AppPrint.debugLog("ERROR TEMP RESULT SCREEN: $e");
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      getMachineProgressProvider,
      (previous, next) {
        switch (next.status) {
          case GetMachineProgressStatus.success:
            final data = jsonDecode(next.success ?? "");
            AppPrint.debugLog("Hello: $data");
            context.pop();
            switch (List.from(data["data"]["Data"]).first["clstat"]) {
              case "05":
                context.pushReplacement(RouteName.resultScanMachine);
              case "10":
                AppDialog.customDialog(context, "",
                    title: const SizedBox(),
                    content: Column(
                      children: [
                        const Text("Machine Checklist is Onprogress"),
                        10.h,
                        const Text(
                            "Machine Checklist is Onprogress, you can continue or scan other machine."),
                      ],
                    ),
                    actions: [
                      Row(
                        children: [
                          ButtonReusableWidget(
                              onPressed: () {
                                context.pop();
                                context.pop();
                              },
                              title: "Cancel"),
                          10.w,
                          ButtonReusableWidget(
                              onPressed: () =>
                                  context.push(RouteName.resultScanMachine),
                              title: "Continue"),
                        ],
                      )
                    ]);
            }
            break;
          default:
        }
      },
    );

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImageWidget(),
          loading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
