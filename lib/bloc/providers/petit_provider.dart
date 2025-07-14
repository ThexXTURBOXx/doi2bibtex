import 'package:petit_bibtex/bibtex.dart';

class PetitProvider {
  final parser = BibTeXDefinition().build();

  BibTeXEntry _parseEntry(String bibtex) =>
      parser.parse(bibtex).value.single as BibTeXEntry;

  String formatBibtex(String bibtex) => _formatBibtex(_parseEntry(bibtex));

  String _formatBibtex(BibTeXEntry entry) {
    final fields = entry.fields.entries
        .map((e) => '  ${e.key.toLowerCase()} = ${e.value},\n')
        .join('');
    return '@${entry.type.toLowerCase()}{${entry.key},\n$fields}';
  }

  String mergeBibtex(String orig, String override) =>
      _formatBibtex(_mergeBibtex(orig, override));

  BibTeXEntry _mergeBibtex(String orig, String override) {
    BibTeXEntry? origEntry, overrideEntry;

    try {
      origEntry = _parseEntry(orig);
    } catch (_) {
      // ignore exception
    }
    try {
      overrideEntry = _parseEntry(override);
    } catch (_) {
      // ignore exception
    }

    final fields = <String, String>{};
    if (origEntry != null) {
      for (final e in origEntry.fields.entries) {
        fields[e.key] = e.value;
      }
    }
    if (overrideEntry != null) {
      for (final e in overrideEntry.fields.entries) {
        fields[e.key] = e.value;
      }
    }

    return BibTeXEntry(
      type: overrideEntry?.type ?? origEntry?.type ?? 'undefined',
      key: overrideEntry?.key ?? origEntry?.key ?? 'undefined',
      fields: fields,
    );
  }
}
