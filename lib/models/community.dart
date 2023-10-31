import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Community {
  Community(
     {
    required this.title,
    required this.author,
    required this.date,
    required this.content,
    required this.image,
    this.isFeatured = false,
  }) : id = uuid.v4();
  
  final String id;
  final String title;
  final String author;
  final String date;
  final String content;
  final String image;
  bool isFeatured;

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      title: json['title'],
      author: json['author'],
      date: json['date'],
      content: json['content'],
      image: json['image'],
    );
  }
}

  

