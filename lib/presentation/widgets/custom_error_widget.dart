import 'package:assets_mobile/config/shared_preferences_config.dart';
import 'package:assets_mobile/presentation/widgets/button_widget.dart';
import 'package:assets_mobile/route/route_name.dart';
import 'package:assets_mobile/route/route_provider.dart';
import 'package:assets_mobile/utils/app_assets.dart';
import 'package:assets_mobile/utils/app_error_message.dart';
import 'package:assets_mobile/utils/app_key.dart';
import 'package:assets_mobile/utils/app_text_Style.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CustomErrorWidgetType { screen, widget }

class CustomErrorWidget extends ConsumerWidget {
  final FlutterErrorDetails? errorDetails;
  final String? errorMessage;
  final VoidCallback? action;
  final String? imageUrl;
  final String? title;
  final String? buttonTitle;
  final CustomErrorWidgetType customErrorWidgetType;
  final TextStyle? errorMessageStyle;

  const CustomErrorWidget({
    Key? key,
    this.errorDetails,
    this.errorMessage = "Terjadi kesalahan, silahkan coba lagi",
    this.customErrorWidgetType = CustomErrorWidgetType.screen,
    this.imageUrl,
    this.action,
    this.title,
    this.errorMessageStyle = AppTextStyle.subTitleTextStyle,
    this.buttonTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return (() {
      if (customErrorWidgetType == CustomErrorWidgetType.screen) {
        return Scaffold(
          body: Stack(
            children: [
              Image.asset(
                imageUrl ?? AppAssets.errorImage,
                fit: BoxFit.cover,
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
              ),
              Positioned(
                bottom: 200,
                left: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? 'Oops Sorry...',
                      style: _kTitleTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    5.h,
                    Text(
                      errorMessage ??
                          'Oops! The page you are looking for\nis not found',
                      style: _kSubtitleTextStyle.copyWith(
                        color: Colors.white54,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 100,
                left: 30,
                right: 250,
                child: _ReusablePrimaryButton(
                  childText: buttonTitle ?? 'Home',
                  buttonColor: Colors.white,
                  childTextColor: Colors.black,
                  onPressed: action ??
                      () async {
                        final token = await SharedPreferencesHelper.getString(
                            AppKey.token);
                        if (token.isEmpty) {
                          ref.read(routerProvider).go(RouteName.main);
                        } else {
                          ref.read(routerProvider).go(RouteName.splash);
                        }
                      },
                ),
              ),
            ],
          ),
        );
      } else {
        return Column(
          children: [
            Text(
              errorMessage ?? AppErrorMessage.internalServerError,
              style: errorMessageStyle,
            ),
            5.h,
            ButtonReusableWidget(
                onPressed: action ??
                    () async {
                      final token =
                          await SharedPreferencesHelper.getString(AppKey.token);
                      if (token.isEmpty) {
                        ref.read(routerProvider).go(RouteName.main);
                      } else {
                        ref.read(routerProvider).go(RouteName.splash);
                      }
                    },
                title: title ?? "Refresh"),
          ],
        );
      }
    }());
  }
}

const _kTitleTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 25,
  letterSpacing: 1,
  fontWeight: FontWeight.w500,
);

const _kSubtitleTextStyle = TextStyle(
  color: Colors.black38,
  fontSize: 16,
  letterSpacing: 1,
  fontWeight: FontWeight.w500,
);

class _ReusablePrimaryButton extends StatelessWidget {
  const _ReusablePrimaryButton({
    Key? key,
    required this.childText,
    required this.onPressed,
    required this.buttonColor,
    required this.childTextColor,
  }) : super(key: key);

  final String childText;
  final Function onPressed;
  final Color buttonColor;
  final Color childTextColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed as VoidCallback,
      child: Container(
        height: 40,
        width: MediaQuery.sizeOf(context).width / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: buttonColor,
        ),
        child: Center(
            child: Text(
          childText.toUpperCase(),
          style: TextStyle(
            fontSize: 16,
            color: childTextColor,
            fontWeight: FontWeight.w600,
          ),
        )),
      ),
    );
  }
}
