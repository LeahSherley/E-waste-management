import 'package:flutter/material.dart';
import 'package:quiz_app/pages/home.dart';
import 'package:quiz_app/pages/bin_location.dart';

import 'package:quiz_app/pages/news.dart';
import 'package:quiz_app/pages/schedule.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int currentIndex = 0;
  final bar = [
    const home(),
    const schedule(),
    const location(),
    news(),
  ];

  List<BottomNavigationBarItem> barItem = [
    const BottomNavigationBarItem(
      label: "Home",
      icon: Icon(
        Icons.home_rounded,
      ),
    ),
    const BottomNavigationBarItem(
      label: "Schedule",
      icon: Icon(
        Icons.calendar_month_rounded,
      ),
    ),
    const BottomNavigationBarItem(
      label: "Centers",
      icon: Icon(
        Icons.location_pin,
      ),
    ),
    const BottomNavigationBarItem(
      label: "Information",
      icon: Icon(
        Icons.loyalty_outlined,
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bar[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        currentIndex: currentIndex,
        items: barItem,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[300],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
