class Question {
  late String question;
  List<String> option;
  int correctAnswer;
  String explanation;

  Question({
    required this.question,
    required this.option,
    required this.correctAnswer,
    required this.explanation,
  });
}
