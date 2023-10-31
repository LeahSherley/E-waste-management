import 'package:flutter/material.dart';
import 'package:quiz_app/models/faqs.dart';

class faqSection extends StatelessWidget {
  const faqSection({super.key, required this.faqs});

  final List<Faq> faqs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          title: Text(faqs[index].question),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(faqs[index].answer),
            ),
          ],
        );
      },
    );
  }
}