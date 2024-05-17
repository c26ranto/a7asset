import 'package:assets_mobile/utils/app_enums.dart';

class HttpClientParams {
  final String path;
  final Map<String, dynamic>? param;
  final Map<String, dynamic>? overrideParam;
  final String? token;
  final String method;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? headers;
  final String? controller;
  final String? subMethod;
  final String? appName;
  final String? mode;
  final String baseUrl;
  final String username;
  final String version;
  final String? source;
  final int? page;
  final int? start;
  final int? limit;
  final int? perPage;
  final bool? isEdit;
  final PostRequestType postRequestType;
  final String? tipeGrid;
  final String? filter;
  final List<dynamic>? sort;

  HttpClientParams({
    required this.path,
    this.postRequestType = PostRequestType.none,
    this.param,
    this.overrideParam,
    this.token,
    this.method = "GET",
    this.body,
    this.headers,
    this.controller,
    this.subMethod,
    this.baseUrl = "",
    this.appName,
    this.mode,
    this.username = "",
    this.version = "",
    this.tipeGrid,
    this.page,
    this.start,
    this.limit,
    this.perPage,
    this.source,
    this.filter,
    this.sort,
    this.isEdit,
  });
}
