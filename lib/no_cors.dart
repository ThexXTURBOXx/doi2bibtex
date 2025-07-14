import 'dart:convert';

import 'package:dio/dio.dart';

const noCorsPrefix =
    'https://cloudflare-cors-anywhere.nicomexis-nm.workers.dev/?';

Future<Response<T>> postNoCorsUri<T>(
  Dio dio,
  Uri uri, {
  Map<String, dynamic>? extraHeaders,
  Object? data,
  Options? options,
  CancelToken? cancelToken,
  ProgressCallback? onSendProgress,
  ProgressCallback? onReceiveProgress,
}) async => postNoCors(
  dio,
  uri.toString(),
  extraHeaders: extraHeaders,
  data: data,
  options: options,
  cancelToken: cancelToken,
  onSendProgress: onSendProgress,
  onReceiveProgress: onReceiveProgress,
);

Future<Response<T>> postNoCors<T>(
  Dio dio,
  String uri, {
  Map<String, dynamic>? extraHeaders,
  Object? data,
  Options? options,
  CancelToken? cancelToken,
  ProgressCallback? onSendProgress,
  ProgressCallback? onReceiveProgress,
}) async {
  if (extraHeaders != null) {
    options ??= Options();
    options.headers ??= {};
    options.headers!['x-cors-headers'] = jsonEncode(extraHeaders);
  }

  return dio.postUri(
    Uri.parse('$noCorsPrefix${Uri.encodeComponent(uri)}'),
    data: data,
    options: options,
    cancelToken: cancelToken,
    onSendProgress: onSendProgress,
    onReceiveProgress: onReceiveProgress,
  );
}
