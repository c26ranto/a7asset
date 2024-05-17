import 'dart:io';

import 'package:assets_mobile/data/models/cutom_error.dart';
import 'package:assets_mobile/data/models/save_checklist_state.dart';
import 'package:assets_mobile/presentation/checklist/provider/checklist_provider.dart';
import 'package:assets_mobile/presentation/scan/provider/scan_provider.dart';
import 'package:assets_mobile/presentation/shift/provider/shift_provider.dart';
import 'package:assets_mobile/presentation/widgets/background_image_image.dart';
import 'package:assets_mobile/presentation/widgets/button_widget.dart';
import 'package:assets_mobile/presentation/widgets/custom_appbar_widget.dart';
import 'package:assets_mobile/presentation/widgets/custom_error_widget.dart';
import 'package:assets_mobile/presentation/widgets/custom_formfield_widget.dart';
import 'package:assets_mobile/presentation/widgets/custom_long_card_widget.dart';
import 'package:assets_mobile/presentation/widgets/form_date_widget.dart';
import 'package:assets_mobile/route/route_provider.dart';
import 'package:assets_mobile/utils/app_colors.dart';
import 'package:assets_mobile/utils/app_dialog.dart';
import 'package:assets_mobile/utils/app_enums.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:assets_mobile/utils/app_text_Style.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChecklistDetailScreen extends ConsumerStatefulWidget {
  const ChecklistDetailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChecklistDetailScreenState();
}

