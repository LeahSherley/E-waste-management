// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/pages/admin.dart';
import 'package:quiz_app/pages/landing_page.dart';
import 'package:quiz_app/pages/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../myWidgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late ScaffoldMessengerState scaffoldMessenger;

  final Prefs _prefs = Prefs();
  bool isEmailValid = true;
  
  bool isEmailFormatValid(String email) {
    const pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  //final navigatorKey = GlobalKey<NavigatorState>();

  /* Future loginFunction() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context)
      =>
        const Center(
          child: CircularProgressIndicator())
      
    );
   try{
     await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
   } on FirebaseAuthException catch(error){
    print(error);
   }
   navigatorKey.currentState!.popUntil((route)=> route.isFirst);
   

  }*/

  void loginFunction() {
    if (emailController.text.isEmpty && passwordController.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        mySnackBar2("Provide Credentials"),
      );
    } else if (emailController.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        mySnackBar2("Provide Email"),
      );
      return;
    } else if (passwordController.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        mySnackBar2("Provide Password"),
      );
      return;
    } else {
      logIn(emailController.text, passwordController.text);

      /*await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );*/
    }
  }

  logIn(String email, String password) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    Map data = {"email": email, "password": password};
    var response = await http.post(
        Uri.parse("https://randiki.000webhostapp.com/elogin.php"),
        body: data);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          Navigator.pop(context);
        });
        int isRegistered = jsonResponse['code'];
        if (isRegistered == 1) {
          var email = jsonResponse['uemail'];
          var username = jsonResponse['uname'];
          var isAdmin = jsonResponse['is_admin'];
          //var password = jsonResponse["password"];

          setLoggedIn(true);
          _prefs.addStringToSF("email", email);
          _prefs.addStringToSF("username", username);
          //_prefs.addStringToSF("password", password);

          if (isAdmin == "1") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const AdminScreen()));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const Landing()));
          }
        } else {
          scaffoldMessenger.showSnackBar(
            mySnackBar2("Wrong Credentials"),
          );
        }
      }
    } else {
      setState(() {
        Navigator.pop(context);
      });
    }
  }

  Future <void> setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', value);
  }

  @override
  Widget build(BuildContext context) {
    // navigatorKey: navigatorKey;
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      //navigatorKey: navigatorKey,
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo-removebg-preview (1).png",
              height: 200,
              color: Colors.blueGrey,
            ),
            const Text(
              "Welcome",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 28,
                  fontWeight: FontWeight.w700),
            ),
            mytext("Please Fill in the details below"),
            const SizedBox(
              height: 30.0,
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.only(left: 40, right: 40),
              child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                    ),
                    errorText:
                        isEmailValid ? null : 'Enter a valid email address',
                    errorStyle: const TextStyle(
                      fontSize: 9,
                      color: Colors.red,
                    ),
                    hintStyle:
                        const TextStyle(fontSize: 11.5, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.transparent,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      isEmailValid = isEmailFormatValid(value);
                    });

                    /*textformfieldlogin(
                  "Email",
                  emailController,
                  const Icon(
                    Icons.account_circle_outlined,
                  ),
                ),*/
                  }),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
                height: 50,
                margin: const EdgeInsets.only(left: 40, right: 40),
                child: textformfieldlogin(
                  "Password",
                  passwordController,
                  const Icon(Icons.lock_outline_rounded),
                  obscureText: true,
                )),
            const SizedBox(
              height: 50,
            ),
            /*TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const ForgotPassword()),
                );
              },
              child: mytext("Forgot Password?"),
            ),
            const SizedBox(
              height: 20,
            ),*/
            Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 40, right: 40),
              child: MaterialButton(
                color: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: loginFunction,
                child: const Text("Sign In",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11.5,
                    )),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const Registration()),
                      );
                    },
                    child: mytext("Sign Up")),
                const SizedBox(
                  height: 12,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
