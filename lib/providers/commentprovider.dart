import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CommentNotifier extends StateNotifier<Map<String, List<String>>> {
  CommentNotifier() : super({});

  void addComment(String postId, String comment) {
    state[postId] = [...(state[postId] ?? []), comment];
  }

 /* Future<List<Comments>> fetchComments(String postId) async {
    final response = await http.get(
      Uri.parse(
          'https://randiki.000webhostapp.com/fetchcomments.php?post_id=$postId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> commentsData = json.decode(response.body);
      final List<Comments> comments = commentsData.map((commentData) {
        return Comments.fromJson(commentData);
      }).toList();
      return comments;
    } else {
      throw Exception('Failed to load comments');
    }
  }*/
    Future<void> fetchComments (String postId) async {
    final response = await http
        .get(Uri.parse('https://randiki.000webhostapp.com/fetchcomments2.php'));
      
    if (response.statusCode == 200) {
      //print(response.statusCode);
      final List<dynamic> commentsData = json.decode(response.body);
      final Map<String, List<String>> comments = {};
      //print(response.body);

      for (var commentData in commentsData) {
        final String postId = commentData['post_id'];
        final String comment = commentData['comments'];
        final String author = commentData['user'];
        final String date = commentData['date'];

        final fetchedComment = '$comment\nBy $author on $date';
        if (comments.containsKey(postId)) {
          comments[postId]!.add(fetchedComment);
        } else {
          comments[postId] = [fetchedComment];
        }

        if (comments.containsKey(postId)) {
          comments[postId]!.add(comment);
        } else {
          comments[postId] = [comment];
        }
      }
    } else {
      throw Exception('Failed to load comments');
    }
  }
}


final commentProvider =
    StateNotifierProvider<CommentNotifier, Map<String, List<String>>>(
  (ref) => CommentNotifier(),
);
