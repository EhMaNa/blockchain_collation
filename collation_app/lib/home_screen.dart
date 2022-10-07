// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:collation_app/candidate_services.dart';
import 'package:provider/provider.dart';
import 'package:collation_app/mini_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var candidateService = context.watch<CandidateServices>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Candidates'),
      ),
      body: candidateService.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {},
              child: ListView.builder(
                itemCount: candidateService.candidates.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(candidateService.candidates[index].name),
                    subtitle: SizedBox(
                        height: 20,
                        child:
                            Text(candidateService.candidates[index].voteCount)),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add Candidate'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Name',
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.phone,
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Vote Count',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      candidateService.addCandidate(
                        titleController.text,
                        descriptionController.text,
                      );
                      data.add({
                        'name': titleController.text,
                        'vote': descriptionController.text
                      });
                      print(data);
                      descriptionController.clear();
                      titleController.clear();
                      Navigator.pop(context);
                    },
                    child: const Text('Add'),
                  ),
                  TextButton(
                    onPressed: () {
                      //descriptionController.clear();
                      //titleController.clear();
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
