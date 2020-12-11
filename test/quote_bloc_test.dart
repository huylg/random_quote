import 'package:random_quote/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FetchQuote event = FetchQuote();

  test('should assert if null', () {
    expect(() => QuoteBloc(quoteRepository: null), throwsA(isAssertionError));
  });
}
