import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sky_quiz/models/quiz_model.dart';
import 'package:sky_quiz/pages/dashboard.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizScreen extends StatefulWidget {
  final String aircraftType;
  final String system;
  final String difficultyLevel;
  const QuizScreen(
      {super.key,
      required this.aircraftType,
      required this.system,
      required this.difficultyLevel});
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  List<int?> _selectedAnswers = [];

  @override
  void initState() {
    super.initState();

    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('questions')
        .where('system', isEqualTo: widget.system)
        .where('aircraftType', isEqualTo: widget.aircraftType)
        .get();

    setState(() {
      _questions = snapshot.docs.map((doc) {
        final List<String> options = List.from(doc['options'] as List);
        return Question(
            question: doc['question'].toString(),
            option: options,
            correctAnswer: doc['correctAnswer'],
            explanation: doc['explanation'].toString(),
            difficultyLevel: doc['level'].toString(),
            isFlashCard: doc['isFlashCard']);
      }).toList();
      _selectedAnswers = List<int?>.filled(_questions.length, null);
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      }
    });
  }

  void _prevQuestion() {
    setState(() {
      if (_currentQuestionIndex > 0) {
        _currentQuestionIndex--;
      }
    });
  }

  void _submitQuiz() {
    List<int> unansweredQuestions = [];
    for (int i = 0; i < _questions.length; i++) {
      if (_selectedAnswers[i] == null) {
        unansweredQuestions.add(i + 1); // Adding 1 to make it 1-based index
      }
    }

    if (unansweredQuestions.isNotEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Unanswered Questions'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Please answer the following questions:'),
              Text(unansweredQuestions.join(', ')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                _goToFirstUnansweredQuestion(unansweredQuestions);
              },
              child: Text('Go to First Unanswered'),
            ),
          ],
        ),
      );
    } else {
      int score = 0;
      for (int i = 0; i < _questions.length; i++) {
        if (_selectedAnswers[i] == _questions[i].correctAnswer) {
          score++;
        }
      }
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Quiz Completed'),
          content: Text('Your score is $score/${_questions.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                _resetQuiz();
              },
              child: Text('Reset Quiz'),
            ),
          ],
        ),
      );
    }
  }

  void _goToFirstUnansweredQuestion(List<int> unansweredQuestions) {
    setState(() {
      _currentQuestionIndex = unansweredQuestions.first -
          1; // Subtracting 1 to make it 0-based index
    });
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _selectedAnswers = List<int?>.filled(_questions.length, null);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_questions.isEmpty) {
      final question = _questions[_currentQuestionIndex];
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: Center(child: Text('Questions')),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.all(40),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  (_currentQuestionIndex + 1).toString() +
                      '/' +
                      _questions.length.toString(),
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.onSecondary,
                          width: 2)),
                  child: Text(
                    question.question,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                ),
                ...question.option.asMap().entries.map((entry) {
                  int idx = entry.key;
                  String val = entry.value;
                  return ListTile(
                    title: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedAnswers[_currentQuestionIndex] = idx;
                          });
                        },
                        child: Text(
                          val,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onSecondary),
                        )),
                    leading: Radio<int>(
                      value: idx,
                      groupValue: _selectedAnswers[_currentQuestionIndex],
                      onChanged: (value) {
                        setState(() {
                          _selectedAnswers[_currentQuestionIndex] = value;
                        });
                      },
                    ),
                  );
                }).toList(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: _prevQuestion,
                      child: Text(
                        'Previous',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _currentQuestionIndex == _questions.length - 1
                          ? _submitQuiz
                          : _nextQuestion,
                      child: Text(
                        _currentQuestionIndex == _questions.length - 1
                            ? 'Submit'
                            : 'Next',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    'Explanation',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                  children: [
                    Text(
                      question.explanation,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz App'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
