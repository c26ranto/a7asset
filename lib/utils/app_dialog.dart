import 'package:assets_mobile/presentation/scan/provider/scan_provider.dart';
import 'package:assets_mobile/presentation/widgets/button_widget.dart';
import 'package:assets_mobile/route/route_name.dart';
import 'package:assets_mobile/route/route_provider.dart';
import 'package:assets_mobile/utils/app_colors.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:assets_mobile/utils/app_text_Style.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppDialog {
  static void loadingDialog(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CupertinoAlertDialog(
            content: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.5,
              width: 58,
              child: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.5,
              width: 58,
              child: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          );
        },
      );
    }
  }

  static void errorDialog(
      BuildContext context, String errorMessage, void Function()? onPressed) {
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text(
              "Error",
            ),
            content: Text(errorMessage),
            actions: [
              CupertinoDialogAction(
                onPressed: onPressed,
                child: const Text("Ok"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Error",
            ),
            content: Text(errorMessage),
            actions: [
              CupertinoDialogAction(
                onPressed: onPressed,
                child: const Text("Ok"),
              ),
            ],
          );
        },
      );
    }
  }

  static void customDialog(
    BuildContext ctx,
    String? msg, {
    void Function()? onTapOke,
    Widget? content,
    List<Widget>? actions,
    Widget? title,
    bool? hasTokenExpired,
    bool? barrierDismissible,
    String? titleOnTapOk,
    TextStyle? styleOnTapOk,
  }) async {
    return showDialog(
      context: ctx,
      barrierDismissible: barrierDismissible ?? true,
      builder: (BuildContext context) => PopScope(
        onPopInvoked: (didPop) {},
        child: AlertDialog(
          backgroundColor: AppColors.bgColor2,
          // insetPadding: EdgeInsets.zero,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          title: title ?? const Text('Info..'),
          content: content ?? Text(msg ?? ""),
          actions: hasTokenExpired != null && hasTokenExpired
              ? [
                  ButtonReusableWidget(
                    onPressed: () => context.go('/'),
                    title: "Sign In",
                    backgroundColor: Colors.red.shade600,
                  ),
                ]
              : actions ??
                  <Widget>[
                    TextButton(
                      onPressed: onTapOke ??
                          () {
                            Navigator.of(context).pop(true);
                          },
                      child: Text(
                        titleOnTapOk ?? 'OK',
                        style: styleOnTapOk ??
                            const TextStyle(color: AppColors.thirdColor),
                      ),
                    ),
                  ],
        ),
      ),
    );
  }

  static popupScan(
      BuildContext context, String type, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer(builder: (_, ref, __) {
          Widget okButton = TextButton(
            child: Text(
              "Input Manually",
              style: AppTextStyle.subTitleTextStyle
                  .copyWith(color: AppColors.blue),
            ),
            onPressed: () {
              context.pop();
              controller.clear();
              inputManualDialog(
                context,
                controller: controller,
              );
            },
          );
          // set up the button
          Widget deleteButton = TextButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.qr_code),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Scan",
                  style: AppTextStyle.subTitleTextStyle
                      .copyWith(color: AppColors.blue),
                ),
              ],
            ),
            onPressed: () async {
              context.pop();
              context.push(RouteName.scanMachine);
              // ss(() {
              //   isLoadingPick = true;
              // });
              // bool scanned = await scanQR(type);
            },
          );

          // set up the AlertDialog
          return AlertDialog(
            backgroundColor: AppColors.bgCard,
            insetPadding: const EdgeInsets.all(10.0),
            title: Text(
              "Choose Input Type",
              style: AppTextStyle.subTitleTextStyle.copyWith(),
            ),
            content: SingleChildScrollView(
                child: Center(
                    child: Text("Choose these available option to pick machine",
                        style: AppTextStyle.commonTextStyle.copyWith()))),
            actions: [okButton, deleteButton],
          );
        });
      },
    );
  }

  static inputManualDialog(BuildContext context,
      {required TextEditingController controller}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text(
              "Type Machine Code",
              style:
                  AppTextStyle.subTitleTextStyle.copyWith(color: Colors.black),
            ),
            content: Consumer(
              builder: (_, ref, __) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: controller,
                        textCapitalization: TextCapitalization.characters,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), hintText: ""),
                      ),
                      10.h,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              ref
                                  .read(idQrCodeProvider.notifier)
                                  .update((state) => controller.text);
                              AppPrint.debugLog(
                                  "DATA MACHINE ID TIDAK NULL INPUT MANUAL ${controller.text}");
                              await ref
                                  .read(routerProvider)
                                  .pushReplacement(RouteName.resultScanMachine);
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.checklist,
                                    size: 18, color: AppColors.blue),
                                7.w,
                                Text(
                                  "Create Checklist",
                                  style: AppTextStyle.commonTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.blue),
                                ),
                              ],
                            ),
                          ),
                          5.w,
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              controller.clear();
                            },
                            child: Text(
                              "Cancel",
                              style: AppTextStyle.commonTextStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ));
      },
    );
  }
}
