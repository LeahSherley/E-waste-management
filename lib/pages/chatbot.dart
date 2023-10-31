import 'package:dialogflow_flutter/dialogflowFlutter.dart';
import 'package:dialogflow_flutter/googleAuth.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:quiz_app/pages/home.dart';
import 'package:quiz_app/pages/landing_page.dart';
import 'package:quiz_app/pages/schedule.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final messageController = TextEditingController();
  
   List<Map<dynamic, dynamic>> messages = [];
   void response(query) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/images/service.json")
            .build();
    DialogFlow dialogflow = DialogFlow(authGoogle: authGoogle, language: "en");
    AIResponse aiResponse = await dialogflow.detectIntent(query);
   
    setState(() {
      messages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()![0]["text"]["text"][0].toString()
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: scaffoldtext("My Assistant"),
        centerTitle: true,
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
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 20),
              child:
                  mytext("Today: ${DateFormat("Hm").format(DateTime.now())}"),
            ),
            Flexible(
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) => chatbot(
                    messages[index]['message'].toString(),
                    messages[index]['data']),
              ),
            ),
            const Divider(
              color: Colors.blueGrey,
              height: 5,
              indent: 18.0,
              endIndent: 10.0,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0,
                        ),
                        hintText: 'Type here...',
                        hintStyle:
                            TextStyle(fontSize: 11.5, color: Colors.grey),
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt_outlined,
                          color: Colors.blueGrey)),
                  IconButton(
                      onPressed: () {
                        if (messageController.text.isEmpty) {
                          //print("Null");
                        } else {
                          setState(() {
                            messages.insert(0,
                                {"data": 1, "message": messageController.text});
                          });
                          response(messageController.text);
                          messageController.clear();
                        }
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
                      icon: const Icon(Icons.send_outlined,
                          color: Colors.blueGrey)),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
