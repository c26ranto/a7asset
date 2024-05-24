import 'package:assets_mobile/config/http_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BaseUrl {
  static String ipAddressApi = dotenv.env["ipAddressApi"] ?? "";
  static String ipAddressApiOnline = dotenv.env["ipAddressApiOnline"] ?? "";
  static String ipAddressApiHrms = dotenv.env["ipAddressApiHrms"] ?? "";
  static String urlFileImage = dotenv.env["urlFileImage"] ?? "";
  static String urlFileImageOnline = dotenv.env["urlFileImageOnline"] ?? "";


  static Future<bool> checkLocal() async {
    var result = await http.get(Uri(host: ipAddressApi, path: "getConnList",), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }).timeout(const Duration(seconds: 5), onTimeout: () => http.Response('Error', 408));
    if (result.statusCode != 200){
      return false;
    }else{
      return true;
    }
  }
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
