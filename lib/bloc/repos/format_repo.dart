import 'package:doi2bibtex/bloc/providers/petit_provider.dart';

class BibtexRepo {
  final _petitProvider = PetitProvider();

  String formatBibtex(String bibtex) => _petitProvider.formatBibtex(bibtex);

  String mergeBibtex(String orig, String override) =>
      _petitProvider.mergeBibtex(orig, override);
}
