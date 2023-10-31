import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:quiz_app/pages/landing_page.dart';


class Notify extends ConsumerWidget {
  const Notify({Key? key}): super(key: key);

  static const route = '/Notify';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   
    final arguments = ModalRoute.of(context)!.settings.arguments;
    RemoteMessage? message;
    String? payload;

    if (arguments != null && arguments is RemoteMessage) {
      message = arguments;
    }
    if (arguments != null && arguments is String) {
      payload = arguments;
    }
    final pages = [
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          width: double.infinity,
          decoration: BoxDecoration(
              //color: Colors.grey[300],
              gradient: LinearGradient(
                colors: [
                  Colors.grey[400]!,
                  Colors.grey[200]!,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  child: Image.asset(
                    "assets/images/logo-removebg-preview (1).png",
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 5),
                notificationtext(payload ?? "No Unread Notification"),
                notificationtext(""),
                const SizedBox(height: 15),
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
      ),
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          width: double.infinity,
          decoration: BoxDecoration(
              //color: Colors.grey[300],
              gradient: LinearGradient(
                colors: [
                  Colors.grey[400]!,
                  Colors.grey[200]!,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  child: Image.asset(
                    "assets/images/logo-removebg-preview (1).png",
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 5),
                notificationtext(message?.notification?.title ??
                    "No Unread Tips and Alerts"),
                notificationtext(message?.notification?.body ?? ""),
                // notificationtext(message?.data ??""),
                const SizedBox(height: 15),
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
            //mytext(payload ?? ""),
          ),
        ),
      ),
    ];
    final pagestitle = [
      Tab(
        icon: const Icon(
          Icons.notifications_active_rounded,
          color: Colors.grey,
        ),
        child: mytext("Notifications"),
      ),
      Tab(
        icon: const Icon(
          Icons.bookmark_add_rounded,
          color: Colors.grey,
        ),
        child: mytext("Reminders"),
      ),
    ];
    return DefaultTabController(
      length: pages.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 4.0,
          //forceMaterialTransparency: true,
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
          title: scaffoldtext("My Notifications"),
          centerTitle: true,
          bottom: TabBar(
            
           indicatorColor: Colors.grey,
            indicatorWeight: 3,
            tabs: pagestitle,
          ),
        ),
        body: TabBarView(
          children: pages,
        ),
        
      ),
    );
  }
}

