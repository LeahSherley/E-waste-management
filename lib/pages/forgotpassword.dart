import 'package:flutter/material.dart';
import 'package:quiz_app/myWidgets.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     
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
              "Reset Password",
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
                child: textformfieldlogin(
                  "Email",
                  emailController,
                  const Icon(
                    Icons.account_circle_outlined,
                  ),
                )),
            const SizedBox(
              height: 15,
            ),
            
            Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 40, right: 40),
              child: MaterialButton(
                color: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {},
                child: const Text("Proceed",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11.5,
                    )),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
           
          ],
        ),
      ),
      );
  }
}