import 'package:dio/dio.dart';
import 'package:doi2bibtex/bloc/repos/fetch_repo.dart';
import 'package:doi2bibtex/bloc/repos/format_repo.dart';
import 'package:doi2bibtex/bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchCubit extends Cubit<FetchState> {
  FetchCubit(this._bibtexRepo, this._formatRepo)
    : super(FetchState(AppState.notFetched, bibtex: null));

  final BibTeXRepo _bibtexRepo;
  final BibtexRepo _formatRepo;

  final Dio dio = Dio();

  Future<void> fetchDOI(String doi) async {
    emit(state.copyWith(state: AppState.fetching));
    try {
      final bibtexs = await _bibtexRepo.fetchDOI(doi);

      var merged = '';
      for (final bibtex in bibtexs) {
        merged = _formatRepo.mergeBibtex(merged, bibtex);
      }

      emit(state.copyWith(state: AppState.fetched, bibtex: merged));
    } catch (e) {
      print(e);
      emit(state.copyWith(state: AppState.fetchError));
    }
  }
}
