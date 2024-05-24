import 'package:assets_mobile/presentation/checklist/provider/checklist_provider.dart';
import 'package:assets_mobile/presentation/shift/provider/shift_provider.dart';
import 'package:assets_mobile/presentation/widgets/background_image_image.dart';
import 'package:assets_mobile/presentation/widgets/card_status_widget.dart';
import 'package:assets_mobile/presentation/widgets/custom_appbar_widget.dart';
import 'package:assets_mobile/presentation/widgets/custom_long_card_widget.dart';
import 'package:assets_mobile/route/route_name.dart';
import 'package:assets_mobile/route/route_provider.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:assets_mobile/utils/app_text_Style.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SummaryChecklistScreen extends ConsumerWidget {
  const SummaryChecklistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusChecklist = ref.watch(statusChecklistItemProvider);
    final partData = ref.watch(partDataProvider);
    final partDataChecklist = ref.watch(partChecklistDataProvider);
    return Scaffold(
      appBar: CustomAppbarWidget(
        isCenter: true,
        title: "",
        actions: [
          Text(
            "Screen 2/3",
            style: AppTextStyle.subTitleTextStyle.copyWith(
              color: Colors.white,
            ),
          ),
          20.w,
        ],
        titleStye: AppTextStyle.subTitleTextStyle
            .copyWith(fontWeight: FontWeight.w700, color: Colors.white),
      ),
      body: Stack(children: [
        const BackgroundImageWidget(),
        Positioned(
          left: 18,
          right: 18,
          top: 10,
          bottom: 20,
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              children: [
                Column(
                  children: [
                    InkWell(
                      child: Text(
                        "Summary Checklist Status",
                        style: AppTextStyle.subTitleTextStyle
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    5.h,
                    Text(
                      "Part: ${partData["part"]["mpmpnm"].toString().trim()}",
                      style: AppTextStyle.commonTextStyle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    5.h,
                    Row(
                      children: List.generate(
                          statusChecklist.length,
                          (index) => CardStatusWidget(
                                label:
                                    statusChecklist[index]["label"].toString(),
                                value:
                                    statusChecklist[index]["value"].toString(),
                                type: statusChecklist[index]["type"],
                              )),
                    ),
                  ],
                ),
                10.h,
                Expanded(
                  child: ListView.builder(
                    itemCount: partDataChecklist[0]
                            [partDataChecklist[0]["tempId"]]["item"]
                        .length,
                    itemBuilder: (context, index) {
                      final item = partDataChecklist[0]
                          [partDataChecklist[0]["tempId"]]["item"][index];
                      final detailChecklist =
                          List.from(item["detailItemChecklist"]);
                      return CustomLongCardWidget(
                        title: item["value"],
                        textLeading:
                            "${item["cdcdlniy"] != null ? "1" : "0"}/${detailChecklist.length}",
                        onTap: () {
                          ref.invalidate(ckflkFilesProvider);
                          ref.invalidate(cmflkFilesProvider);
                          ref.invalidate(cmcdlniyProvider);
                          ref.invalidate(cdcdlniyProvider);
                          ref.invalidate(cdvaluProvider);
                          ref.invalidate(cmremkItemProvider);
                          ref.invalidate(cmremkProvider);
                          ref.invalidate(cmacvlProvider);

                          AppPrint.debugLog(
                              "DATA FROM SUMMARY CHECKLIST: $item");

                          ref.read(cmacvlProvider.notifier).update(
                                (state) => item["cmacvl"],
                              );

                          // PASSING CDVALU
                          ref.read(cdvaluProvider.notifier).update(
                                (state) => item["cdvalu"].toString(),
                              );

                          // PASSING CMREMK
                          ref.read(cmremkProvider.notifier).update(
                                (state) => item["cmremk"],
                              );
                          ref.read(cmremkItemProvider.notifier).update(
                                (state) => detailChecklist.first["cmremk"],
                              );

                          ref.read(cmcmlniyProvider.notifier).update(
                                (state) => item["cmcmlniy"].toString(),
                              );

                          if (detailChecklist.first["cdcdlniy"] != null) {
                            ref.read(cdcdlniyProvider.notifier).update(
                                  (state) => detailChecklist.first["cdcdlniy"]
                                      .toString(),
                                );
                          }

                          if (detailChecklist.first["cmcdlniy"] != null) {
                            ref.read(cmcdlniyProvider.notifier).update(
                                  (state) => detailChecklist.first["cmcdlniy"]
                                      .toString(),
                                );
                          }

                          if (item.containsKey("files") &&
                              item["files"].isNotEmpty) {
                            ref.read(ckflkFilesProvider.notifier).update(
                                (state) => [...state, ...item["files"]]);
                          }

                          for (final detailItem in detailChecklist) {
                            if (detailItem.containsKey("filesChecklist") &&
                                List.from(detailItem["filesChecklist"])
                                    .isNotEmpty) {
                              ref.read(ckflkFilesProvider.notifier).update(
                                  (state) => [
                                        ...state,
                                        ...detailItem["filesChecklist"]
                                      ]);
                            }
                          }

                          ref.read(ckcknoiyProvider.notifier).update(
                                (state) => item["ckcknoiy"].toString().trim(),
                              );
                          ref
                              .read(cdchcdiyProvider.notifier)
                              .update((state) => item["id"].toString());
                          ref
                              .read(detailChecklistItemProvider.notifier)
                              .update((state) => item);

                          ref
                              .read(detailChecklistItemTestProvider.notifier)
                              .update(
                                (state) => {
                                  "detailChecklist": detailChecklist,
                                },
                              );

                          ref
                              .read(routerProvider)
                              .push(RouteName.checklistDetail);
                        },
                        titleStye: AppTextStyle.subTitleTextStyle.copyWith(),
                        // textLeadingStyle: AppTextStyle.subTitleTextStyle.copyWith(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
