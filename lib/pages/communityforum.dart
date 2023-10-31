import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/models/community.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:quiz_app/pages/comments.dart';
import 'package:quiz_app/providers/likesprovider.dart';
import 'package:share_plus/share_plus.dart';

class ForumPostCard extends ConsumerStatefulWidget {
  final Community post;

  const ForumPostCard(this.post, {super.key});

  @override
  ConsumerState<ForumPostCard> createState() => _ForumPostCardState();
}

class _ForumPostCardState extends ConsumerState<ForumPostCard> {
  //int likes = 0;
  //bool isLiked = false;

  Widget displayImage() {
    if (widget.post.image.contains("/data/user")) {
      return Image.file(
        File(widget.post.image),
        height: 150,
        width: double.infinity,
        fit: BoxFit.cover,
        /*errorBuilder: (context, error, stackTrace) {
          return const SizedBox(
            height: 100,
            width: double.infinity,
            child: Center(
              child: Icon(
                Icons.image,
                color: Colors.grey,
                size: 50,
              ),
            ),
          );
        },*/
      );
    } else {
      return Image.network(
        'https://randiki.000webhostapp.com${widget.post.image}',
        height: 150,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          String imagePath = widget.post.image;
          if (widget.post.image.startsWith(
              '/storage/ssd5/808/18545808/public_html/userimages/')) {
            imagePath = imagePath.replaceFirst(
                '/storage/ssd5/808/18545808/public_html/userimages/', '');
          }

          String imageUrl =
              'http://randiki.000webhostapp.com/userimages/$imagePath';

          return Image.network(
            imageUrl,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
            
            /*errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: Center(
                        child: Icon(
                          Icons.image,
                          color: Colors.grey,
                          size: 50,
                        ),
                      ),
                    );
                  },*/
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //final likes = ref.watch(likesProvider);
    bool isLiked = ref.read(likesProvider.notifier).isLiked(widget.post.id);
    //int likesCount = likes[widget.post.id] ?? 0;

    return Card(
     shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), 
      ),
      elevation: 0,
      surfaceTintColor: Colors.blueGrey[700],
      shadowColor: Colors.blueGrey[700],
      clipBehavior: Clip.hardEdge,
      color: Colors.grey[300],
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            displayImage(),
            const SizedBox(
              height: 8,
            ),
            textthree(
              widget.post.title,
            ),
            const SizedBox(height: 8),
            bytext(
              'By ${widget.post.author} on ${widget.post.date}',
            ),
            const SizedBox(height: 8),
            text(widget.post.content),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    isLiked = !isLiked;
                    if (isLiked) {
                      ref
                          .read(likesProvider.notifier)
                          .increment(widget.post.id);
                    } else {
                      ref
                          .read(likesProvider.notifier)
                          .decrement(widget.post.id);
                    }
                  },
                ),
                const SizedBox(width: 130),
                IconButton(
                  icon: const Icon(Icons.comment_rounded, color: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentScreen(post: widget.post),
                      ),
                    );
                  },
                ),
               //const SizedBox(width: 0),
                IconButton(
                    padding: const EdgeInsets.only(right: 12),
                    icon: const Icon(
                      Icons.share_rounded,
                      //size: 28,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      Share.share(
                        " https://play.google.com/store/apps/details?id=com.example.quiz_app",
                        subject: "E-Waste Mangement",
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
