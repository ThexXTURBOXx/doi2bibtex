import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:doi2bibtex/api/bib_resolver.dart';
import 'package:doi2bibtex/bloc/providers/doi_dest_provider.dart';
import 'package:doi2bibtex/bloc/providers/resolvers/crossref.dart';
import 'package:doi2bibtex/bloc/providers/resolvers/ieee.dart';

class BibTeXRepo {
  final _dio = Dio();

  final _doiDestProvider = DOIDestProvider();

  final _bibResolvers = [CrossrefResolver(), IEEEResolver()];

  Future<List<String>> fetchDOI(String doi) async {
    final loc = await _doiDestProvider.resolveDOI(_dio, doi);
    final bibtexs = _bibResolvers
        .where((p) => p.shouldResolve(doi, loc))
        .sortedBy((p) => p.getPriority(doi, loc))
        .map((p) => tryResolveDOI(p, _dio, doi, loc))
        .toList(growable: false);

    var ret = <String>[];
    for (final futureBibtex in bibtexs) {
      final bibtex = await futureBibtex;
      if (bibtex != null) ret.add(bibtex);
    }
    return ret;
  }
}
