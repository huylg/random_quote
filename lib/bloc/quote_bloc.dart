import 'package:flutter/cupertino.dart';
import 'package:random_quote/reposotpry/quote_repository.dart';

import 'quote_event.dart';
import 'quote_state.dart';
import 'package:bloc/bloc.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final QuoteRepository quoteRepository;

  QuoteBloc({@required this.quoteRepository}) : assert(quoteRepository != null);

  @override
  QuoteState get initialState => QuoteLoading();

  @override
  Stream<QuoteState> mapEventToState(QuoteEvent event) async* {
    print(state);
    if (event is FetchQuote) {
      try {
        yield QuoteLoading();

        final quote = await quoteRepository.fetchQuote();
        print(quote);
        yield QuoteLoaded(quote: quote);
      } catch (e) {
        yield QuoteError(messageError: e.toString());
      }
    }
  }
}
