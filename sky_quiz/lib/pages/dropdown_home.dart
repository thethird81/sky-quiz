import 'package:flutter/material.dart';
import 'package:sky_quiz/pages/flash_card_screen.dart';
import 'package:sky_quiz/pages/quiz_screen.dart';

class DropdownHome extends StatefulWidget {
  DropdownHome({super.key});

  @override
  State<DropdownHome> createState() => _DropdownHomeState();
}

class _DropdownHomeState extends State<DropdownHome> {
  String aircraftTypeValue = 'B777';
  String systemsValue = 'Engine';
  String difficultyValue = 'Easy';
  final List<String> aircraftType = [
    'B777',
    'B787',
    'B737',
    'A350',
    'B767',
    'Q400'
  ];
  final List<String> difficultyLevel = [
    'Easy',
    'Medium',
    'Difficult',
  ];

  final List<String> systems = [
    'Engine',
    'Oxygen',
    'Warning system',
    'Lighting',
    'Landing Gear',
    'Pneumatics',
    'Aircraft General',
    'Anti Ice, Rain Protection',
    'Hydraulics',
    'Fuel System',
    'Flight Controls',
    'Fire Protection',
    'Electrical',
    'Avionics',
    'APU',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Drop Down Home'), backgroundColor: Colors.blueAccent),
        body: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 153, 181, 230),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.all(40),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Select Aircraft Type and System'),
              const SizedBox(
                height: 50,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  border: Border.all(
                      color: Colors.blueAccent,
                      width: 2), // More visible border
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.57),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: DropdownButton(
                    items: aircraftType
                        .map<DropdownMenuItem<String>>(
                          (String aircraftType) => DropdownMenuItem<String>(
                            value: aircraftType,
                            child: Text(aircraftType),
                          ),
                        )
                        .toList(),
                    onChanged: (String? newValue) => setState(
                      () => aircraftTypeValue = newValue!,
                    ),
                    value: aircraftTypeValue,
                    icon: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.arrow_circle_down_sharp),
                    ),
                    iconEnabledColor: const Color.fromARGB(255, 52, 7, 7),
                    style: TextStyle(
                        color: const Color.fromARGB(255, 46, 6, 6),
                        fontSize: 20),
                    dropdownColor: const Color.fromARGB(255, 218, 169, 169),
                    underline: Container(),
                    isExpanded: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  border: Border.all(
                      color: Colors.blueAccent,
                      width: 2), // More visible border
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.57),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: DropdownButton(
                    items: systems
                        .map<DropdownMenuItem<String>>(
                          (String systems) => DropdownMenuItem<String>(
                            value: systems,
                            child: Text(systems),
                          ),
                        )
                        .toList(),
                    onChanged: (String? newValue) => setState(
                      () => systemsValue = newValue!,
                    ),
                    value: systemsValue,
                    icon: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.arrow_circle_down_sharp),
                    ),
                    iconEnabledColor: const Color.fromARGB(255, 52, 7, 7),
                    style: TextStyle(
                        color: const Color.fromARGB(255, 52, 7, 7),
                        fontSize: 20),
                    dropdownColor: const Color.fromARGB(255, 205, 230, 176),
                    underline: Container(),
                    isExpanded: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  border: Border.all(
                      color: Colors.blueAccent,
                      width: 2), // More visible border
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.57),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: DropdownButton(
                    items: difficultyLevel
                        .map<DropdownMenuItem<String>>(
                          (String difficulty) => DropdownMenuItem<String>(
                            value: difficulty,
                            child: Text(difficulty),
                          ),
                        )
                        .toList(),
                    onChanged: (String? newValue) => setState(
                      () => difficultyValue = newValue!,
                    ),
                    value: difficultyValue,
                    icon: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.arrow_circle_down_sharp),
                    ),
                    iconEnabledColor: const Color.fromARGB(255, 52, 7, 7),
                    style: TextStyle(
                        color: const Color.fromARGB(255, 52, 7, 7),
                        fontSize: 20),
                    dropdownColor: const Color.fromARGB(255, 205, 230, 176),
                    underline: Container(),
                    isExpanded: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => QuizScreen(
                              aircraftType: aircraftTypeValue,
                              system: systemsValue,
                              difficultyLevel: difficultyValue),
                        ),
                      );
                    },
                    child: const Text('QUIZ'),
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurple, // Text color
                        shadowColor: Colors.deepPurpleAccent, // Shadow color
                        elevation: 10, // Elevation
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                        minimumSize: Size(100, 30) // Padding
                        ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                              aircraftType: aircraftTypeValue,
                              system: systemsValue,
                              difficultyLevel: difficultyValue),
                        ),
                      );
                    },
                    child: const Text('FLASH CARD'),
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurple, // Text color
                        shadowColor: Colors.deepPurpleAccent, // Shadow color
                        elevation: 10, // Elevation
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                        minimumSize: Size(100, 30) // Padding
                        ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
