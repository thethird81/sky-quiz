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
    'Air System',
    'Engine',
    'Oxygen',
    'Warning system',
    'Lighting',
    'Air Systems',
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
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: Center(child: Text('HOME')),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.all(40),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Select Aircraft Type and System',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              const SizedBox(
                height: 50,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onSecondary,
                      width: 2), // More visible border
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.onSecondary,
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
                    iconEnabledColor: Theme.of(context).colorScheme.onSecondary,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 20),
                    dropdownColor: Theme.of(context).colorScheme.secondary,
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
                  color: Theme.of(context).colorScheme.secondary,
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onSecondary,
                      width: 2), // More visible border
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.onSecondary,
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
                    iconEnabledColor: Theme.of(context).colorScheme.onSecondary,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 20),
                    dropdownColor: Theme.of(context).colorScheme.secondary,
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
                  color: Theme.of(context).colorScheme.secondary,
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 2), // More visible border
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.onSecondary,
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
                    iconEnabledColor: Theme.of(context).colorScheme.onSecondary,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 20),
                    dropdownColor: Theme.of(context).colorScheme.secondary,
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
                        foregroundColor:
                            Theme.of(context).colorScheme.onSecondary,
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .secondary, // Text color
                        shadowColor: Theme.of(context)
                            .colorScheme
                            .onSecondary, // Shadow color
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
                        foregroundColor:
                            Theme.of(context).colorScheme.onSecondary,
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .secondary, // Text color
                        shadowColor: Theme.of(context)
                            .colorScheme
                            .onSecondary, // Shadow color
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
