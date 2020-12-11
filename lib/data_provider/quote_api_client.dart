import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:random_quote/data_model/quote.dart';

class QuoteApiClient {
  final _baseUrl = 'https://quote-garden.herokuapp.com';

  final http.Client httpClient;

  QuoteApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<Quote> fetchQuote() async {
    final url = '$_baseUrl/quotes/random';

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw new Exception('cant fetch data');
    }

    final json = jsonDecode(response.body);
    return Quote.fromJson(json);
  }
}
