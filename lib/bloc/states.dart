class BlocState {
  final AppState state;

  const BlocState(this.state);

  bool get finished => state.finished;

  bool get errored => state.errored;
}

class FetchState extends BlocState {
  const FetchState(
    super.state, {
    this.doi,
    this.resolved,
    this.bibtexs,
    this.bibtex,
  });

  final String? doi;
  final Uri? resolved;
  final List<String>? bibtexs;
  final String? bibtex;

  FetchState copyWith({
    AppState? state,
    String? doi,
    Uri? resolved,
    List<String>? bibtexs,
    String? bibtex,
  }) => FetchState(
    state ?? this.state,
    doi: doi ?? this.doi,
    resolved: resolved ?? this.resolved,
    bibtexs: bibtexs ?? this.bibtexs,
    bibtex: bibtex ?? this.bibtex,
  );
}

enum AppState {
  notFetched,
  fetching,
  fetched(finished: true),
  fetchError(finished: true, errored: true);

  final bool finished;
  final bool errored;

  const AppState({this.finished = false, this.errored = false});
}
