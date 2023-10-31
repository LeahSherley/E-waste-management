import 'package:flutter/material.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:quiz_app/pages/landing_page.dart';
import 'package:quiz_app/pages/post.dart';

class communityLanding extends StatefulWidget {
   
  const communityLanding({super.key});

  @override
  State<communityLanding> createState() => _communityLandingState();
}

class _communityLandingState extends State<communityLanding> {
  String? user;
  final Prefs _prefs = Prefs();

  

  @override
  Widget build(BuildContext context) {
    _prefs.getStringValuesSF("username").then((username) => {
          setState(() {
            user = username;
          })
        });
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
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
        elevation: 0,
      ),
      body: Container(
        //height: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(
          left: 20,
          top: 20,
          right: 20,
          bottom: 20,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow:  [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurStyle: BlurStyle.normal,
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            gradient: LinearGradient(
              colors: [Colors.grey[400]!, Colors.grey[300]!],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
           
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16),
                width: double.infinity,
                child: Text(
                  "Welcome to our Community forum $user!\nThis is a place where you can share your knowledge, ask questions, and engage with a community of like-minded individuals who are passionate about e-waste recycling and environmental conservation.",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              //const SizedBox(height: 0),
              Image.asset(
                "assets/images/community-removebg-preview.png",
                //height: 390,
              ),
              //const SizedBox(height: 0),
              Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.only(left: 40, right: 40),
                child: MaterialButton(
                  color: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EwasteForumPage())
                    );
                  },
                  child: const Text(
                    "Proceed",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11.5,
                    ),
                  ),
                ),
              ),
              
            ]),
      ),
    );
  }
}
