import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:quiz_app/pages/landing_page.dart';
import 'package:quiz_app/providers/profileprovider.dart';
import 'package:quiz_app/providers/theme.dart';
import 'package:share_plus/share_plus.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  String? user;
  File? _selectedImage;
  String? umail;

  Future<File?> uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }

    return null;
  }

  final Prefs _prefs = Prefs();

  @override
  Widget build(BuildContext context) {
    final selectedImage = ref.watch(profileProvider);
    _prefs.getStringValuesSF("email").then((email) {
      setState(() {
        umail = email;
      });
    });
    _prefs.getStringValuesSF("username").then((username) {
      setState(() {
        user = username;
      });
    });
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
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
        title: scaffoldtext("My Profile"),
        centerTitle: true,
      ),
      body: Center(
        child: Hero(
          transitionOnUserGestures: true,
          tag: "My Profile Picture",
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  File? image = await uploadImage();
                  ref.read(profileProvider.notifier).setImage(image);
                  setState(() {
                    _selectedImage = image;
                  });
                },
                child: _selectedImage != null
                    ? ClipOval(
                        child: Image.file(
                          _selectedImage!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(
                        Icons.account_circle_rounded,
                        size: 100,
                        color: Colors.blueGrey,
                      ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey[400]!,
                              Colors.grey[300]!,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [mytext("Username:"), mytext("$user")],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [mytext("Email:"), mytext("$umail")],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      height: 40,
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Share.share(
                            " https://play.google.com/store/apps/details?id=com.example.quiz_app",
                            subject: "E-Waste Mangement",
                          );
                        },
                        icon: const Icon(
                          Icons.share_rounded,
                          color: Colors.grey,
                          size: 16,
                        ),
                        label: mytext("Share App"),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),

                    /*Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      height: 40,
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => news()),
                          );
                        },
                        icon: const Icon(
                          Icons.login_outlined,
                          color: Colors.grey,
                          size: 16,
                        ),
                        label: mytext("Log Out"),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),*/
                  ],
                ),
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
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
