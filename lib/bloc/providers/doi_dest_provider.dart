import 'package:dio/dio.dart';

class DOIDestProvider {
  Future<Uri?> resolveDOI(Dio dio, String doi) async {
    final resp = await dio.getUri(
      Uri.parse('https://doi.org/api/handles/$doi?type=URL'),
    );

    for (dynamic val in resp.data['values']) {
      dynamic data = val['data'];
      if (data == null) continue;

      dynamic url = data['value'];
      if (url != null) return Uri.tryParse(url.toString());
    }

    return null;
  }
}
