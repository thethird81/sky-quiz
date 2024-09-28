import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sky_quiz/models/quiz_model.dart';

class FetchQuestions {
  List<Question> _questions = [];
  String aircraftType;
  String system;
  String difficultyLevel;

  FetchQuestions(
      {required this.aircraftType,
      required this.difficultyLevel,
      required this.system});
  Future<List<Question>> fetchQuestions() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('questions')
        .where('system', isEqualTo: system)
        .where('aircraftType', isEqualTo: aircraftType)
        .get();

    _questions = snapshot.docs.map((doc) {
      final List<String> options = List.from(doc['options'] as List);
      return Question(
        question: doc['question'].toString(),
        option: options,
        correctAnswer: doc['correctAnswer'],
        explanation: doc['explanation'].toString(),
      );
    }).toList();

    return _questions;
  }
}
