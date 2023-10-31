class Faq {
  Faq(
    {
      required this.question,
      required this.answer,
      this.isExpanded = false,

      });
  final String question;
  final String answer;
  bool isExpanded;
}


