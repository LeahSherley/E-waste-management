import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyableText extends StatelessWidget {
  final String text;

  const CopyableText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: text));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
          content: Text(
            '$text copied to clipboard',
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.grey[300],
          elevation: 5.0,
          duration: const Duration(milliseconds: 6000),
          margin: const EdgeInsets.all(20),
          dismissDirection: DismissDirection.horizontal,
          behavior: SnackBarBehavior.floating,
        ));
      },
      child: Text(
        text,
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.blue[400],
          fontSize: 10,
        ),
      ),
    );
  }
}
