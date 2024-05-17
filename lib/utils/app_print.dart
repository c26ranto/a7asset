import 'dart:developer';

import 'package:flutter/foundation.dart';

class AppPrint {
  static void debugLog(String message, {StackTrace? trace}) {
    log(message, stackTrace: trace);
  }

  static void debugPrint(String message, {StackTrace? trace}) {
    if (kDebugMode) {
      print(message + '${trace ?? ''}');
    }
  }
}
