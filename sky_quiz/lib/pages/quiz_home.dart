import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sky_quiz/models/quiz_model.dart';
import 'package:sky_quiz/pages/dashboard.dart';
import 'package:sky_quiz/services/firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizHome extends StatefulWidget {
  final String topic;
  const QuizHome({super.key, required this.topic});
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizHome> {
  late List<Question> questions = [];
  int currentQuestionIndex = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('questions')
        .where('topic', isEqualTo: widget.topic)
        .get();

    setState(() {
      questions = snapshot.docs.map((doc) {
        final List<String> options = List.from(doc['options'] as List);
        return Question(
          question: doc['question'].toString(),
          option: options,
          correctAnswer: doc['correctAnswer'].toString(),
        );
      }).toList();
    });
  }

  void answerQuestion(String selectedOption) {
    String correctAnswer = questions[currentQuestionIndex].correctAnswer;
    if (selectedOption == correctAnswer) {
      setState(() {
        score++;
      });
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      showResultDialog();
    }
  }

  void showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Quiz Result',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text('Your Quiz score: $score / ${questions.length}'),
          actions: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      currentQuestionIndex = 0;
                      score = 0;
                    });
                  },
                  child: const Text('Restart Quiz'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Dashboard(),
                      ),
                    );
                    setState(() {
                      currentQuestionIndex = 0;
                      score = 0;
                    });
                  },
                  child: const Text('Go to Home'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text(widget.topic,
            style: GoogleFonts.chicle(
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 30,
                  letterSpacing: 1.0),
            )),
      ),
      body: (questions.isNotEmpty)
          ? Container(
              child: Column(
                children: [
                  Text(
                    'Question ${currentQuestionIndex + 1}/${questions.length.toString()}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 153, 181, 230),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Column(
                          children: [
                            Text(
                              questions[currentQuestionIndex].question,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            ...questions[currentQuestionIndex]
                                .option
                                .map((option) {
                              return Column(
                                children: [
                                  const SizedBox(height: 30.0),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      minimumSize: const Size.fromHeight(50),
                                      elevation: 4,
                                    ),
                                    onPressed: () => answerQuestion(option),
                                    child: Text(
                                      option,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              );
                              // );
                            }).toList()
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
