import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final indexDrawerProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

final listBodyMainProvider = StateProvider<List<Widget>>((ref) {
  return [
    const Center(
      child: Text("First"),
    ),
    const Center(
      child: Text("Second"),
    ),
    const Center(
      child: Text("Third"),
    ),
    const Center(
      child: Text("Fourth"),
    ),
  ];
});
