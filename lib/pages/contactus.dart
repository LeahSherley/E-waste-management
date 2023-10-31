import 'package:flutter/material.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:quiz_app/pages/landing_page.dart';

class Contact extends StatelessWidget {
  const Contact({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         elevation: 8.0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const Landing(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
        ),
        title: scaffoldtext("Contact Us"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(left: 22, right: 22, top: 22, bottom: 22),
          width: double.infinity,
          decoration: BoxDecoration(
              //color: Colors.grey[300],
              boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurStyle: BlurStyle.normal,
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
               gradient: LinearGradient(
                    colors: [
                      Colors.grey[400]!,
                      Colors.grey[300]!,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 180,
                child: Image.asset(
                  "assets/images/logo-removebg-preview (1).png",
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'For any inquiries or assistance, please feel free to contact us:',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const ContactInfo(
                icon: Icons.email,
                label: 'Email',
                value: "lsherley90@gmail.com",
              ),
              const SizedBox(height: 12),
              const ContactInfo(
                icon: Icons.phone,
                label: 'Phone',
                value: '+254 790 555 432',
              ),
              const SizedBox(height: 12),
              const ContactInfo(
                icon: Icons.location_on,
                label: 'Address',
                value: '123 Main Street, Nairobi, Kenya',
              ),
              const SizedBox(height: 20,),
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
    );
  }
}

class ContactInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ContactInfo({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 22,
          color: Colors.blueGrey,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
