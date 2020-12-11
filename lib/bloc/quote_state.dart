import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:random_quote/data_model/quote.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();

  @override
  List<Object> get props => [];
}

class QuoteLoading extends QuoteState {}

class QuoteEmpty extends QuoteState {}

class QuoteLoaded extends QuoteState {
  final Quote quote;

  const QuoteLoaded({@required this.quote}) : assert(quote != null);

  @override
  List<Object> get props => [quote];
}

class QuoteError extends QuoteState {
  final String messageError;

  const QuoteError({@required this.messageError})
      : assert(messageError != null);
}
