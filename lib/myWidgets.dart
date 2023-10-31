import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget textformfieldlogin(String hint, TextEditingController con, Icon conss,
    {bool? enabled, bool obscureText = false,}) {
  return TextFormField(
    obscureText: obscureText,
    controller: con,
    decoration: InputDecoration(
      prefixIcon: conss,
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 11.5, color: Colors.grey),
      filled: true,
      fillColor: Colors.transparent,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.blueGrey),
      ),
    ),
  );
}

Widget mytext(String text,
    {double size = 11.5, Color textColor = Colors.blueGrey}) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.grey,
      fontSize: 11.5,
    ),
  );
}
Widget maptext(String text,
    {double size = 10, Color textColor = Colors.blueGrey}) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.grey,
      fontSize: 10,
    ),
  );
}
Widget hometext(String text,
    {double size = 11, Color textColor = Colors.blueGrey}) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.grey,
      fontSize: 11,
    ),
  );
}
Text alerttext(){
  return const Text(
    'Please note that all Pick-Ups are done between 10AM and 2PM',
    style: TextStyle(
      color: Colors.grey,
      fontSize: 10,
    ),
  );
}

Widget qnatext(String text,
    {double size = 11, Color textColor = Colors.blueGrey}) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.grey,
      fontSize: 11,
    ),
    textAlign: TextAlign.center,
  );
}

Widget notificationtext(String text,
    {double size = 11.5, Color textColor = Colors.blueGrey}) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.grey,
      fontSize: 11.5,
      fontWeight: FontWeight.w500,
    ),
    textAlign: TextAlign.center,
  );
}

Widget recyclingtext(String text,
    {double size = 11, Color textColor = Colors.blueGrey}) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.grey,
      fontSize: 11,
      //letterSpacing: 0.3,
      //fontWeight: FontWeight.w500,
    ),
    textAlign: TextAlign.center,
  );
}

Widget scheduletext(String text,
    {double size = 11, Color textColor = Colors.blueGrey}) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.grey,
      fontSize: 11,
      //fontWeight: FontWeight.w500,
    ),
    textAlign: TextAlign.center,
  );
}

Widget locationtext2(String text,
    {double size = 8, Color textColor = Colors.blueGrey}) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.grey,
      fontSize: 8,
      //fontWeight: FontWeight.w500,
    ),
    textAlign: TextAlign.center,
  );
}

Widget chatbot(String message, int data) {
  return Container(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0
              ? const SizedBox(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.account_circle_rounded,
                      size: 40,
                    ),
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Bubble(
              radius: const Radius.circular(15),
              color: data == 0 ? Colors.blueGrey : Colors.grey,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: Text(
                          message,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          data == 1
              ? const SizedBox(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.account_circle_rounded, size: 40),
                  ),
                )
              : Container(),
        ]),
  );
}

Widget text(String text,
    {double size = 10, Color textColor = Colors.blueGrey}) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.grey,
      fontSize: 10,
    ),
   
  );
}
Widget bytext(String text,
    {double size = 10, Color textColor = Colors.blueGrey}) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.blueGrey,
      fontSize: 10,
    ),
    
  );
}

Widget textt(String text,
    {double size = 9, Color textColor = Colors.blueGrey}) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.grey,
      fontSize: 9,
    ),
  );
}

Widget heading(String text,
    {double size = 13, Color textColor = Colors.blueGrey}) {
  return Text(
    text,
    style: const TextStyle(
        color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600),
  );
}

Widget textformfieldlogintwo(TextEditingController con, IconButton conss,
    {Text}) {
  return TextFormField(
    readOnly: true,
    controller: con,
    decoration: InputDecoration(
      prefixIcon: conss,
      // hintText: hint,
      hintStyle: const TextStyle(fontSize: 11.5, color: Colors.grey),
      filled: true,
      fillColor: Colors.transparent,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.blueGrey),
      ),
    ),
  );
}

SnackBar mySnackBar(
  String message,
) {
  return SnackBar(
    elevation: 5.0,
    duration: const Duration(milliseconds: 6000),
    margin: const EdgeInsets.all(20),
    dismissDirection: DismissDirection.horizontal,
    action:
        SnackBarAction(
          label: "Undo", 
          textColor: Colors.grey, 
          onPressed: () {}),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.blueGrey,
    content: Text(
      message,
      textAlign: TextAlign.start,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

SnackBar mySnackBar2(
  String message,
) {
  return SnackBar(
    elevation: 5.0,
    duration: const Duration(milliseconds: 6000),
    margin: const EdgeInsets.all(20),
    dismissDirection: DismissDirection.horizontal,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.blueGrey,
    content: Text(
      message,
      textAlign: TextAlign.start,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

TextStyle calendertext() {
  return const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: Colors.grey,
  );
}

Widget scaffoldtext(String text) {
  return Text(text,
      style: const TextStyle(
        fontSize: 15,
        color: Colors.grey,
      ));
}

Widget textfield(String hint, TextEditingController con, IconButton cons) {
  return TextFormField(
    controller: con,
    decoration: (InputDecoration(
        prefixIcon: cons,
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
            width: 1.5,
            
          ),
        ),
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 11, color: Colors.grey))),
  );
}

Widget texttwo(String text) {
  return Text(text,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ));
}

Widget textthree(String text) {
  return Text(text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
      ));
}

Widget textnews(String text) {
  return Text(text,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ));
}

Widget locationtext(String text, Icon cons) {
  return Text(text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ));
}

class Prefs {
  Future addStringToSF(String key, String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, val);
  }

  Future<String?> getStringValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future addBooleanToSF(String key, bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, val);
  }

  Future<void> addDate(DateTime date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dateString = date.toIso8601String();
    await prefs.setString('adDate', dateString);
  }

  Future<DateTime?> getDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dateString = prefs.getString('adDate');
    if (dateString != null) {
      return DateTime.parse(dateString);
    } else {
      return null;
    }
  }
}
