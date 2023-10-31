import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:quiz_app/models/awareness.dart';
import 'package:quiz_app/pages/landing_page.dart';
import 'package:quiz_app/pages/moreinformation.dart';
import 'package:quiz_app/providers/favorite.dart';

class Education extends ConsumerStatefulWidget {
  const Education({super.key, required this.label, required this.awareness});

  final String label;
  final List<Awareness> awareness;

  @override
  ConsumerState<Education> createState() => _EducationState();
}

class _EducationState extends ConsumerState<Education> {
  //bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final isFavorite = ref.watch(favoriteProvider);
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                padding: const EdgeInsets.only(right: 12),
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_outline,
                  color: isFavorite ? Colors.amber : Colors.grey,
                ),
                onPressed: () {
                  /* setState(() {
                    isFavorite = !isFavorite;
                  });*/
                  final favoriteNotifier =
                      ref.read(favoriteProvider.notifier);
                  favoriteNotifier.toggleFavorite();
                  
                }),
          ],
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
          title: scaffoldtext(widget.label),
        ),
        body: ListView.builder(
          itemCount: widget.awareness.length,
          itemBuilder: (context, index) =>
              MoreInfo(awareness: widget.awareness[index]),
        ));
  }
}
