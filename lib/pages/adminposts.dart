import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quiz_app/models/community.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:quiz_app/pages/admin.dart';
import 'package:quiz_app/pages/communityforum.dart';
import 'package:quiz_app/providers/postprovider.dart';
import 'package:http/http.dart' as http;

class Posts extends ConsumerStatefulWidget {
  
  const Posts({super.key});

  @override
  ConsumerState<Posts> createState() => _PostsState();
}

class _PostsState extends ConsumerState<Posts> {
  TextEditingController searchController = TextEditingController();

  late List<Community> filteredPosts;
  final List<Community> post = [];

  late ScaffoldMessengerState scaffoldMessenger;
  bool isLoading = true;

 Future deleteposts(String title)async{
  final Uri url = Uri.parse("https://randiki.000webhostapp.com/deleteposts.php?title=$title");
  final response = await http.delete(url);
   if (response.statusCode == 200){
    print(response.statusCode);
   }
 }
  void filterPosts(String query) {
    setState(() {
      if (query.isEmpty) {
         print('Searching for: $query');
        filteredPosts = ref.read(forumPostsProvider);
      } else {
        query = query.toLowerCase();
        filteredPosts = ref
            .read(forumPostsProvider)
            .where((post) => post.author.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    filteredPosts = ref.read(forumPostsProvider);
    try {
      ref.read(forumPostsProvider.notifier).fetchPosts().then((value) => {
            setState(() {
              isLoading = false;
            })
          });

      filteredPosts = ref.read(forumPostsProvider);
    } catch (e) {
      //print("Error fetching posts: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    filteredPosts = ref.watch(forumPostsProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const AdminScreen()));
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
        ),
        title: scaffoldtext('Posts'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child:
                  mytext("Today: ${DateFormat("Hm").format(DateTime.now())}"),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 20, bottom: 5, right: 20, left: 20),
              width: double.infinity,
              height: 42,
              child: textfield(
                "Search by Author",
                searchController,
                IconButton(
                  icon: const Icon(Icons.search_rounded, size: 28),
                  onPressed: () {
                    filterPosts(searchController.text);
                  },
                ),
              ),
            ),
            filteredPosts.isEmpty
                ? const SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                      ),
                    ),
                  )
                : isLoading
                    ? SizedBox(
                      height: 200,
                        child: Center(
                          child: texttwo("No available Posts"),
                        ),
                      )
                    : ListView.builder(
                        reverse: true,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: filteredPosts.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            
                              key: Key(filteredPosts[index].id.toString()),
                              onDismissed: (direction) {
                                 final deletedPostTitle = filteredPosts[index].title;
                                setState(() {
                                  filteredPosts.removeAt(index);
                                  scaffoldMessenger.showSnackBar(
                                    mySnackBar2("Post Deleted"),
                                  );
                                });
                                deleteposts(deletedPostTitle);
                              },
                              child: ForumPostCard(filteredPosts[index]));
                        },
                      ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
