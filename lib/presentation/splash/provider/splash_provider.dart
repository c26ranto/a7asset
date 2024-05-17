import 'package:assets_mobile/presentation/login/provider/login_provider.dart';
import 'package:assets_mobile/repositories/splash/provider/splash_repository_provider.dart';
import 'package:assets_mobile/utils/app_key.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_provider.g.dart';

final isDemoProvider = StateProvider<bool>((ref) {
  return false;
});

final apiUrlProvider = StateProvider<String>((ref) {
  return "";
});

@riverpod
FutureOr<List<Map<String, dynamic>>> getConList(GetConListRef ref) async {
  final resp = await ref.read(splashRepositoryProvider).getConList();
  AppPrint.debugLog("RESPPPP: $resp");
  ref.read(serverProvider.notifier).update((state) => resp["data"][0]);

  return List<Map<String, dynamic>>.from(resp["data"]);
}

@riverpod
FutureOr<bool> checkExpired(CheckExpiredRef ref) async {
  final prefs = await SharedPreferences.getInstance();

  final token = prefs.getString(AppKey.token);

  AppPrint.debugLog("TOKEN SPLASH: $token");
  if (token == null) return true;

  final dataJWt = token.parseJwt;

  AppPrint.debugLog("GET DATA FROM JWT: $dataJWt");

  final date = DateTime.fromMillisecondsSinceEpoch(dataJWt["exp"] * 1000);

  AppPrint.debugLog("DATE EXP TOKEN: $date -- DATE NOW: ${DateTime.now()}");

  final isExpired = date.isBefore(DateTime.now());

  AppPrint.debugLog("IS EXPIRED: $isExpired");
  return isExpired;
}
