import 'package:flutter/material.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:quiz_app/pages/landing_page.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: scaffoldtext("About Us"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          width: double.infinity,
          decoration: BoxDecoration(
              //color: Colors.grey[300],
              boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurStyle: BlurStyle.normal,
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
               gradient: LinearGradient(
                    colors: [
                      Colors.grey[400]!,
                      Colors.grey[300]!,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 180,
                child: Image.asset(
                  "assets/images/logo-removebg-preview (1).png",
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Welcome to our Electronic Waste app! Our mission is to make a positive impact on the environment by promoting responsible disposal and recycling of electronic devices. With this user-friendly application, you can easily locate nearby e-Waste collection centers, learn about proper disposal methods, and even track your own recycling progress. Together, let's create a greener future by reducing electronic waste and preserving our planet. Join us in this important journey of sustainable technology management!",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: const TextSpan(
                  text: '© ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: 'E-Waste Management Company',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
