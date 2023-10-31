import 'package:flutter/material.dart';
import 'package:flutter_icon_shadow/flutter_icon_shadow.dart';

class RecyclingTipWidget extends StatelessWidget {
  final String tip;
  final IconData icon;

  const RecyclingTipWidget(this.tip, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
          //color: Colors.grey[300],
          gradient: LinearGradient(
            colors: [
              Colors.grey[400]!,
              Colors.grey[300]!,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurStyle: BlurStyle.normal,
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconShadow(Icon(icon, size: 90, color: Colors.blueGrey,),
            shadowColor: Colors.grey[700],
                  shadowOffset: const Offset(2, 2),
                  shadowBlurSigma: 1.5 ,
            ),
            Text(
              tip,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
    /*Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        tip,
        style: TextStyle(fontSize: 18.0),
      ),
    );*/
  }
}
