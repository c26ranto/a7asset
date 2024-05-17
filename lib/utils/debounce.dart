import 'dart:async';

import 'package:flutter/material.dart';

class Debounce {
  final int miliseconds;

  Debounce({required this.miliseconds});

  Timer? _timer;

  void run(VoidCallback action) {
    close();
    _timer = Timer(Duration(milliseconds: miliseconds), action);
  }

  void close() {
    if (_timer != null) {
      _timer?.cancel();
    }
  }
}
