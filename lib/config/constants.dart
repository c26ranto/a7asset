import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseUrl {
  static String ipAddressApi = dotenv.env["ipAddressApi"] ?? "";
  static String ipAddressApiHrms = dotenv.env["ipAddressApiHrms"] ?? "";
  static String urlFileImage = dotenv.env["urlFileImage"] ?? "";
}

class AppConstants {
  static bool get isDemo {
    final isDemo = dotenv.env["isDemo"] ?? "";

    if (isDemo == 'false') {
      return false;
    }
    return true;
  }
}

const dummyApkVersi = "1.0.0";
