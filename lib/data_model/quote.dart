import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  final String id;
  final String quoteText;
  final String quoteAuthor;
  const Quote({this.id, this.quoteText, this.quoteAuthor});

  @override
  List<Object> get props => [this.id, this.quoteText, this.quoteAuthor];

  static Quote fromJson(dynamic json) {
    return Quote(
      id: json['_id'],
      quoteText: json['quoteText'],
      quoteAuthor: json['quoteAuthor'],
    );
  }
}
