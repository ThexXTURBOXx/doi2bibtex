import 'package:dio/dio.dart';
import 'package:doi2bibtex/api/bib_resolver.dart';
import 'package:doi2bibtex/no_cors.dart';

class IEEEResolver implements BibResolver {
  @override
  bool shouldResolve(String doi, Uri? resolved) {
    return resolved != null && resolved.host == 'ieeexplore.ieee.org';
  }

  @override
  int getPriority(String doi, Uri? resolved) {
    return 1;
  }

  @override
  Future<String?> resolveDOI(Dio dio, String doi, Uri? resolved) async {
    if (resolved == null) return null;

    String docId = resolved.pathSegments.where((s) => s.isNotEmpty).last;
    final resp = await postNoCors(
      dio,
      'https://ieeexplore.ieee.org/rest/search/citation/format',
      data: {
        "recordIds": [docId],
        "download-format": "download-bibtex",
        "lite": true,
      },
      extraHeaders: {"referer": "https://ieeexplore.ieee.org/"},
    );
    return resp.data['data'].toString();
  }
}
