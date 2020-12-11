import 'package:flutter/cupertino.dart';
import 'package:random_quote/data_model/models.dart';
import 'package:random_quote/data_provider/quote_api_client.dart';

class QuoteRepository {
  final QuoteApiClient quoteApiClient;

  QuoteRepository({@required this.quoteApiClient})
      : assert(quoteApiClient != null);

  Future<Quote> fetchQuote() => quoteApiClient.fetchQuote();
}
