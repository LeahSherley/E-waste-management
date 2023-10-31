import 'package:flutter/material.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:quiz_app/pages/notificationspage.dart';

class FullNotificationPage extends StatelessWidget {
  
  const FullNotificationPage({
    super.key,
  });

  //static const route = '/FullNotificationPage';
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    // RemoteMessage? message;
    String? payload;

    // if (arguments != null && arguments is RemoteMessage) {
    //  message = arguments;
    // }
    if (arguments != null && arguments is String) {
      payload = arguments;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const Notify()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
        ),
        title: scaffoldtext("Scheduled Pick Up"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey[300],
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
                notificationtext(payload!),
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
    );
  }
}
