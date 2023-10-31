// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:quiz_app/pages/about.dart';
import 'package:quiz_app/pages/communitylanding.dart';
import 'package:quiz_app/pages/contactus.dart';
import 'package:quiz_app/pages/profilepicture.dart';
import 'package:quiz_app/pages/recycling.dart';

import 'package:quiz_app/pages/splash_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class mainDrawer extends StatefulWidget {
  mainDrawer({super.key});

  @override
  State<mainDrawer> createState() => _mainDrawerState();
}

class _mainDrawerState extends State<mainDrawer> {
  late ScaffoldMessengerState scaffoldMessenger;
  final Prefs _prefs = Prefs();
  String? umail;
  String? user;

  /*Future<void> deleteAccount() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    final response = await http.delete(
      Uri.parse("https://randiki.000webhostapp.com/edeleteaccount.php"),
    );

    if (response.statusCode == 200) {
      print(response.statusCode);

      //print("Account Deleted");
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
      );
    } else {
      print("Failed to delete account: ${response.body}");
    }
  }*/
  Future<void> deleteAccount(String username) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final Uri url = Uri.parse(
        "https://randiki.000webhostapp.com/edeleteaccount.php?username=$user");
    print("Delete URL: $url");

    try {
      final response = await http.delete(url, headers: {
        "Content-Type": 'application/json',
      });

      if (response.statusCode == 200) {
        //print("Response Status Code: ${response.statusCode}");

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SplashScreen()),
        );
      } else {
        //print("Failed to delete account: ${response.body}");
        Navigator.pop(context);
      }
    } catch (error) {
      //print("Error occurred: $error");
      Navigator.pop(context);
    }
  }

  void logout() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await Future.delayed(const Duration(seconds: 5));

    Navigator.pop(context);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SplashScreen()),
    );
  }

  void profilepage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Profile()),
    );
  }

  @override
  Widget build(BuildContext context) {
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

    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Drawer(
      elevation: 8.0,
      width: 300.0,
      backgroundColor: Colors.grey[300],
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              "$user",
              style: const TextStyle(
                fontSize: 11.5,
                color: Colors.grey,
              ),
            ),
            accountEmail: Text(
              "$umail",
              style: const TextStyle(
                fontSize: 11.5,
                color: Colors.grey,
              ),
            ),
            currentAccountPicture: GestureDetector(
              onTap: profilepage,
              child: const Hero(
                transitionOnUserGestures: true,
                tag: "My Profile Picture",
                child: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.account_circle_rounded,
                    size: 70,
                  ),
                     /*Image.asset(
                    "assets/images/logo-removebg-preview (1).png",
                    height: 200,
                    color: Colors.blueGrey,
                  ),*/
                ),
              ),
            ),
          ),
          ListTile(
              visualDensity: const VisualDensity(
                horizontal: 0,
                vertical: -1.8,
              ),
              leading: const Icon(
                Icons.info_outline_rounded,
              ),
              title: const Text(
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                'About',
                selectionColor: Colors.blueGrey,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const About()),
                );
              }),
          const Divider(
            indent: 7.0,
            endIndent: 7.0,
          ),
          ListTile(
            visualDensity: const VisualDensity(
              horizontal: 0,
              vertical: -1.8,
            ),
            leading: const Icon(
              Icons.call_rounded,
            ),
            title: const Text(
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              'Contact Us',
              selectionColor: Colors.blueGrey,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Contact()),
              );
            },
          ),
          const Divider(
            indent: 7.0,
            endIndent: 7.0,
          ),
          ListTile(
              visualDensity: const VisualDensity(
                horizontal: 0,
                vertical: -1.8,
              ),
              leading: const Icon(
                Icons.group_rounded,
              ),
              title: const Text(
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                'Community',
                selectionColor: Colors.blueGrey,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const communityLanding()),
                );
              }),
          const Divider(
            indent: 7.0,
            endIndent: 7.0,
          ),
          ListTile(
              visualDensity: const VisualDensity(
                horizontal: 0,
                vertical: -1.8,
              ),
              leading: const Icon(
                Icons.recycling,
              ),
              title: const Text(
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                'Recycling Guide',
                selectionColor: Colors.blueGrey,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RecyclingGuidePage()),
                );
              }),
          const Divider(
            indent: 7.0,
            endIndent: 7.0,
          ),
          ListTile(
              visualDensity: const VisualDensity(
                horizontal: 0,
                vertical: -1.8,
              ),
              leading: const Icon(
                Icons.delete_rounded,
              ),
              title: const Text(
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                'Delete Account',
                selectionColor: Colors.blueGrey,
              ),
              onTap: () {
                const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                );
                deleteAccount("$user");
              }),
          const Divider(
            indent: 7.0,
            endIndent: 7.0,
          ),
          ListTile(
            visualDensity: const VisualDensity(
              horizontal: 0,
              vertical: -1.8,
            ),
            leading: const Icon(
              Icons.login_outlined,
            ),
            title: const Text(
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              'Log Out',
              selectionColor: Colors.blueGrey,
            ),
            onTap: () {
              //FirebaseAuth.instance.signOut();
              logout();
            },
          ),
          const Divider(
            indent: 7.0,
            endIndent: 7.0,
          ),
        ],
      ),

      //drawerItems,
    );
  }
}
