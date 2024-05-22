import 'package:assets_mobile/config/constants.dart';
import 'package:assets_mobile/config/shared_preferences_config.dart';
import 'package:assets_mobile/presentation/splash/provider/splash_provider.dart';
import 'package:assets_mobile/presentation/widgets/background_image_image.dart';
import 'package:assets_mobile/repositories/auth/provider/auth_repository_provider.dart';
import 'package:assets_mobile/route/route_name.dart';
import 'package:assets_mobile/route/route_provider.dart';
import 'package:assets_mobile/utils/app_key.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:assets_mobile/utils/app_text_Style.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../login/provider/login_provider.dart';

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
      final token = await SharedPreferencesHelper.getString(AppKey.token);
      final username = await SharedPreferencesHelper.getString(AppKey.username);
      final email = await SharedPreferencesHelper.getString(AppKey.email);
      final appDb = await SharedPreferencesHelper.getString(AppKey.appDB);
      final version = await SharedPreferencesHelper.getString(AppKey.version);

      ref.read(isDemoProvider.notifier).update((state) => AppConstants.isDemo);
      ref.read(tokenProvider.notifier).update((state) => token);
      ref.read(usernameProvider.notifier).update((state) => username);
      ref.read(emailProvider.notifier).update((state) => email);
      ref.read(versiProvider.notifier).update((state) => version);
      ref.read(databaseProvider.notifier).update((state) => appDb);
      ref.read(apiUrlProvider.notifier).update((state) => BaseUrl.ipAddressApi);

      if (token.isNotEmpty) {
        final checkExpired = token.checkExpiredToken;
        AppPrint.debugLog("CHECK EXPIRED: $checkExpired");
        if (checkExpired == true) {
          final result = await ref.read(authRepositoryProvider).refreshToken();
          await SharedPreferencesHelper.saveData(
              {AppKey.token: result["access_token"]});
          await Future.delayed(const Duration(seconds: 1));

          ref.read(routerProvider).go(RouteName.main);
        } else {
          ref.read(routerProvider).go(RouteName.main);
        }
      } else {
        ref.read(routerProvider).go(RouteName.login);
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
                  style: AppTextStyle.titleTextStyle
                      .copyWith(color: Colors.white, fontSize: 48),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
