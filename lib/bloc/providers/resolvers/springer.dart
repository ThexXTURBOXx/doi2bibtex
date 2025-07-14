import 'package:dio/dio.dart';
import 'package:doi2bibtex/api/bib_resolver.dart';
import 'package:doi2bibtex/no_cors.dart';

class SpringerResolver implements BibResolver {
  @override
  bool shouldResolve(String doi, Uri? resolved) {
    return resolved != null && resolved.host == 'link.springer.com';
  }

  @override
  int getPriority(String doi, Uri? resolved) {
    return 1;
  }

  @override
  Future<String?> resolveDOI(Dio dio, String doi, Uri? resolved) async {
    if (resolved == null) return null;

    final resp = await postNoCors(
      dio,
      'https://citation-needed.springer.com/v2/references/$doi?format=bibtex&flavour=citation',
    );
    return resp.data.toString();
  }
}
