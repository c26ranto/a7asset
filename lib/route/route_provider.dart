import 'package:assets_mobile/presentation/checklist/checklist_detail_screen.dart';
import 'package:assets_mobile/presentation/checklist/summary_checklist_screen.dart';
import 'package:assets_mobile/presentation/history/checklist_history_screen.dart';
import 'package:assets_mobile/presentation/login/login_screen.dart';
import 'package:assets_mobile/presentation/main/main_screen.dart';
import 'package:assets_mobile/presentation/profile/profile_screen.dart';
import 'package:assets_mobile/presentation/scan/result_scan_machine.dart';
import 'package:assets_mobile/presentation/scan/scan_machine_screen.dart';
import 'package:assets_mobile/presentation/scan/temp_result_screen.dart';
import 'package:assets_mobile/presentation/shift/choose_checklist_period_screen.dart';
import 'package:assets_mobile/presentation/shift/choose_shift_screen.dart';
import 'package:assets_mobile/presentation/splash/splash_screen.dart';
import 'package:assets_mobile/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'route_provider.g.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    initialLocation: RouteName.splash,
    routes: [
      GoRoute(
        path: RouteName.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteName.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteName.main,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: RouteName.chooseShift,
        builder: (context, state) => const ChooseShift(),
      ),
      GoRoute(
        path: RouteName.chooseChecklistPeriod,
        builder: (context, state) {
          return const ChooseChecklistPeriodScreen();
        },
      ),
      GoRoute(
        path: RouteName.checklistHistory,
        builder: (context, state) => const ChecklistHistoryScreen(),
      ),
      GoRoute(
        path: RouteName.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: RouteName.scanMachine,
        builder: (context, state) => const ScanMachineScreen(),
      ),
      GoRoute(
        path: RouteName.resultScanMachine,
        builder: (context, state) => const ResultScanMachineScreen(),
      ),
      GoRoute(
        path: RouteName.tempResultScanMachine,
        builder: (context, state) => const TempResultScreen(),
      ),
      GoRoute(
        path: RouteName.checklistDetail,
        builder: (context, state) => const ChecklistDetailScreen(),
      ),
      GoRoute(
          path: RouteName.summaryChecklist,
          builder: (context, state) {
            return const SummaryChecklistScreen();
          }),
    ],
  );
}
