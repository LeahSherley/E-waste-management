import 'package:flutter/material.dart';
import 'package:quiz_app/models/myinformation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:quiz_app/pages/data.dart';
import 'package:quiz_app/pages/education.dart';
import 'package:quiz_app/pages/informationitems.dart';
import 'package:quiz_app/pages/landing_page.dart';

class news extends StatefulWidget {
  news({super.key});

  @override
  State<news> createState() => _newsState();
}

class _newsState extends State<news> {
  TextEditingController searchController = TextEditingController();
  
  void _onTapped(Information information) {
   final awarenessinformation = dataAwareness
        .where((awareness) => awareness.info.contains(information.id)).toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Education(
          label: information.topic,
          awareness: awarenessinformation,
        ),
      ),
    );
  }

   final allInformation = [
    const Information(
        image: "assets/images/logo-removebg-preview (1).png",
        id: "i1",
        topic: "Electronic Waste",
        color: Colors.blueGrey,
         icon: Icons.computer,
        ),
       
    const Information(
      image: "assets/images/logo-removebg-preview (1).png",
      id: "i2",
      topic: "Impact of Electronic Waste",
      color: Colors.blueGrey,
      icon: Icons.eco,
    ),
    Information(
      image: "assets/images/logo-removebg-preview (1).png",
      id: "i3",
      topic: "Electronic Waste Recycling",
      color: Colors.blueGrey.shade500,
      icon: Icons.cached,
    ),
    Information(
      image: "assets/images/logo-removebg-preview (1).png",
      id: "i4",
      topic: "Reducing Electronic Waste",
      color: Colors.blueGrey.shade500,
      icon: Icons.lightbulb,
    ),
    Information(
      image: "assets/images/logo-removebg-preview (1).png",
      id: "i5",
      topic: "Global Electronic Waste Crisis",
      color: Colors.blueGrey.shade500,
        icon: Icons.warning,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 8.0,
        centerTitle: true,
        actions: [
          IconButton(
              padding: const EdgeInsets.only(right: 12),
              icon: const Icon(
                Icons.share_rounded,
                size: 28,
                color: Colors.grey,
              ),
              onPressed: () {
                Share.share(" https://play.google.com/store/apps/details?id=com.example.quiz_app",
                subject: "E-Waste Mangement",
                );
              }),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Landing()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: Colors.grey, size: 28),
        ),
        title: const Text(
          "Insights",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: GridView(
        padding: const EdgeInsets.all(13),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3.2,
          mainAxisSpacing: 13,
        ),
        children: [
          for (final information in allInformation)
            InformationItems(
              information: information,
              onitemselected: () {
                _onTapped(information);
              },
            ),
        ],
      ),
    );
  }
}
