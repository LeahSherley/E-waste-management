import 'package:flutter/material.dart';
import 'package:quiz_app/models/location.dart';
import 'package:quiz_app/myWidgets.dart';

class infoWindow extends StatelessWidget {
  const infoWindow({
    super.key,
    required this.location,
  });
  final Location location;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 200,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurStyle: BlurStyle.normal,
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 300,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                image: AssetImage(
                  location.image,
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
               const Icon(Icons.location_on),
                const SizedBox(width: 7),
                mytext(
                  "Waste Electrical and Electronic Equipment Centers",
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                const Icon(Icons.call),
                const SizedBox(width: 7),
                mytext("0790555432"),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                const Icon(Icons.email),
                const SizedBox(width: 7),
                mytext("lsherley90@gmail.com"),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                const Icon(Icons.schedule),
                const SizedBox(width: 7),
                mytext("8:00 - 8:00PM"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
