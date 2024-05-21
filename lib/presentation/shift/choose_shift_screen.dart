import 'package:assets_mobile/data/models/cutom_error.dart';
import 'package:assets_mobile/data/models/shift_model.dart';
import 'package:assets_mobile/presentation/checklist/provider/checklist_provider.dart';
import 'package:assets_mobile/presentation/shift/provider/shift_provider.dart';
import 'package:assets_mobile/presentation/widgets/background_image_image.dart';
import 'package:assets_mobile/presentation/widgets/button_widget.dart';
import 'package:assets_mobile/presentation/widgets/custom_appbar_widget.dart';
import 'package:assets_mobile/presentation/widgets/custom_error_widget.dart';
import 'package:assets_mobile/presentation/widgets/custom_long_card_widget.dart';
import 'package:assets_mobile/presentation/widgets/form_date_widget.dart';
import 'package:assets_mobile/presentation/widgets/loading_shimmer.dart';
import 'package:assets_mobile/route/route_name.dart';
import 'package:assets_mobile/route/route_provider.dart';
import 'package:assets_mobile/utils/app_colors.dart';
import 'package:assets_mobile/utils/app_text_Style.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChooseShift extends ConsumerWidget {
  const ChooseShift({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shiftDate = ref.watch(shiftDateProvider);
    final shift = ref.watch(getShiftProvider);
    final shiftIndex = ref.watch(chooseShiftIndexProvider);
    final dataShift = ref.watch(dataShiftProvider);

    return Scaffold(
        appBar: CustomAppbarWidget(
          isCenter: true,
          title: "Checklist Schedule",
          titleStye: AppTextStyle.subTitleTextStyle
              .copyWith(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        body: Stack(
          children: [
            const BackgroundImageWidget(),
            SafeArea(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                children: [
                  FormFieldDateWidget(
                    title: "Date",
                    label: shiftDate,
                    fill: true,
                    fillColor: Colors.white,
                    disabled: false,
                    outlineBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide.none,
                    ),
                    onTap: () async {
                      DateTime? dt = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(const Duration(days: 1)),
                          lastDate:
                              DateTime.now().add(const Duration(days: 1)));

                      if (dt != null) {
                        ref.read(shiftDateProvider.notifier).update(
                            (state) => DateFormat("dd-MMM-yyyy").format(dt));
                      }
                    },
                  ),
                  20.h,
                  shift.when(
                    data: (data) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "SHIFT",
                          style: AppTextStyle.subTitleTextStyle
                              .copyWith(color: Colors.white),
                        ),
                        20.h,
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return CustomLongCardWidget(
                              title: data[index]["tssynm"],
                              titleStye: shiftIndex == index
                                  ? AppTextStyle.subTitleTextStyle.copyWith()
                                  : AppTextStyle.commonTextStyle,
                              border: shiftIndex == index
                                  ? Border.all(
                                      color: AppColors.skyBlue,
                                      width: 5,
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside)
                                  : null,
                              isChoose: shiftIndex == index,
                              onTap: () {
                                ref
                                    .read(chooseShiftIndexProvider.notifier)
                                    .update((state) => index);
                                ref.read(tssycdProvider.notifier).update(
                                      (state) =>
                                          data[index]["tssycd"].toString(),
                                    );
                                final shiftModel = ShiftModel.fromMap({
                                  "id": data[index]["tssycd"],
                                  "title": data[index]["tssycd"],
                                  "date": shiftDate,
                                  "period": "",
                                });
                                ref
                                    .read(dataShiftProvider.notifier)
                                    .update((state) => shiftModel);
                              },
                            );
                          },
                        )
                      ],
                    ),
                    error: (error, stackTrace) => SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Center(
                        child: CustomErrorWidget(
                          customErrorWidgetType: CustomErrorWidgetType.widget,
                          errorMessage: (error as CustomError).errorMessage,
                          errorMessageStyle: AppTextStyle.subTitleTextStyle
                              .copyWith(color: Colors.white),
                          action: () {
                            ref.invalidate(getShiftProvider);
                          },
                        ),
                      ),
                    ),
                    loading: () => const LoadingShimmerWidget(
                      itemCount: 3,
                      height: 56,
                      width: 300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Consumer(
            builder: (_, ref, __) => ButtonReusableWidget(
              disabled: ref.watch(isDefaultShiftProvider),
              onPressed: () {
                final shiftModel = ShiftModel.fromMap({
                  "id": dataShift.id,
                  "title": dataShift.title,
                  "date": shiftDate,
                });
                ref
                    .read(dataShiftProvider.notifier)
                    .update((state) => shiftModel);
                ref.read(routerProvider).push(RouteName.chooseChecklistPeriod);
              },
              title: "Continue",
            ),
          ),
        ));
  }
}
