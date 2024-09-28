import 'package:flutter/material.dart';
import 'package:sky_quiz/pages/systems_screen.dart';

class TopicsScreen extends StatelessWidget {
  final List<String> aircraftType = [
    'B777',
    'B787',
    'B737',
    'A350',
    'B767',
    'Q400'
  ];

  TopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Topics'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          alignment: Alignment.center,
          child: GridView.count(
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            crossAxisCount: 2,
            children: [
              for (var i in aircraftType)
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SystemsScreen(aircraftType: i),
                      ),
                    );
                    ;
                  },
                  child: Container(
                      padding: EdgeInsets.all(12),
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
