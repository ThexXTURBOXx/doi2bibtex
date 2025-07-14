import 'package:dio/dio.dart';

abstract class BibResolver {
  bool shouldResolve(String doi, Uri? resolved);

  int getPriority(String doi, Uri? resolved);

  Future<String?> resolveDOI(Dio dio, String doi, Uri? resolved);
}

Future<String?> tryResolveDOI(
  BibResolver resolver,
  Dio dio,
  String doi,
  Uri? resolved,
) async {
  try {
    return await resolver.resolveDOI(dio, doi, resolved);
  } catch (_) {
    // ignore exception
  }
  return null;
}
