import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:quiz_app/models/faqs.dart';

import 'package:quiz_app/myWidgets.dart';

import 'package:quiz_app/pages/main_drawer.dart';
import 'package:quiz_app/pages/news.dart';
import 'package:quiz_app/pages/notificationspage.dart';
import 'package:quiz_app/pages/recycling.dart';
import 'package:quiz_app/pages/schedule.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final Prefs _prefs = Prefs();
  String? user;
  String? nextCollectiondate;

  final faqs = [
    Faq(
      question: "How do I schedule a pickup?",
      answer:
          "To schedule a pickup, go to the Schedule Pick-Up section in the app. Choose a convenient date and time for the pickup, and provide details about the items you want to recycle. Once scheduled, our team will come to your location to collect the electronic waste.",
    ),
    Faq(
      question: "What types of electronic waste do you accept?",
      answer:
          "We accept a wide range of electronic waste, including but not limited to TVs, monitors, fridges, household appliances, computers, laptops, phones, radios, vending machines, coffee machines, bulbs, batteries, and solar panels. Refer to our Recycling Guide for a detailed list of accepted items.",
    ),
    Faq(
      question: "How can I join the community forum for recyclers?",
      answer:
          "To join the community forum for recyclers, navigate to the Recycler Community section in the app. Once registered, you'll be able to connect with other recyclers, share insights, ask questions, and exchange valuable recycling tips.",
    ),
    Faq(
      question: "Can I raise awareness about electronic waste on the app?",
      answer:
          "Absolutely! We encourage users to spread awareness about electronic waste and its impact on the environment. In the Community Forum, you can create posts, share articles and images related to e-waste. Engage with the community to educate and inspire others to adopt eco-friendly practices.",
    ),
    Faq(
      question: "How do I find nearby recycling centers?",
      answer:
          "The app uses your current location to show you a list of authorized recycling centers in your vicinity. You can get directions to the centers, check their operating hours, and learn about the types of waste they accept.",
    ),
    Faq(
      question: "Can I track the status of my scheduled pickup?",
      answer:
          "Yes, you can track the status of your scheduled pickup through the app. After scheduling, you'll receive notifications and updates regarding the pickup date, time, and progress. This feature ensures a transparent and convenient experience.",
    ),
    Faq(
      question: "How can I report an issue or give feedback?",
      answer:
          "We value your feedback! To report any issues or provide feedback, navigate to the Contact Us section in the app. You can submit your concerns, suggestions, or questions, and our support team will respond to you as soon as possible.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    _prefs.getStringValuesSF("username").then((username) => {
          setState(() {
            user = username;
            nextCollectiondate = '07/07/2023 at 10:30PM';
          })
        });
    final listtile = [
      ListTile(
          leading: SizedBox(
              height: 50,
              width: 50,
              child: Image.asset("assets/images/TVS-removebg-preview.png")),
          title: mytext(""),
          subtitle: hometext("Small Household \nAppliances; Screens, Microwave ovens"),
          isThreeLine: true),
      const Divider(
        indent: 7.0,
        endIndent: 7.0,
      ),
      ListTile(
          leading: SizedBox(
              height: 50,
              width: 50,
              child: Image.asset("assets/images/fridge-removebg-preview.png")),
          title: mytext(""),
          subtitle: hometext("Large Household \nAppliances; Fridges, Cookers"),
          isThreeLine: true),
      const Divider(
        indent: 7.0,
        endIndent: 7.0,
      ),
      ListTile(
          leading: SizedBox(
              height: 50,
              width: 50,
              child:
                  Image.asset("assets/images/computer-removebg-preview.png")),
          title: mytext(""),
          subtitle: hometext("Consumer Electronics; Laptops, Phones"),
          isThreeLine: true),
      const Divider(
        indent: 7.0,
        endIndent: 7.0,
      ),
      ListTile(
          leading: SizedBox(
              height: 50,
              width: 50,
              child: Image.asset("assets/images/vending-removebg-preview.png")),
          title: mytext(""),
          subtitle: hometext("Automatic Dispensers; Vending Machines"),
          isThreeLine: true),
      const Divider(
        indent: 7.0,
        endIndent: 7.0,
      ),
      ListTile(
        leading: SizedBox(
            height: 50,
            width: 50,
            child: Image.asset("assets/images/lamp-removebg-preview.png")),
        title: hometext(""),
        subtitle: hometext("Light Fixtures"),
        isThreeLine: true,
      ),
      const Divider(
        indent: 7.0,
        endIndent: 7.0,
      ),
      ListTile(
        leading: SizedBox(
            height: 50,
            width: 50,
            child: Image.asset("assets/images/plug-removebg-preview.png")),
        title: mytext(""),
        subtitle: hometext("IT Equipment; Printers, Cables, Plugs"),
        isThreeLine: true,
      ),
    ];

    return Scaffold(
      //backgroundColor: Colors.white,
      key: scaffoldkey,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: scaffoldtext("Home"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(
                Icons.notifications,
                size: 30,
                color: Colors.blueGrey,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Notify()),
                );
              }),
        ],
        leading: IconButton(
            icon: const Icon(
              Icons.account_circle_rounded,
              size: 30,
              color: Colors.blueGrey,
            ),
            onPressed: () {
              if (scaffoldkey.currentState!.isDrawerOpen) {
                scaffoldkey.currentState!.closeDrawer();
              } else {
                scaffoldkey.currentState!.openDrawer();
              }
            }),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      drawer: mainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Hello, $user!",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const Text(
                    "Welcome to a Sustainable Future!",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            /*Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    //color: Colors.grey[400],
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey[400]!,
                        Colors.grey[300]!,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                margin: const EdgeInsets.only(left: 24, right: 24, top: 15),
                width: double.infinity,
                child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /* Text(
                    "🗓️ Next Pick-Up Date: \n$nextCollectiondate",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),*/
                  
                ],
              ),
                ),
            const SizedBox(
              height: 7,
            ),*/
            Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurStyle: BlurStyle.outer,
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              width: double.infinity,
              child: ImageSlideshow(
                initialPage: 0,
                height: 205,
                indicatorRadius: 5,
                indicatorColor: Colors.blueGrey,
                autoPlayInterval: 8000,
                isLoop: true,
                children: [
                  Image.asset("assets/images/photo3.png", fit: BoxFit.cover),
                  Image.asset("assets/images/photo4.png", fit: BoxFit.fill),
                  Image.asset("assets/images/slide3.png", fit: BoxFit.cover),
                  Image.asset("assets/images/slide6.png", fit: BoxFit.fill),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
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
                  Icons.east_rounded,
                  color: Colors.grey,
                  size: 16,
                ),
                label: mytext("Learn More"),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              width: double.infinity,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Electronic Waste Categories",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  // color: Colors.grey[200],
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey[400]!,
                      Colors.grey[200]!,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              margin: const EdgeInsets.only(left: 20, right: 20, top: 18),
              width: double.infinity,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: listtile,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              height: 40,
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RecyclingGuidePage()),
                  );
                },
                icon: const Icon(
                  Icons.east_rounded,
                  color: Colors.grey,
                  size: 16,
                ),
                label: mytext("Recycling Guide"),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 7),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              width: double.infinity,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Frequently Asked Questions",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    //color: Colors.grey[200],
                    gradient: LinearGradient(
                      colors: [Colors.grey[400]!, Colors.grey[300]!],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                margin: const EdgeInsets.only(left: 20, right: 20, top: 18),
                width: double.infinity,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: faqs.map<Widget>((Faq faq) {
                    return ExpansionTile(
                      iconColor: Colors.blueGrey,
                      collapsedIconColor: Colors.blueGrey,
                      tilePadding: const EdgeInsets.all(16),
                      title: hometext(faq.question),
                      children: <Widget>[
                        ListTile(
                          title: qnatext(faq.answer),
                        ),
                      ],
                    );
                  }).toList(),
                )),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              height: 40,
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const schedule()),
                  );
                },
                icon: const Icon(
                  Icons.east_rounded,
                  color: Colors.grey,
                  size: 16,
                ),
                label: mytext("Schedule Pick-Up"),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
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
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
