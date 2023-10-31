import 'package:flutter/material.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:quiz_app/pages/admin.dart';

class adminProfile extends StatelessWidget {
  const adminProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
         elevation: 8.0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const AdminScreen()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
        ),
        title: scaffoldtext("Profile"),
        centerTitle: true,
      ),
      body: const Center(
        child: Hero(
          transitionOnUserGestures: true,
          tag:"My Profile Picture",
          child: Icon(
                  Icons.account_circle_rounded,
                  size: 100,
                  color: Colors.blueGrey,
                ),
        ),
      ),
    );
  }
}