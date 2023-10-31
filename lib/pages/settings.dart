import 'package:flutter/material.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:quiz_app/pages/landing_page.dart';
import 'package:quiz_app/pages/login.dart';
import 'package:quiz_app/pages/splash_screen.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  bool isDarkModeEnabled = false;
  late String username;
  Future<void> deleteAccount(String username) async {
    var url = Uri.parse('http://randiki.000webhostapp.com/edeleteaccount.php');
    var response = await http.post(url, body: {'username': username});

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => SplashScreen()));
    }
  }

  void logout() async {
    /* showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));*/
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
    //Navigator.pop(context);
  }
   void deleteFunction() {
    
      deleteAccount(username);

      /*await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: scaffoldtext("Settings"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SettingsList(
              lightTheme: SettingsThemeData(
                settingsListBackground: Colors.white54,
                dividerColor: Colors.grey.shade400,
                settingsSectionBackground: Colors.grey.shade300,
              ),
              shrinkWrap: true,
              contentPadding:
                  const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              sections: [
                SettingsSection(
                  //margin: const EdgeInsetsDirectional.all(0) ,
                  title: texttwo("General"),
                  tiles: [
                    SettingsTile.switchTile(
                      leading:
                          const Icon(Icons.notifications, color: Colors.grey),
                      initialValue: false,
                      onToggle: (value) {
                       /* setState(() {
                          value = true;
                        });*/
                      },
                      title: mytext("Notifications"),
                    ),
                    SettingsTile.switchTile(
                      leading:
                          const Icon(Icons.location_pin, color: Colors.grey),
                      initialValue: false,
                      onToggle: (value) {},
                      title: mytext("Location"),
                    ),
                    SettingsTile.switchTile(
                      leading: const Icon(Icons.nightlight_rounded,
                          color: Colors.grey),
                      initialValue: isDarkModeEnabled,
                      onToggle: (value) {
                        setState(() {
                          isDarkModeEnabled = true;
                        });
                      },
                      title: mytext("Dark Mode"),
                    ),
                  ],
                ),
                SettingsSection(title: texttwo("Account"), tiles: [
                  SettingsTile.navigation(
                    title: mytext("Delete Account"),
                    leading: const Icon(Icons.delete_forever_rounded,
                        color: Colors.grey),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.grey),
                    onPressed: (value) {
                      deleteFunction();
                    },
                  ),
                  SettingsTile.navigation(
                    title: mytext("Log Out"),
                    leading:
                        const Icon(Icons.login_outlined, color: Colors.grey),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.grey),
                    onPressed: (value) {
                      logout();
                    },
                  ),
                ]),
              ],
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
    );
  }
}
