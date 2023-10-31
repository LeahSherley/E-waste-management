// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:quiz_app/pages/adminposts.dart';
import 'package:quiz_app/pages/profilepicture.dart';



import 'package:quiz_app/pages/splash_screen.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/pages/useradmin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class adminDrawer extends StatefulWidget {
  const adminDrawer({super.key});

  @override
  State<adminDrawer> createState() => _adminDrawerState();
}

class _adminDrawerState extends State<adminDrawer> {
  late ScaffoldMessengerState scaffoldMessenger;
  final Prefs _prefs = Prefs();
  String? umail;
  String? user;
  late String username;
  void deleteFunction() {
    deleteAccount(username);
  }
  
  Future <void> deleteAccount(String username) async {
    var url = Uri.parse('http://randiki.000webhostapp.com/edeleteaccount.php');
    var response = await http.post(
      url, 
    body: {'username': username});

    if (response.statusCode == 200) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => SplashScreen()));
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
      width: 300.0,
      backgroundColor: Colors.white,
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
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.account_circle_rounded,
                    size: 70,
                  ),
                ),
              ),
            ),
          ),
          
          ListTile(
            visualDensity: const VisualDensity(
              horizontal: 0,
              vertical: -1.5,
            ),
              leading: const Icon(
                Icons.account_circle_rounded,
              ),
              title: const Text(
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                'Users',
                selectionColor: Colors.blueGrey,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Users()),
                      
                );
              }),
          const Divider(
            indent: 7.0,
            endIndent: 7.0,
          ),
          ListTile(
            visualDensity: const VisualDensity(
              horizontal: 0,
              vertical: -1.5,
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
                'Posts',
                selectionColor: Colors.blueGrey,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Posts()),
                      
                );
              }),
          const Divider(
            indent: 7.0,
            endIndent: 7.0,
          ),
          
          ListTile(
            visualDensity: const VisualDensity(
              horizontal: 0,
              vertical: -1.5,
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
          
        ]
      ),
      
    );
  }
}
