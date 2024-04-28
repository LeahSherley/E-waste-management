import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/models/notifications.dart';
import 'package:quiz_app/models/pushnotifications.dart';
import 'package:quiz_app/pages/landing_page.dart';
import 'package:quiz_app/pages/notificationspage.dart';
import 'package:quiz_app/pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Notifications().initializeNotifications();
  await pushNotifications().pushNotification();

  runApp(
    const eWaste(),
  );
}

class eWaste extends StatefulWidget {
  const eWaste({super.key});

  @override
  State<eWaste> createState() => _eWasteState();
}

class _eWasteState extends State<eWaste> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoggedInStatus();
    Notifications();
    listenNotifications();
  }

  void listenNotifications() =>
      Notifications.onNotifications.stream.listen(onSelected);
      
  void onSelected(String? payload) {
    if (payload != null) {
      navigatorKey.currentState?.pushNamed(
        Notify.route,
        arguments: payload,
      );
    }
  }

  Future<void> checkLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      isLoggedIn = loggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        routes: {
          Notify.route: (context) => const Notify(),
        },
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blueGrey,
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: isLoggedIn ? const Landing() : SplashScreen(),
      ),
    );
  }
}
