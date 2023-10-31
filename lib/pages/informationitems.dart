import 'package:flutter/material.dart';
import 'package:quiz_app/models/myinformation.dart';
import 'package:quiz_app/myWidgets.dart';

class InformationItems extends StatelessWidget {
  const InformationItems({super.key, required this.information, required this.onitemselected});
  
  final Information information;
  final void Function() onitemselected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onitemselected,
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        width: double.infinity,
        padding: const EdgeInsets.all(27),
        decoration: BoxDecoration(
          gradient: LinearGradient(
                    colors: [
                      Colors.grey[400]!,
                      Colors.grey[300]!
                    ], 
                   begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
          //color: information.color,
          boxShadow: const [
          /* BoxShadow(
              color: Colors.grey,
              blurStyle: BlurStyle.inner,
              spreadRadius: 1,
              blurRadius: 2,
            ),*/
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
           Icon(
            information.icon,
            color: Colors.grey,
              size: 25,
           ),
            const SizedBox(width: 5),
            textnews(information.topic),
          ],
        ),
      ),
    );
  }
}
