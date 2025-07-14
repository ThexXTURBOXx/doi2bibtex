import 'package:dio/dio.dart';
import 'package:doi2bibtex/api/bib_resolver.dart';

class CrossrefResolver implements BibResolver {
  @override
  bool shouldResolve(String doi, Uri? resolved) {
    return true;
  }

  @override
  int getPriority(String doi, Uri? resolved) {
    return 0;
  }

  @override
  Future<String?> resolveDOI(Dio dio, String doi, Uri? resolved) async {
    final resp = await dio.postUri(
      Uri.parse('http://dx.doi.org/$doi'),
      options: Options(headers: {'Accept': 'application/x-bibtex'}),
    );
    return resp.data.toString();
  }
}
