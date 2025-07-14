class BlocState {
  const BlocState(this.state);

  final AppState state;

  bool get finished => state.finished;

  bool get errored => state.errored;
}

class FetchState extends BlocState {
  const FetchState(super.state, {this.bibtex});

  final String? bibtex;

  FetchState copyWith({AppState? state, bibtex}) =>
      FetchState(state ?? this.state, bibtex: bibtex ?? this.bibtex);
}

enum AppState {
  notFetched,
  fetching,
  fetched(finished: true),
  fetchError(finished: true, errored: true);

  const AppState({this.finished = false, this.errored = false});

  final bool finished;
  final bool errored;
}
