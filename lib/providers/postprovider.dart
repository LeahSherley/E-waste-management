import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/models/community.dart';

class ForumPostsNotifier extends StateNotifier<List<Community>> {
  ForumPostsNotifier() : super([]);

  void addPost(Community post) {
    final postIsAdded = state.contains(post);

    if(postIsAdded){
      state = state.where((p) => p.title != post.title).toList();
    }else {
      state = [...state, post];
    }
    
  }
  
  
 Future<void> fetchPosts() async {
    final response = await http.get(Uri.parse("https://randiki.000webhostapp.com/fetchposts.php"));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Community> posts = (jsonData as List)
          .map((item) => Community.fromJson(item))
          .toList();
      state = posts;
    } else {
      throw Exception('Failed to load posts: ${response.statusCode}');
    }
  }
  
}


final forumPostsProvider = StateNotifierProvider<ForumPostsNotifier, List<Community>>(
  (ref) => ForumPostsNotifier(),
);


