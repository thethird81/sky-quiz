import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sky_quiz/services/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //firestore
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController textController = TextEditingController();
  void openQuestionBox() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                //Button to save
                ElevatedButton(
                    onPressed: () {
                      //add new question
                      firestoreService.addQuestion(textController.text);
                      //clear the controller
                      textController.clear();
                      //close the box
                      Navigator.pop(context);
                    },
                    child: Text("Add"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QUESTIONS"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openQuestionBox,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestoreService.getQuestionStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List questionList = snapshot.data!.docs;
              //display as a list
              return ListView.builder(
                  itemCount: questionList.length,
                  itemBuilder: (context, index) {
                    //get individual doc
                    DocumentSnapshot documen = questionList[index];
                    String docID = documen.id;

                    //get question from each doc
                    Map<String, dynamic> data =
                        documen.data() as Map<String, dynamic>;
                    String questionText = data['question'];

                    //display as a list title
                    return ListTile(
                      title: Text(questionText),
                    );
                  });
            }
            //if there is no  question
            else {
              return const Text("No question available");
            }
          }),
    );
  }
}