class _ChecklistDetailScreenState extends ConsumerState<ChecklistDetailScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  final _detailNoteC = TextEditingController();
  final _detailNoteDialogC = TextEditingController();
  final _numeriC = TextEditingController();
  final _freeTextC = TextEditingController();

  @override
  void dispose() {
    _detailNoteC.dispose();
    _detailNoteDialogC.dispose();
    _freeTextC.dispose();
    _numeriC.dispose();
    super.dispose();
  }

  void clearController() {
    _detailNoteDialogC.clear();
    _freeTextC.clear();
    _numeriC.clear();
  }

  @override
  Widget build(BuildContext context) {
    final machineId = ref.watch(idQrCodeProvider);
    final images = ref.watch(imagesDetailChecklistProvider);
    final dataPart = ref.watch(partDataProvider);
    final item = ref.watch(detailChecklistItemProvider);
    final cmcmlniy = ref.watch(cmcmlniyProvider);

    final chchcdiy = ref.watch(cdchcdiyProvider);

    ref.listen<SaveChecklistState>(
      saveChecklistProvider,
      (previous, next) {
        switch (next.status) {
          case SaveChecklistStatus.loading:
            Navigator.pop(context);
            AppDialog.loadingDialog(context);
            break;
          // case SaveChecklistStatus.failure:
          //   Navigator.pop(context);
          //   AppDialog.errorDialog(context, next.customError.errorMessage,
          //       () => Navigator.pop(context));
          default:
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Berhasil!")));
        }
      },
    );

    AppPrint.debugLog("item part: $item");
    AppPrint.debugLog("data part: $dataPart");

    return Scaffold(
      appBar: CustomAppbarWidget(
        isCenter: true,
        title: machineId,
        actions: [
          Text(
            "Screen 3/3",
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
          Positioned(
            left: 18,
            right: 18,
            top: 10,
            bottom: 20,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: [
                  10.h,
                  const FormFieldDateWidget(
                    title: "Note",
                    label: "Tidak ada note",
                    fill: true,
                    icon: Icon(
                      Icons.photo,
                      size: 32,
                      color: Colors.white,
                    ),
                    disabled: false,
                    fillColor: Colors.white,
                    outlineBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  10.h,
                  Container(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Text(
                          item["value"].toString().trim(),
                          style: AppTextStyle.subTitleTextStyle.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.h,
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => CustomLongCardWidget(
                        title: item["chchnm"].toString(),
                        onTap: () async {
                          AppPrint.debugLog("clickkk: $item");
                          ref.invalidate(chooseCdcdlniyProvider);
                          ref.invalidate(imagesOnDialogProvider);
                          ref.invalidate(cdcdlniyProvider);

                          clearController();

                          showDialog(
                            context: context,
                            builder: (context) => Consumer(
                              builder: (_, ref, __) {
                                final checklist = ref.watch(
                                    getChecklistProvider(cdchcdiy: chchcdiy));
                                final imagesDialog =
                                    ref.watch(imagesOnDialogProvider);
                                final cdcdlniy = ref.watch(cdcdlniyProvider);
                                final saveChecklist =
                                    ref.watch(saveChecklistProvider);
                                final chooseCdcdlniy =
                                    ref.watch(chooseCdcdlniyProvider);
                                final cdtype = ref.watch(cdtypeProvider);

                                return AlertDialog(
                                  contentPadding: const EdgeInsets.all(10),
                                  insetPadding: const EdgeInsets.all(50),
                                  content: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: checklist.when(
                                      data: (data) {
                                        if (data.isEmpty) {
                                          return SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                            child: const Center(
                                              child: Text(
                                                "Data tidak ditemukan.",
                                                style: AppTextStyle
                                                    .subTitleTextStyle,
                                              ),
                                            ),
                                          );
                                        }

                                        return SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              20.h,
                                              Text(
                                                item["chchnm"].toString(),
                                                style: AppTextStyle
                                                    .subTitleTextStyle
                                                    .copyWith(),
                                              ),
                                              10.h,
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.2,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: data.length,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    final item = data[index];

                                                    return item.cdtype
                                                                ?.toLowerCase() ==
                                                            "o"
                                                        ? CustomLongCardWidget(
                                                            title: data[index]
                                                                    .cdcdds ??
                                                                "no data",
                                                            titleStye: AppTextStyle
                                                                .subTitleTextStyle
                                                                .copyWith(
                                                              color:
                                                                  chooseCdcdlniy ==
                                                                          index
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                            ),
                                                            color: chooseCdcdlniy ==
                                                                    index
                                                                ? Colors.green
                                                                : const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    227,
                                                                    227,
                                                                    227),
                                                            onTap: () {
                                                              ref
                                                                  .read(chooseCdcdlniyProvider
                                                                      .notifier)
                                                                  .update(
                                                                    (state) =>
                                                                        index,
                                                                  );
                                                              ref
                                                                  .read(cdcdlniyProvider
                                                                      .notifier)
                                                                  .update((state) => data[
                                                                          index]
                                                                      .cdcdlniy
                                                                      .toString());
                                                              AppPrint.debugLog(
                                                                  "WELLLLLLL: ${data[index].toMap()}");
                                                            })
                                                        : item.cdtype
                                                                    ?.toLowerCase() ==
                                                                'n'
                                                            ? CustomFormfieldWidget(
                                                                controller:
                                                                    _numeriC,
                                                                inputFormatters: [
                                                                  FilteringTextInputFormatter
                                                                      .digitsOnly,
                                                                ],
                                                                conditionColor:
                                                                    false,
                                                                outlineBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    color: AppColors
                                                                        .textDisableColor,
                                                                  ),
                                                                ),
                                                                labelStyle:
                                                                    AppTextStyle
                                                                        .commonTextStyle
                                                                        .copyWith(
                                                                  color: AppColors
                                                                      .borderColor,
                                                                ),
                                                                prefixIcon:
                                                                    const Icon(
                                                                  Icons
                                                                      .checklist,
                                                                  size: 18,
                                                                  color: AppColors
                                                                      .borderColor,
                                                                ),
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return "Numeric input tidak boleh kosong";
                                                                  }
                                                                  return null;
                                                                },
                                                                label:
                                                                    "Numeric",
                                                              )
                                                            : CustomFormfieldWidget(
                                                                controller:
                                                                    _freeTextC,
                                                                conditionColor:
                                                                    false,
                                                                outlineBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    color: AppColors
                                                                        .textDisableColor,
                                                                  ),
                                                                ),
                                                                labelStyle:
                                                                    AppTextStyle
                                                                        .commonTextStyle
                                                                        .copyWith(
                                                                  color: AppColors
                                                                      .borderColor,
                                                                ),
                                                                prefixIcon:
                                                                    const Icon(
                                                                  Icons
                                                                      .checklist,
                                                                  size: 18,
                                                                  color: AppColors
                                                                      .borderColor,
                                                                ),
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return "Input tidak boleh kosong";
                                                                  }
                                                                  return null;
                                                                },
                                                                label:
                                                                    "Input bebas",
                                                              );
                                                  },
                                                ),
                                              ),
                                              10.h,
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 8),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Colors.white,
                                                ),
                                                child: CustomFormfieldWidget(
                                                  controller:
                                                      _detailNoteDialogC,
                                                  conditionColor: false,
                                                  label: "Note",
                                                  labelStyle: AppTextStyle
                                                      .subTitleTextStyle
                                                      .copyWith(
                                                    color:
                                                        AppColors.borderColor,
                                                  ),
                                                ),
                                              ),
                                              10.h,
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 8),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Row(
                                                      children: List.generate(
                                                          imagesDialog.isEmpty
                                                              ? 1
                                                              : imagesDialog
                                                                  .length,
                                                          (index) {
                                                        if (imagesDialog
                                                            .isEmpty) {
                                                          return _emptyImage(
                                                              takePhotoChecklistType:
                                                                  TakePhotoChecklistType
                                                                      .dialog);
                                                        } else {
                                                          return _image(
                                                              imagesDialog[
                                                                      index]
                                                                  .path,
                                                              index, () {
                                                            ref
                                                                .read(imagesOnDialogProvider
                                                                    .notifier)
                                                                .update(
                                                                    (state) {
                                                              return state = state
                                                                  .where((element) =>
                                                                      imagesDialog[
                                                                          index] !=
                                                                      element)
                                                                  .toList();
                                                            });
                                                          });
                                                        }
                                                      }),
                                                    ),
                                                    10.w,
                                                    if (imagesDialog.length <
                                                            3 &&
                                                        imagesDialog.isNotEmpty)
                                                      _emptyImage(
                                                          takePhotoChecklistType:
                                                              TakePhotoChecklistType
                                                                  .dialog),
                                                  ],
                                                ),
                                              ),
                                              10.h,
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 18,
                                                        vertical: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ButtonReusableWidget(
                                                        width: 150,
                                                        onPressed: () {
                                                          ref
                                                              .read(
                                                                  routerProvider)
                                                              .pop();
                                                          ref.invalidate(
                                                              imagesOnDialogProvider);
                                                        },
                                                        title: "Cancel",
                                                        backgroundColor:
                                                            AppColors
                                                                .negativeColor),
                                                    10.w,
                                                    ButtonReusableWidget(
                                                        width: 150,
                                                        disabled: cdtype
                                                                    .toLowerCase() ==
                                                                'o'
                                                            ? chooseCdcdlniy ==
                                                                99
                                                            : saveChecklist
                                                                    .status ==
                                                                SaveChecklistStatus
                                                                    .loading,
                                                        onPressed: () async {
                                                          AppPrint.debugLog(
                                                              "MY ITEM: $item");
                                                          ref
                                                              .read(
                                                                  saveChecklistProvider
                                                                      .notifier)
                                                              .callSaveChecklist(
                                                                  cmcmlniy:
                                                                      cmcmlniy,
                                                                  cmacvl:
                                                                      _detailNoteDialogC
                                                                          .text,
                                                                  cdcdlniy:
                                                                      cdcdlniy);
                                                        },
                                                        title: saveChecklist
                                                                    .status ==
                                                                SaveChecklistStatus
                                                                    .loading
                                                            ? "Loading..."
                                                            : "Save",
                                                        backgroundColor:
                                                            AppColors
                                                                .primaryColor),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      error: (error, stackTrace) => SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        child: Center(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomErrorWidget(
                                              customErrorWidgetType:
                                                  CustomErrorWidgetType.widget,
                                              errorMessage:
                                                  (error as CustomError)
                                                      .errorMessage,
                                              title: "Kembali",
                                              action: () =>
                                                  Navigator.pop(context),
                                            ),
                                            5.h,
                                          ],
                                        )),
                                      ),
                                      loading: () => SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        child: const Center(
                                          child: CircularProgressIndicator
                                              .adaptive(),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                  ),
                  10.h,
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: CustomFormfieldWidget(
                      controller: _detailNoteC,
                      conditionColor: false,
                      label: "Note",
                      labelStyle: AppTextStyle.subTitleTextStyle.copyWith(
                        color: AppColors.borderColor,
                      ),
                    ),
                  ),
                  10.h,
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Row(
                          children: List.generate(
                              images.isEmpty ? 1 : images.length, (index) {
                            if (images.isEmpty) {
                              return _emptyImage(
                                  takePhotoChecklistType:
                                      TakePhotoChecklistType.detail);
                            } else {
                              return _image(images[index].path, index, () {
                                ref
                                    .read(
                                        imagesDetailChecklistProvider.notifier)
                                    .update((state) {
                                  return state = state
                                      .where(
                                          (element) => images[index] != element)
                                      .toList();
                                });
                              });
                            }
                          }),
                        ),
                        10.w,
                        if (images.length < 3 && images.isNotEmpty)
                          _emptyImage(
                              takePhotoChecklistType:
                                  TakePhotoChecklistType.detail),
                      ],
                    ),
                  ),
                  10.h,
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: ButtonReusableWidget(
                  onPressed: () {
                    ref.read(routerProvider).pop();
                    ref.invalidate(imagesDetailChecklistProvider);
                  },
                  title: "Cancel",
                  backgroundColor: AppColors.negativeColor),
            ),
            10.w,
            Expanded(
                child: ButtonReusableWidget(
                    disabled: images.isEmpty,
                    onPressed: () {},
                    title: "Save",
                    backgroundColor: AppColors.primaryColor)),
          ],
        ),
      ),
    );
  }

  Widget _image(
    String imgUrl,
    int index,
    void Function()? delete,
  ) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.borderColor,
        border: Border.all(width: 1, color: Colors.black12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Center(
              child: Image.file(
                File(imgUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 2,
            top: 2,
            child: InkWell(
                onTap: delete,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black54),
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 16,
                  ),
                )),
          )
        ],
      ),
    );
  }

  Widget _emptyImage({required TakePhotoChecklistType takePhotoChecklistType}) {
    return Row(
      children: [
        InkWell(
          onTap: () async {
            ref.read(takePictureProvider(type: takePhotoChecklistType));
          },
          child: Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.only(bottom: 5, right: 5),
            decoration: BoxDecoration(
                color: AppColors.borderColor,
                border: Border.all(width: 1, color: Colors.black12),
                borderRadius: BorderRadius.circular(6)),
            child: const Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                      child: Icon(
                    Icons.photo,
                    size: 36,
                    color: AppColors.bgColor3,
                  )),
                ),
              ],
            ),
          ),
        ),
        10.w,
        Text(
          "Tap to take a photo",
          style: AppTextStyle.subTitleTextStyle.copyWith(
            color: AppColors.borderColor,
          ),
        ),
      ],
    );
  }
}
