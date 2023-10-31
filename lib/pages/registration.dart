
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:quiz_app/pages/login.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController emailController = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late ScaffoldMessengerState scaffoldMessenger;
 
  bool isEmailValid = true;
  bool isEmailFormatValid(String email) {
    const pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }
  
    void registrationFunction() {
    if(username.text.isEmpty && emailController.text.isEmpty && passwordController.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        mySnackBar2("Provide Credentials"),
      );
      return;
    }
    else if (emailController.text.isEmpty ) {
      scaffoldMessenger.showSnackBar(
        mySnackBar2("Provide Email"),
      );
      return;
    }
    else if (username.text.isEmpty ) {
      scaffoldMessenger.showSnackBar(
        mySnackBar2("Provide Username"),
      );
      return;
    }
    else if (passwordController.text.isEmpty ) {
      scaffoldMessenger.showSnackBar(
        mySnackBar2("Provide password"),
      );
      return;
    }
    
    else {
      signUp(emailController.text,username.text, passwordController.text);
    }
  }

  signUp (String email, String username, String password,) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    Map data = {
  	"email": email,
  	"username": username,
  	"password": password,
  };
    //print(data);

    var response = await http.post(
        Uri.parse("https://randiki.000webhostapp.com/eregistration.php"),
        body: data
        );
  
    if (response.statusCode == 200) {
      //print(response.statusCode);
      var jsonResponse = json.decode(response.body);
      //print(response.body);
      if (jsonResponse != null) {
        setState(() {
          setState(() {
        Navigator.pop(context);
      });
          
        });
        int isRegistered = jsonResponse['code'];
        //var username = jsonResponse['uname'];
        if (isRegistered == 1) {
         // _prefs.addStringToSF("username", username);
          scaffoldMessenger.showSnackBar(
            mySnackBar2("Account Created"),
          );
          // ignore: use_build_context_synchronously
          Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) => const Login()));
        }
        else {
          scaffoldMessenger.showSnackBar(
            mySnackBar2("Username already in Use"),
          );
        }
      }
    } else {
      setState(() {
        setState(() {
       Navigator.pop(context);
      });
      });
    }
  }

/*Future registrationFunction() async {
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
  // navigatorKey.currentState!.popUntil((route)=> route.isFirst);
   
  }*/
  

  @override
  Widget build(BuildContext context) {
     scaffoldMessenger = ScaffoldMessenger.of(context);
   // navigatorKey: navigatorKey;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo-removebg-preview (1).png",
              height: 200,
              color: Colors.blueGrey,
            ),
            const Text(
              "Sign Up",
              style: TextStyle(
                  color: Colors.grey, fontSize: 28, fontWeight: FontWeight.w700),
            ),
            mytext("Please Fill in the details below"),
            const SizedBox(
              height: 30.0,
            ),
            /*Container(
                height: 50,
                margin: const EdgeInsets.only(left: 40, right: 40),
                child: textformfieldlogin(
                  "Email",
                  emailController,
                  const Icon(
                    Icons.email_rounded,
                  ),
                )),*/
                Container(
              height: 50,
              margin: const EdgeInsets.only(left: 40, right: 40),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                    ),
                    errorText:
                        isEmailValid ? null : 'Enter a valid email address',
                        errorStyle: const TextStyle(fontSize: 9, color: Colors.red,),
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
                  "Username",
                  username,
                  const Icon(Icons.account_circle_outlined),
                )),
            const SizedBox(height: 12),
            Container(
                height: 50,
                margin: const EdgeInsets.only(left: 40, right: 40),
                child: textformfieldlogin(
                   obscureText: true,
                  "Password",
                  passwordController,
                  const Icon(Icons.lock_outline),
                )),
            const SizedBox(height: 50),
            Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 40, right: 40),
              child: MaterialButton(
                color: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: registrationFunction,
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
