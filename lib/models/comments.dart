import 'package:intl/intl.dart';

final dateformat = DateFormat.yMd();

class Comments {
  const Comments(
    {
    required this.author,
    required this.content,
    required this.date,
    }
  );
  final String author;
  final String content;
  final DateTime date;

  String get dateformatted {
    return dateformat.format(date);
  }

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
      author: json['author'],
      content: json['content'],
       date: json['date'],
    );
  }

}
  
