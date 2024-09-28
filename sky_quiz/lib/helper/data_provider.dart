import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  bool _isQuiz = true;
  bool get isQuiz => _isQuiz;

  void updateIsQuiz(bool isQuiz) {
    _isQuiz = isQuiz;
    notifyListeners();
  }
}
