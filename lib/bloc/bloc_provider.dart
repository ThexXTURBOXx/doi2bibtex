import 'package:doi2bibtex/bloc/cubits/fetch_bloc.dart';
import 'package:doi2bibtex/bloc/repos/fetch_repo.dart';
import 'package:doi2bibtex/bloc/repos/format_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DOI2BibTeXBlocProvider extends StatelessWidget {
  const DOI2BibTeXBlocProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
    providers: [
      RepositoryProvider<BibTeXRepo>(create: (context) => BibTeXRepo()),
      RepositoryProvider<BibtexRepo>(create: (context) => BibtexRepo()),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<FetchCubit>(
          create: (context) => FetchCubit(
            context.read<BibTeXRepo>(),
            context.read<BibtexRepo>(),
          ),
        ),
      ],
      child: child,
    ),
  );
}
