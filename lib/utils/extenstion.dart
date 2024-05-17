import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:assets_mobile/data/models/shift_model.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

extension Date on DateTime {
  String get formatDate {
    final date = DateFormat('dd-MM-yyyy').format(this);
    return date;
  }

  String get formateDate2 {
    final date = DateFormat('dd-MMM-yyyy').format(this);
    return date;
  }
}

extension DecryptA7 on List<String> {
  Map<String, dynamic> get decryptA7 {
    String result = '';
    for (final item in this) {
      final splitTwoChar = item._reverseFromList(2);
      final a = splitTwoChar._reverseFromList(3);
      List<int> bytes = base64.decode(a);
      String decodeBytes = utf8.decode(bytes);
      result += decodeBytes;
    }

    final splitThreeChar = result._reverseFromList(2);
    final splitFiveChar = splitThreeChar._reverseFromList(4);
    final splitSevenChar = splitFiveChar._reverseFromList(6);

    final decodeData = jsonDecode(splitSevenChar);

    if (decodeData is List) return {"Data": decodeData};
    return decodeData;
  }
}

extension Token on String {
  String get decodeBase64 {
    String output = replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }
    return utf8.decode(base64Url.decode(output));
  }

  Map<String, dynamic> get parseJwt {
    final parts = split(".");
    if (parts.length != 3) {
      throw Exception("Invalid access token");
    }

    final payload = parts[1].decodeBase64;
    final payloadMap = jsonDecode(payload);
    if (payloadMap is! Map<String, dynamic>) throw Exception("Invalid payload");
    return payloadMap;
  }

  bool get checkExpiredToken {
    final decodeToken = parseJwt;
    final dateNow = DateTime.now();
    final expiredToken = DateTime.fromMillisecondsSinceEpoch(
        int.parse(decodeToken["exp"].toString()) * 1000);
    AppPrint.debugPrint(
        "EXPIRED TOKEN: $expiredToken -- DATE now: ${DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch)}");
    if (expiredToken.isAfter(dateNow)) {
      return false;
    } else {
      return true;
    }
  }
}

extension A7Support on String {
  List<String> _splitChar(int splitItem) {
    List<String> result = [];
    for (int i = 0; i < length; i += splitItem) {
      int endIndex = i + splitItem;
      if (endIndex > length) {
        endIndex = length;
      }
      String chunk = substring(i, endIndex);
      result.add(chunk);
    }
    return result;
  }

  String _reverseFromList(int itemIndex) {
    final splitChar = _splitChar(itemIndex);
    final reversedData =
        splitChar.map((e) => e.split('').reversed.join()).toList().join();
    final a = reversedData._splitChar(itemIndex);
    return a.join().split("").reversed.toList().join();
  }

  String _replaceNonASCII() {
    RegExp re = RegExp(r'[^\x00-\x7F]');
    final nonASci = replaceAll(re, '');
    return nonASci;
  }

  List<String> _strSplit(int chunkSize) {
    List<String> chunks = [];
    List<int> runes = this.runes.toList();

    if (runes.isEmpty) {
      return [this];
    }

    int i = 0;

    while (i < runes.length) {
      int end = i + chunkSize;
      if (end > runes.length) {
        end = runes.length;
      }
      String chunk = String.fromCharCodes(runes.sublist(i, end));
      chunks.add(chunk);
      i = end;
    }

    return chunks;
  }

  String _strRev() {
    List<int> r = runes.toList();
    for (int i = 0, j = r.length - 1; i < r.length / 2; i++, j--) {
      int temp = r[i];
      r[i] = r[j];
      r[j] = temp;
    }
    return String.fromCharCodes(r);
  }

  String _strAcak(int jumlah) {
    List<String> r = [];
    List<String> kata = _strRev()._strSplit(jumlah);
    for (String value in kata) {
      String d0 = value._strRev();
      r.add(d0);
    }

    return r.join('');
  }

  List<String> _splitData(int chunkSize) {
    List<String> chunks = [];
    final regExp = RegExp('.{1,$chunkSize}(?<!,)');
    final matches = regExp.allMatches(this);
    for (Match match in matches) {
      chunks.add(match.group(0)!);
    }

    return chunks;
  }
}

extension EncryptA7<K, V> on Map<K, V> {
  String get encryptA7 {
    final encodeData = jsonEncode(this);

    List<int> randomRange = [3, 4, 5, 6, 7, 8, 9];

    String data = encodeData._replaceNonASCII();
    int randomInt = randomRange[Random().nextInt(randomRange.length)];
    List<String> result = [];

    data = data._strAcak(7);
    data = data._strAcak(5);
    data = data._strAcak(3);

    final kata = data._strSplit(randomInt);
    final joinKata = kata.join()._splitData(randomInt);

    for (String value in joinKata) {
      List<int> d1 = utf8.encode(value);
      String d2 = base64Encode(d1);
      String d3 = d2._strAcak(3);
      String d4 = d3._strAcak(2);
      result.add(d4);
    }
    List<String> replaceWhiteSpace =
        result.map((String item) => item.replaceAll(' ', '')).toList();

    return replaceWhiteSpace.join(",");
  }
}

extension Size on double {
  double percentageWidth(BuildContext context) {
    return MediaQuery.of(context).size.width * (this / 100);
  }

  double percentageHeight(
    BuildContext context,
  ) {
    return MediaQuery.of(context).size.height * (this / 100);
  }
}

extension CacheForExtension on AutoDisposeRef<Object?> {
  /// Keeps the provider alive for [duration].
  void cacheFor(Duration duration) {
    // Immediately prevent the state from getting destroyed.
    final link = keepAlive();
    // After duration has elapsed, we re-enable automatic disposal.
    final timer = Timer(duration, link.close);

    // Optional: when the provider is recomputed (such as with ref.watch),
    // we cancel the pending timer.
    onDispose(timer.cancel);
  }
}

extension Spacing on int {
  SizedBox get h {
    return SizedBox(
      height: toDouble(),
    );
  }

  SizedBox get w {
    return SizedBox(
      width: toDouble(),
    );
  }
}

extension DateTimeExtension on DateTime {
  String get dateFormat {
    DateFormat formatter = DateFormat("yyyyMMddHHmmss");

    return formatter.format(this);
  }
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

extension ShiftModelExtension on ShiftModel {
  bool get isDefault {
    return date.isEmpty && id.isEmpty && title.isEmpty;
  }
}
