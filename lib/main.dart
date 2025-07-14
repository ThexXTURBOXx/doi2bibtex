import 'package:clipboard/clipboard.dart';
import 'package:doi2bibtex/bloc/bloc_provider.dart';
import 'package:doi2bibtex/bloc/cubits/fetch_bloc.dart';
import 'package:doi2bibtex/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => DOI2BibTeXBlocProvider(
    child: MaterialApp(
      title: 'DOI2BibTeX',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const MyHomePage(title: 'DOI2BibTeX'),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FToast _toast = FToast();

  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _toast.init(context);
  }

  @override
  Widget build(BuildContext ctx) => Scaffold(
    appBar: AppBar(title: Text(widget.title)),
    body: Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 700),
        child: BlocBuilder<FetchCubit, FetchState>(builder: getContent),
      ),
    ),
  );

  Widget getContent(BuildContext context, FetchState state) {
    return Column(
      children: <Widget>[
        TextFormField(
          //TODO: remove
          initialValue: '10.1109/TEST.1999.805864',
          onFieldSubmitted: (doiField) {
            final doi = Uri.tryParse(doiField)?.path ?? doiField;
            fetch(context, doi);
          },
        ),
        Scrollbar(
          controller: controller,
          thumbVisibility: true,
          interactive: true,
          child: SingleChildScrollView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            child: SelectableText(state.bibtex ?? ''),
          ),
        ),
        ElevatedButton(
          child: const Text('Copy to clipboard'),
          onPressed: () {
            if (state.bibtex != null) {
              FlutterClipboard.copy(state.bibtex!);
              _toast.showToast(
                child: const Text('BibTeX copied to clipboard!'),
                gravity: ToastGravity.BOTTOM,
                toastDuration: const Duration(seconds: 2),
              );
            } else {
              _toast.showToast(
                child: const Text('Nothing to copy...'),
                gravity: ToastGravity.BOTTOM,
                toastDuration: const Duration(seconds: 2),
              );
            }
          },
        ),
      ],
    );
  }

  Future<void> fetch(BuildContext context, String doi) async {
    await context.read<FetchCubit>().fetchDOI(doi);
  }
}
