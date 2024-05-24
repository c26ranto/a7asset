import 'dart:convert';
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
import 'package:assets_mobile/presentation/widgets/loading_screen_widget.dart';
import 'package:assets_mobile/presentation/widgets/loading_shimmer.dart';
import 'package:assets_mobile/route/route_provider.dart';
import 'package:assets_mobile/utils/app_colors.dart';
import 'package:assets_mobile/utils/app_dialog.dart';
import 'package:assets_mobile/utils/app_enums.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:assets_mobile/utils/app_text_Style.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ChecklistDetailScreen extends ConsumerStatefulWidget {
  const ChecklistDetailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChecklistDetailScreenState();
}

class _ChecklistDetailScreenState extends ConsumerState<ChecklistDetailScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  final _detailNoteC = TextEditingController();
  final _numeriC = TextEditingController();
  final _freeTextC = TextEditingController();
  String cdValuColor = "";

  @override
  void initState() {
    cdValuColor = ref.read(cdvaluProvider);

    super.initState();
  }

  @override
  void dispose() {
    _detailNoteC.dispose();
    _freeTextC.dispose();
    _numeriC.dispose();
    super.dispose();
  }

  void clearController() {
    _freeTextC.clear();
    _numeriC.clear();
  }

  @override
  Widget build(BuildContext context) {
    final machineId = ref.watch(idQrCodeProvider);
    final images = ref.watch(imagesDetailChecklistProvider);
    final item = ref.watch(detailChecklistItemProvider);
    final cmcmlniy = ref.watch(cmcmlniyProvider);
    final detail = ref.watch(detailChecklistItemTestProvider);
    final cdcdlniy = ref.watch(cdcdlniyProvider);
    final files = ref.watch(filesProvider);
    final ckcknoiy = ref.watch(ckcknoiyProvider);
    final cmflkFiles = ref.watch(cmflkFilesProvider);
    final ckflkFiles = ref.watch(ckflkFilesProvider);
    final cmcdlniy = ref.watch(cmcdlniyProvider);
    final cmremk = ref.watch(cmremkItemProvider);
    final cmremkItem = ref.watch(cmremkItemProvider);
    final cmacvl = ref.watch(cmacvlProvider);

    final saveChecklistState = ref.watch(saveChecklistProvider);

    final getImages = ref.watch(getImagesChecklistProvider(files: cmflkFiles));

    ref.listen<SaveChecklistState>(
      saveChecklistProvider,
      (previous, next) {
        switch (next.status) {
          case SaveChecklistStatus.failure:
            AppDialog.errorDialog(
              context,
              next.customError.errorMessage,
              () => Navigator.pop(context),
            );
          case SaveChecklistStatus.success:
            ref.invalidate(imagesDetailChecklistProvider);
            ref.invalidate(imagesOnDialogProvider);
            ref.invalidate(filesProvider);
            context.pop();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Berhasil mengirim checklist...")));
          case _:
        }
      },
    );

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
              height: MediaQuery.sizeOf(context).height,
              child: ListView(
                children: [
                  10.h,
                  FormFieldDateWidget(
                    title: "Note",
                    label: cmremk.isNotEmpty ? cmremk : "Tidak ada note",
                    fill: true,
                    icon: const Icon(
                      Icons.photo,
                      size: 32,
                      color: Colors.white,
                    ),
                    disabled: false,
                    fillColor: Colors.white,
                    outlineBorder: const OutlineInputBorder(
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
                      itemCount: detail["detailChecklist"].length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final data = detail["detailChecklist"][index];
                        return CustomLongCardWidget(
                            title: data["chchnm"].toString(),
                            onTap: () async {
                              AppPrint.debugLog(
                                  "ON TAP DETAIL CHECKLIST: $data");
                              ref.invalidate(chooseCdcdlniyProvider);
                              ref.invalidate(imagesOnDialogProvider);

                              // ref.invalidate(cdvaluProvider);
                              ref.invalidate(noteDialogProvider);

                              ref.read(cmcmlniyProvider.notifier).update(
                                    (state) => data["cmcmlniy"].toString(),
                                  );

                              clearController();

                              AppDialog.customDialog(context, "",
                                  title: const SizedBox(), content: Consumer(
                                builder: (_, ref, __) {
                                  final checklist = ref.watch(
                                      getChecklistProvider(
                                          cdchcdiy:
                                              data["chchcdiy"].toString()));

                                  final imagesDialog =
                                      ref.watch(imagesOnDialogProvider);
                                  final saveChecklist =
                                      ref.watch(saveChecklistProvider);
                                  final chooseCdcdlniy =
                                      ref.watch(chooseCdcdlniyProvider);
                                  final cdtype = ref.watch(cdtypeProvider);
                                  final files = ref.watch(filesProvider);
                                  final cdvaluDialog =
                                      ref.watch(cdvaluProvider);
                                  final noteDialog =
                                      ref.watch(noteDialogProvider);
                                  final cdcdlniy = ref.watch(cdcdlniyProvider);

                                  final getImagesDialog = ref.watch(
                                      getImagesChecklistProvider(
                                          files: ckflkFiles));

                                  return SizedBox(
                                    width: MediaQuery.sizeOf(context).width,
                                    child: checklist.when(
                                      data: (result) {
                                        if (result.isEmpty) {
                                          return SizedBox(
                                            height: MediaQuery.sizeOf(context)
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
                                                data["chchnm"].toString(),
                                                style: AppTextStyle
                                                    .subTitleTextStyle
                                                    .copyWith(),
                                              ),
                                              10.h,
                                              SizedBox(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.2,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: result.length,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    final item = result[index];

                                                    return item.cdtype
                                                                ?.toLowerCase() ==
                                                            "o"
                                                        ? CustomLongCardWidget(
                                                            title: result[index]
                                                                    .cdcdds ??
                                                                "no data",
                                                            titleStye: AppTextStyle
                                                                .subTitleTextStyle
                                                                .copyWith(
                                                              color:
                                                                  _buildTextColor(
                                                                index,
                                                                chooseCdcdlniy ==
                                                                        index ||
                                                                    int.tryParse(
                                                                            cmcdlniy) ==
                                                                        index,
                                                                int.tryParse(
                                                                        cdValuColor) ??
                                                                    -1,
                                                                cmcdlniy,
                                                                cdcdlniy,
                                                                cmacvl,
                                                              ),
                                                            ),
                                                            color:
                                                                _buildColorOptions(
                                                              index,
                                                              chooseCdcdlniy ==
                                                                      index ||
                                                                  int.tryParse(
                                                                          cmcdlniy) ==
                                                                      index,
                                                              int.tryParse(
                                                                      cdvaluDialog) ??
                                                                  -1,
                                                              cmcdlniy,
                                                              cdcdlniy,
                                                              cmacvl,
                                                            ),
                                                            onTap: cmcdlniy
                                                                        .isNotEmpty &&
                                                                    cmcdlniy ==
                                                                        cdcdlniy
                                                                ? null
                                                                : () {
                                                                    ref
                                                                        .read(chooseCdcdlniyProvider
                                                                            .notifier)
                                                                        .update(
                                                                          (state) =>
                                                                              index,
                                                                        );
                                                                    ref
                                                                        .read(cdvaluProvider
                                                                            .notifier)
                                                                        .update(
                                                                          (state) => item
                                                                              .cdvalu
                                                                              .toString(),
                                                                        );
                                                                    ref
                                                                        .read(cdcdlniyProvider
                                                                            .notifier)
                                                                        .update((state) => item
                                                                            .cdcdlniy
                                                                            .toString());
                                                                    AppPrint.debugLog(
                                                                        "cmcmlniy from tap item checklist: $cmcmlniy -- ${item.cdcdlniy} -- $cdvaluDialog");
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
                                                                    "Input sesuatu...",
                                                              );
                                                  },
                                                ),
                                              ),
                                              10.h,
                                              // FOR NOTE DIALOG
                                              if (cdvaluDialog == "0" &&
                                                  noteDialog.isEmpty)
                                                Text(
                                                  "Note Wajib Diisi",
                                                  style: AppTextStyle
                                                      .commonTextStyle
                                                      .copyWith(
                                                    color: Colors.red,
                                                  ),
                                                ),
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
                                                  enabled:
                                                      cmcdlniy.isNotEmpty &&
                                                              cmcdlniy !=
                                                                  cdcdlniy ||
                                                          cmcdlniy.isEmpty,
                                                  conditionColor: false,
                                                  onChanged: (p0) {
                                                    ref
                                                        .read(noteDialogProvider
                                                            .notifier)
                                                        .update((state) => p0);
                                                    AppPrint.debugLog(
                                                        "NOTEE: $cmcdlniy -- $cdcdlniy");
                                                  },
                                                  validator: (value) {
                                                    if (cdvaluDialog == "0") {
                                                      return "Note wajib diisi";
                                                    }
                                                    return null;
                                                  },
                                                  label: cmremkItem.isNotEmpty
                                                      ? cmremkItem
                                                      : "Note",
                                                  labelStyle: AppTextStyle
                                                      .subTitleTextStyle
                                                      .copyWith(
                                                    color:
                                                        AppColors.borderColor,
                                                  ),
                                                ),
                                              ),
                                              10.h,

                                              // IMAGE DIALOG
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
                                                child: ckflkFiles.isEmpty
                                                    ? Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          SizedBox(
                                                            height: 120,
                                                            width: 450,
                                                            child: ListView
                                                                .builder(
                                                              itemCount: imagesDialog
                                                                      .isEmpty
                                                                  ? 1
                                                                  : imagesDialog
                                                                      .length,
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
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
                                                                    index,
                                                                    () {
                                                                      ref
                                                                          .read(imagesOnDialogProvider
                                                                              .notifier)
                                                                          .update(
                                                                              (state) {
                                                                        return state = state
                                                                            .where((element) =>
                                                                                imagesDialog[index] !=
                                                                                element)
                                                                            .toList();
                                                                      });
                                                                    },
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                          10.w,
                                                          if (imagesDialog
                                                                      .length <
                                                                  5 &&
                                                              imagesDialog
                                                                  .isNotEmpty)
                                                            _emptyImage(
                                                                takePhotoChecklistType:
                                                                    TakePhotoChecklistType
                                                                        .dialog),
                                                        ],
                                                      )
                                                    : getImagesDialog.when(
                                                        data: (data) {
                                                          return SizedBox(
                                                            height: 120,
                                                            child: ListView
                                                                .builder(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              itemCount:
                                                                  data.length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                final decodeImg =
                                                                    base64Decode(
                                                                        data[
                                                                            index]);
                                                                return Container(
                                                                  width:
                                                                      100, // Specify the width
                                                                  height:
                                                                      100, // Specify the height
                                                                  margin: const EdgeInsets
                                                                      .all(
                                                                      4.0), // Optional: to add spacing
                                                                  child: Image
                                                                      .memory(
                                                                    decodeImg,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          );
                                                        },
                                                        error: (error,
                                                                stackTrace) =>
                                                            const SizedBox(
                                                          height: 56,
                                                          child: Center(
                                                            child: Text(
                                                                "Maaf, terjadi kesalahan menampilkan gambar..."),
                                                          ),
                                                        ),
                                                        loading: () {
                                                          return Container(
                                                            height: 100,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        48),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18),
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  227,
                                                                  227,
                                                                  227),
                                                            ),
                                                            child: const Center(
                                                              child: Row(
                                                                children: [
                                                                  CircularProgressIndicator(),
                                                                  SizedBox(
                                                                      width: 8),
                                                                  Text(
                                                                      "Loading menampilkan gambar..."),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
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
                                                          ref.invalidate(
                                                              filesProvider);
                                                        },
                                                        title: "Cancel",
                                                        backgroundColor:
                                                            AppColors
                                                                .negativeColor),
                                                    10.w,
                                                    ButtonReusableWidget(
                                                        width: 150,
                                                        disabled: cmcdlniy
                                                                    .isNotEmpty &&
                                                                cmcdlniy ==
                                                                    cdcdlniy ||
                                                            cdvaluDialog ==
                                                                    "0" &&
                                                                noteDialog
                                                                    .isEmpty ||
                                                            saveChecklist
                                                                    .status ==
                                                                SaveChecklistStatus
                                                                    .loading ||
                                                            (cdtype.toLowerCase() ==
                                                                        'o' &&
                                                                    saveChecklist
                                                                            .status !=
                                                                        SaveChecklistStatus
                                                                            .loading
                                                                ? chooseCdcdlniy ==
                                                                    99
                                                                : false),
                                                        onPressed: () async {
                                                          await ref
                                                              .read(
                                                                  saveChecklistProvider
                                                                      .notifier)
                                                              .callSaveChecklist(
                                                                cmcmlniy:
                                                                    cmcmlniy,
                                                                cmacvl:
                                                                    cdvaluDialog,
                                                                cdcdlniy:
                                                                    cdcdlniy,
                                                                saveChecklistType:
                                                                    SaveChecklistType
                                                                        .dialog,
                                                                note:
                                                                    noteDialog,
                                                                files: files,
                                                              );
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
                                            MediaQuery.sizeOf(context).height *
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
                                            MediaQuery.sizeOf(context).height *
                                                0.3,
                                        child: const Center(
                                          child: CircularProgressIndicator
                                              .adaptive(),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ), actions: [
                                const SizedBox(),
                              ]);
                            });
                      }),
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
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: cmflkFiles.isEmpty
                          ? Row(
                              children: [
                                Row(
                                  children: List.generate(
                                      images.isEmpty ? 1 : images.length,
                                      (index) {
                                    if (images.isEmpty) {
                                      return _emptyImage(
                                          takePhotoChecklistType:
                                              TakePhotoChecklistType.detail);
                                    } else {
                                      return _image(images[index].path, index,
                                          () {
                                        ref
                                            .read(imagesDetailChecklistProvider
                                                .notifier)
                                            .update((state) {
                                          return state = state
                                              .where((element) =>
                                                  images[index] != element)
                                              .toList();
                                        });
                                      });
                                    }
                                  }),
                                ),
                                10.w,
                                if (images.length < 5 && images.isNotEmpty)
                                  _emptyImage(
                                      takePhotoChecklistType:
                                          TakePhotoChecklistType.detail),
                              ],
                            )
                          : getImages.when(
                              data: (data) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: data.map((image) {
                                      final decodeImg = base64Decode(image);
                                      return Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: MemoryImage(
                                                decodeImg,
                                              ),
                                              onError:
                                                  (exception, stackTrace) =>
                                                      const SizedBox(
                                                        child: Icon(
                                                          Icons.error,
                                                          size: 48,
                                                        ),
                                                      ),
                                              fit: BoxFit.cover),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                );
                              },
                              error: (error, stackTrace) => const SizedBox(
                                height: 56,
                                child: Center(
                                  child: Text(
                                      "Maaf, terjadi kesalahan menampilkan gambar..."),
                                ),
                              ),
                              loading: () {
                                return SizedBox(
                                  height: 56,
                                  child: Center(
                                    child: Row(
                                      children: [
                                        5.w,
                                        const Text("Loading..."),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                  10.h,
                ],
              ),
            ),
          ),
          if (saveChecklistState.status == SaveChecklistStatus.loading)
            const LoadingScreenWidget()
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
                    ref.invalidate(filesProvider);
                  },
                  title: "Cancel",
                  backgroundColor: AppColors.negativeColor),
            ),
            10.w,
            Expanded(
                child: ButtonReusableWidget(
                    disabled: images.isEmpty ||
                        saveChecklistState.status ==
                            SaveChecklistStatus.loading,
                    onPressed: () {
                      ref
                          .read(saveChecklistProvider.notifier)
                          .callSaveChecklist(
                              cmcmlniy: cmcmlniy,
                              cmacvl: "",
                              cdcdlniy: cdcdlniy,
                              note: _detailNoteC.text,
                              saveChecklistType: SaveChecklistType.page,
                              ckcknoiy: ckcknoiy,
                              files: files);
                    },
                    title: "Save",
                    backgroundColor: AppColors.primaryColor)),
          ],
        ),
      ),
    );
  }

  Color _buildTextColor(
    int index,
    bool isChoose,
    int cdvalu,
    String cmcdlniy,
    String cdcdlniy,
    String cmacvl,
  ) {
    if (isChoose) {
      return Colors.white;
    } else {
      if (cmcdlniy.isNotEmpty && cmcdlniy == cdcdlniy) {
        if (int.tryParse(cdValuColor) == index) {
          return Colors.white;
        }
        return Colors.black;
      } else {
        return Colors.black;
      }
    }
  }

  Color _buildColorOptions(
    int index,
    bool isChoose,
    int cdvalu,
    String cmcdlniy,
    String cdcdlniy,
    String cmacvl,
  ) {
    final dataBuildColorOptions = {
      "cdcdlniy": cdcdlniy,
      "cmcdlniy": cmcdlniy,
      "cdvalu": cdvalu,
      "index": index,
      "cmacvl": cmacvl,
    };

    AppPrint.debugLog("DATA BUILD COLOR OPTIONS: $dataBuildColorOptions");
    if (isChoose) {
      if (cdvalu == 0) {
        return Colors.red;
      } else {
        return Colors.green;
      }
    } else {
      if (cmcdlniy.isNotEmpty && cmcdlniy == cdcdlniy) {
        if (int.tryParse(cdValuColor) == index) {
          if (int.tryParse(cmacvl) == 0) {
            return Colors.red;
          } else {
            return Colors.green;
          }
        }
        return const Color.fromARGB(255, 227, 227, 227);
      } else {
        return const Color.fromARGB(255, 227, 227, 227);
      }
    }
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

  Widget _emptyImage(
      {required TakePhotoChecklistType takePhotoChecklistType,
      bool? disabled}) {
    return Row(
      children: [
        InkWell(
          onTap: disabled != null && disabled
              ? null
              : () async {
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
