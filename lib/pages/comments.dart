import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quiz_app/models/comments.dart';
import 'package:quiz_app/models/community.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:quiz_app/pages/post.dart';
import 'package:quiz_app/providers/commentprovider.dart';

class CommentScreen extends ConsumerStatefulWidget {
  final Community post;

  const CommentScreen({super.key, required this.post});

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends ConsumerState<CommentScreen> {
  final Prefs _prefs = Prefs();
  String? user;
  //List comments = [];
  List<Comments> comments = [];
  bool isLoading = true;

  Future<void> createComment(
      String postId, String content, String author, DateTime date) async {
    try {
      final Uri uri =
          Uri.parse("https://randiki.000webhostapp.com/comments.php");
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      String formattedDate = dateFormat.format(date);

      Map data = {
        "post_id": postId,
        "content": content,
        "author": author,
        "date": formattedDate,
      };
      //print(data);

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );
      //print(response.body);

      if (response.statusCode == 200) {
        //print("${response.statusCode}");
      } else {}
    } catch (e) {
      //print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    ref
        .read(commentProvider.notifier)
        .fetchComments(widget.post.id)
        .then((value) => setState(() {
              isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final commentsFinal = ref.watch(commentProvider);
    final comments = commentsFinal[widget.post.id] ?? [];

    _prefs.getStringValuesSF("username").then((username) => {
          setState(() {
            user = username;
          })
        });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const EwasteForumPage()),
            );
          },
          icon: const Icon(Icons.close_rounded, color: Colors.grey),
        ),
        title: scaffoldtext("Comments"),
        centerTitle: true,
      ),
      body: isLoading
          ? const SizedBox(
              height: 400,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
              ),
            )
          : comments.isEmpty
              ? Center(
                  child: texttwo("No comments"),
                )
              : ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    //final comment = comments[index];
                    return ListTile(
                      visualDensity: const VisualDensity(
                        horizontal: 0,
                        vertical: -1.0,
                      ),
                      subtitle: Text(
                        'By $user on ${DateFormat("MMMM d, y").format(DateTime.now()).toString()}',
                        //'By $user on ${comment.dateformatted}',
                        style: const TextStyle(
                          fontSize: 7,
                          color: Colors.blueGrey,
                        ),
                      ),
                      title: Text(
                        comments[index],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          commentDialog(context);
        },
        child: const Icon(Icons.add, color: Colors.grey),
      ),
    );
  }

  void commentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController commentController = TextEditingController();
        return AlertDialog(
          elevation: 15.0,
          shadowColor: Colors.grey[900],
          backgroundColor: Colors.grey[300],
          title: const Text(
            'Comment',
            style: TextStyle(
              fontSize: 13,
              color: Colors.blueGrey,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: commentController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.edit_rounded),
                  hintText: 'Type here',
                  hintStyle: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: mytext('Cancel'),
            ),
            TextButton(
              onPressed: () {
                //final commentsProvider = ref.read(commentProvider.notifier);
                //commentsProvider.addComment(widget.post.id, commentController.text);
                // final comments = ref.read(commentProvider.notifier);
                // comments.addComment(commentController.text);
                //comments.add(commentController.text);

                setState(() {
                  final commentsProvider = ref.read(commentProvider.notifier);
                  commentsProvider.addComment(
                      widget.post.id, commentController.text);
                  createComment(
                    widget.post.id,
                    commentController.text,
                    user ?? '',
                    DateTime.now(),
                  );
                });
                Navigator.pop(context);
              },
              child: mytext('Add'),
            ),
          ],
        );
      },
    );
  }
}
