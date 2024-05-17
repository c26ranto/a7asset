import 'package:assets_mobile/config/constants.dart';
import 'package:assets_mobile/presentation/splash/provider/splash_provider.dart';
import 'package:assets_mobile/presentation/widgets/background_image_image.dart';
import 'package:assets_mobile/route/route_name.dart';
import 'package:assets_mobile/route/route_provider.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:assets_mobile/utils/app_text_Style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    delayed();

    super.initState();
  }

  void delayed() {
    Future.delayed(const Duration(seconds: 1), () async {
      ref.read(isDemoProvider.notifier).update((state) => AppConstants.isDemo);
      final checkExpired = ref.read(checkExpiredProvider).value;
      AppPrint.debugLog("CHECK EXPIRED: $checkExpired");
      if (mounted) {
        if (checkExpired == null || checkExpired) {
          ref.read(routerProvider).go(RouteName.login);
        } else {
          ref.read(routerProvider).go(RouteName.main);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImageWidget(),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.5,
            left: 18,
            right: 18,
            child: Column(
              children: [
                Text(
                  "Welcome",
                  style: AppTextStyle.subTitleTextStyle.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  "ASSETS MOBILE",
                  style: AppTextStyle.titleTextStyle.copyWith(color: Colors.white, fontSize: 48),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
