import 'package:flutter/material.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:quiz_app/pages/copytext.dart';
import 'package:quiz_app/pages/landing_page.dart';

class BinView extends StatelessWidget {
  BinView({super.key});
  final listtile = [
    ListTile(
      leading: SizedBox(
          height: 150, width: 50, child: Image.asset("assets/images/WEEE.jpeg",
          fit: BoxFit.cover,)),
      title: textnews("Waste Electrical and Electronic Equipment Centers"),
      subtitle: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.grey,
                size: 15,
              ),
              const SizedBox(
                width: 15,
              ),
              textnews("Kibuku Rd, Nairobi"),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              Icon(
                Icons.call,
                color: Colors.grey,
                size: 15,
              ),
              SizedBox(
                width: 10,
              ),
              CopyableText("0701 819 559"),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              Icon(
                Icons.email,
                color: Colors.grey,
                size: 15,
              ),
              SizedBox(
                width: 10,
              ),
              CopyableText("info@weeecentre.com"),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(
                Icons.schedule,
                color: Colors.grey,
                size: 15,
              ),
              const SizedBox(
                width: 15,
              ),
              textnews("Open . Closes 5pm"),
            ],
          ),
        ],
      ),
    ),
    const Divider(
      indent: 7.0,
      endIndent: 7.0,
    ),
    ListTile(
      leading: SizedBox(
          height: 150,
          width: 50,
          child: Image.network(
              "https://orato.world/wp-content/uploads/ewaste-1-1024x768.jpeg",
              fit: BoxFit.cover,)),
      title: textnews("Electronic Waste Initiative Kenya"),
      subtitle: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.grey,
                size: 15,
              ),
              const SizedBox(
                width: 15,
              ),
              textnews("Ngara, Nairobi, Kenya"),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              Icon(
                Icons.call,
                color: Colors.grey,
                size: 15,
              ),
              SizedBox(
                width: 10,
              ),
              CopyableText("0722 969 219"),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              Icon(
                Icons.email,
                color: Colors.grey,
                size: 15,
              ),
              SizedBox(
                width: 10,
              ),
              CopyableText("info@ewik.org"),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(
                Icons.schedule,
                color: Colors.grey,
                size: 18,
              ),
              const SizedBox(
                width: 15,
              ),
              textnews("Open . Closes 4pm"),
            ],
          ),
        ],
      ),
    ),
    const Divider(
      indent: 7.0,
      endIndent: 7.0,
    ),
    ListTile(
      leading: SizedBox(
          height: 150,
          width: 50,
          child: Image.network(
            "https://orato.world/wp-content/uploads/ewaste-1-1024x768.jpeg",
            fit: BoxFit.cover,
          )),
      title: textnews("Ngara E-Waste Collection Point"),
      subtitle: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.grey,
                size: 15,
              ),
              const SizedBox(
                width: 15,
              ),
              textnews("Jodongo Rd, Nairobi"),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              Icon(
                Icons.call,
                color: Colors.grey,
                size: 15,
              ),
              SizedBox(
                width: 10,
              ),
              CopyableText("0790 555 432"),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              Icon(
                Icons.email,
                color: Colors.grey,
                size: 15,
              ),
              SizedBox(
                width: 10,
              ),
              CopyableText("lsherley90@gmail.com"),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(
                Icons.schedule,
                color: Colors.grey,
                size: 15,
              ),
              const SizedBox(
                width: 15,
              ),
              textnews("Opens 8:00AM - 8:00PM"),
            ],
          ),
        ],
      ),
    ),
    const Divider(
      indent: 7.0,
      endIndent: 7.0,
    ),
    ListTile(
      leading: SizedBox(
        height: 150,
        width: 50,
        child: Image.network(
          "https://static.euronews.com/articles/stories/07/44/88/10/1024x538_cmsv2_ec3dfea4-3da1-5ad4-8f5d-f3e6804594a3-7448810.jpg",
          fit: BoxFit.cover,
        ),
      ),
      title: textnews("Thuo Electronic Waste"),
      subtitle: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.grey,
                size: 15,
              ),
              const SizedBox(
                width: 15,
              ),
              textnews("Jondongo Street, Nyayo"),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              Icon(
                Icons.call,
                color: Colors.grey,
                size: 15,
              ),
              SizedBox(
                width: 10,
              ),
              CopyableText("0701 819 559"),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              Icon(
                Icons.email,
                color: Colors.grey,
                size: 15,
              ),
              SizedBox(
                width: 10,
              ),
              CopyableText("thuoewaste@support.com"),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(
                Icons.schedule,
                color: Colors.grey,
                size: 15,
              ),
              const SizedBox(
                width: 15,
              ),
              textnews("Open . Closes 6pm"),
            ],
          ),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: scaffoldtext("Bin Locations"),
        elevation: 8.0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const Landing()),
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.grey,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurStyle: BlurStyle.normal,
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
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
            margin:
                const EdgeInsets.only(left: 22, right: 22, top: 22, bottom: 22),
            padding: const EdgeInsets.only(left:9, right: 7, bottom: 16, top:16),
            width: double.infinity,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: listtile,
            ),
          ),
        ]),
      ),
    );
  }
}
