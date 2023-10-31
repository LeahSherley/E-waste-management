import 'package:flutter/material.dart';
import 'package:quiz_app/models/awareness.dart';
import 'package:transparent_image/transparent_image.dart';

class MoreInfo extends StatelessWidget {
  const MoreInfo({super.key, required this.awareness});

  final Awareness awareness;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 2,
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(15),
          child: Stack(
            children: [
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(awareness.image),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: Colors.black54,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 44, vertical: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        awareness.label,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 0),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            //color: Colors.grey[200],
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
          ),
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              softWrap: true,
              awareness.description,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
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
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
