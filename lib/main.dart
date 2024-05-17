import 'dart:async';

import 'package:assets_mobile/config/provider_logging.dart';
import 'package:assets_mobile/config/shared_preferences_config.dart';
import 'package:assets_mobile/presentation/widgets/custom_error_widget.dart';
import 'package:assets_mobile/route/route_provider.dart';
import 'package:assets_mobile/utils/app_key.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    await dotenv.load(fileName: ".env");
    WidgetsFlutterBinding.ensureInitialized();
    await SharedPreferencesHelper.init();
    AppPrint.debugPrint("MAIN CALLED");
    // SAVE STATE FOR IDENTIFY USER HAS FIRST INSTALL APPS OR NOT
    final hasFirstInstall = await SharedPreferencesHelper.getBool(AppKey.hasFirstInstall);
    await SharedPreferencesHelper.saveData({AppKey.hasFirstInstall: hasFirstInstall});
    runApp(ProviderScope(
      observers: [
        MyObserver(),
      ],
      child: const MyApp(),
    ));
  }, (dynamic error, dynamic stack) {
    AppPrint.debugPrint(
      "Something went wrong! $error $stack",
      trace: stack,
    );
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      // key: AppNavigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return CustomErrorWidget(
            errorDetails: errorDetails,
          );
        };

        return child ?? const SizedBox();
      },
      routerConfig: router,
    );
  }
}
