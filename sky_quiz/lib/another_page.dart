import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sky_quiz/models/quiz_model.dart';

class GetUserName extends StatelessWidget {
  final String documentId;
  late List<Question> questions = [];

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('questions');

    return FutureBuilder<QuerySnapshot>(
      future: users.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (!snapshot.hasData) {
          return Text("No question available");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          questions = snapshot.data!.docs.map((doc) {
            final List<String> options = List.from(doc['option'] as List);
            return Question(
              question: doc['question'].toString(),
              option: options,
              correctAnswer: doc['correctAnswer'].toString(),
            );
          }).toList();
          //Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
          return Text(questions[0].question);
        }

        return Text("loading");
      },
    );
  }
}
