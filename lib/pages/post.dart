import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:quiz_app/models/community.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:quiz_app/pages/communityforum.dart';
import 'package:quiz_app/pages/landing_page.dart';

import 'package:quiz_app/providers/postprovider.dart';

class EwasteForumPage extends ConsumerStatefulWidget {
  const EwasteForumPage({super.key});

  @override
  ConsumerState<EwasteForumPage> createState() => _EwasteForumPageState();
}

class _EwasteForumPageState extends ConsumerState<EwasteForumPage> {
  final Prefs _prefs = Prefs();
  String? user;
  File? _selectedImage;
  List<Community> featuredPosts = [];
  //List<Community> forumPosts = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  bool isLoading = true;

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void addPost(Community post) {
    setState(() {
      //forumPosts.add(post);
      ref.read(forumPostsProvider.notifier).addPost(post);
    });
  }

  Future<File?> uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }

    return null;
  }
  void warning(BuildContext context) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: "Please provide all information to proceed.",
        titleColor: Colors.grey,
        confirmBtnColor: Colors.blueGrey,
        textColor: Colors.grey,
        borderRadius: 20,
        confirmBtnTextStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 11.5,
        ),
        
        );
  }

  void newPostDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(40),
          elevation: 12.0,
          shadowColor: Colors.grey[900],
          scrollable: true,
          backgroundColor: Colors.grey[300],
          title: const Text(
            'New Post',
            style: TextStyle(
              fontSize: 13,
              color: Colors.blueGrey,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.title_rounded,
                  ),
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: contentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.edit_rounded,
                  ),
                  hintText: 'Content',
                  hintStyle: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ),
              //const SizedBox(height: 25),
               _selectedImage != null
                  ? Image.file(
                      _selectedImage!,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: Center(
                          child: Icon(
                        Icons.image,
                        color: Colors.grey,
                        size: 48,
                      )),
                    ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    File? image = await uploadImage();
                    setState(() {
                      _selectedImage = image;
                    });
                  },
                  child: mytext('Select Image'),
                ),
              ),
             
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.blueGrey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              onPressed: () {
                String title = titleController.text;
                String content = contentController.text;
                String author = '$user';
                String date =
                    DateFormat("MMMM d, y").format(DateTime.now()).toString();
                File? image = _selectedImage;

                if(_selectedImage == null || titleController.text.isEmpty || contentController.text.isEmpty) {
                  warning(context);
                } else {
                  Community newPost = Community(
                  title: title,
                  author: author,
                  date: date,
                  content: content,
                  image: _selectedImage != null ? _selectedImage!.path : '',
                );
              
                // final posted = ref.watch(forumPostsProvider);
                newpost(
                    newPost.id, title, author, DateTime.now(), content, image!);
                addPost(newPost);
                Navigator.pop(context);
                }
              },
              child: const Text(
                'Post',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.blueGrey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> newpost(String postID, String title, String author,
      DateTime date, String content, File image) async {
    try {
      final Uri uri =
          Uri.parse("https://randiki.000webhostapp.com/eposts2.php");
      final request = http.MultipartRequest('POST', uri);

      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      String formattedDate = dateFormat.format(date);
     

      request.fields['id'] = postID;
      request.fields['title'] = title;
      request.fields['author'] = author;
      request.fields['date'] = formattedDate;
      request.fields['content'] = content;

      final mimeTypeData =
          lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]);
      final file = await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType.parse(mimeTypeData!),
      );
      //print(image.path);

      request.files.add(file);

      final response = await request.send();

      if (response.statusCode == 200) {
        //final jsonResponse = await response.stream.bytesToString();
        //final parsedResponse = json.decode(jsonResponse);

        //print(parsedResponse);
        //print(response.statusCode);
      } else {}
    } catch (e) {
      //print("Error $e");
    }
  }

  @override
  void initState() {
    super.initState();
    ref.read(forumPostsProvider.notifier).fetchPosts().then((value) => {
          setState(() {
            isLoading = false;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    final forumPosts = ref.watch(forumPostsProvider);
    _prefs.getStringValuesSF("username").then((username) => {
          setState(() {
            user = username;
          })
        });
    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const Landing()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
        ),
        title: scaffoldtext("Community Forum"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child:
                  mytext("Today: ${DateFormat("Hm").format(DateTime.now())}"),
            ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 24),
              width: double.infinity,
              child: const Text(
                "Highlighted",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 24, top: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurStyle: BlurStyle.outer,
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: ImageSlideshow(
                initialPage: 0,
                height: 200,
                indicatorRadius: 5,
                indicatorColor: Colors.blueGrey,
                autoPlayInterval: 7000,
                isLoop: true,
                children: [
                  Image.asset("assets/images/forum1.jpeg", fit: BoxFit.fill),
                  Image.asset("assets/images/forum2.png", fit: BoxFit.fill),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Divider(
              color: Colors.grey.shade400,
              indent: 15.0,
              endIndent: 15.0,
            ),
            const SizedBox(height: 18),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 24),
              width: double.infinity,
              child: const Text(
                "Recent Updates",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 8),
            isLoading
                ? const SizedBox(
                    height: 200,
                    child: Center(
                        child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    )),
                  )
                : forumPosts.isEmpty
                    ? SizedBox(
                        height: 200,
                        child: Center(
                          child: texttwo(
                            'No posts available',
                          ),
                        ),
                      )
                    : ListView.builder(
                        reverse: true,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: forumPosts.length,
                        itemBuilder: (context, index) {
                          return ForumPostCard(forumPosts[index]);
                        },
                      ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: newPostDialog,
        child: const Icon(Icons.add, color: Colors.grey),
      ),
    );
  }
}
