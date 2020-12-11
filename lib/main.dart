import 'package:random_quote/bloc/bloc.dart';
import 'package:random_quote/bloc/quote_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:random_quote/data_provider/quote_api_client.dart';
import 'package:flutter/material.dart';
import 'package:random_quote/reposotpry/quote_repository.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final QuoteRepository repository = QuoteRepository(
      quoteApiClient: QuoteApiClient(httpClient: http.Client()));

  runApp(MyApp(
    quoteRepo: repository,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final QuoteRepository quoteRepo;
  MyApp({Key key, @required this.quoteRepo})
      : assert(quoteRepo != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Quote App')),
        body: BlocProvider(
          create: (context) {
            return QuoteBloc(quoteRepository: quoteRepo);
          },
          child: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuoteBloc bloc = BlocProvider.of(context);
    bloc.add(FetchQuote());
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is QuoteLoading) {
          return CircularProgressIndicator();
        } else if (state is QuoteLoaded) {
          final quote = state.quote;

          return ListTile(
            leading: Text('${quote.id}'),
            title: Text(quote.quoteText),
            isThreeLine: true,
            dense: true,
            subtitle: Text(quote.quoteAuthor),
          );
        } else if (state is QuoteEmpty) {
          return Center(
            child: Text('no quote'),
          );
        } else if (state is QuoteError) {
          final messageError = state.messageError;

          return Center(
            child: Text(messageError, style: TextStyle(color: Colors.red)),
          );
        }
        return Container();
      },
    );
  }
}
