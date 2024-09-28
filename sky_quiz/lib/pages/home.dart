import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_quiz/helper/data_provider.dart';
import 'package:sky_quiz/pages/flash_card_screen.dart';
import 'package:sky_quiz/pages/topics_screen.dart';

class Home extends StatelessWidget {
  final List<String> practiceType = ['QUIZ', 'FLASH CARD'];
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HOME'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Container(
          padding: EdgeInsets.all(100),
          alignment: Alignment.center,
          child: GridView.count(
            crossAxisSpacing: 12,
            mainAxisSpacing: 30,
            crossAxisCount: 1,
            children: [
              for (var i in practiceType)
                InkWell(
                  onTap: () {
                    Provider.of<DataProvider>(context, listen: false)
                        .updateIsQuiz(true);
                    if (i == 'QUIZ')
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TopicsScreen(),
                        ),
                      );
                    else {
                      Provider.of<DataProvider>(context, listen: false)
                          .updateIsQuiz(false);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TopicsScreen(),
                        ),
                      );
                    }
                  },
                  child: Container(
                      padding: EdgeInsets.all(40),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(255, 163, 189, 233)),
                      child: Text(
                        i,
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      )),
                )
            ],
          ),
        ));
  }
}
