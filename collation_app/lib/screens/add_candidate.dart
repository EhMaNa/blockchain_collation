// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:collation_app/models/candidate_stateManager.dart';
import 'package:collation_app/custom/functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCandidate extends StatefulWidget {
  const AddCandidate({Key? key}) : super(key: key);

  @override
  State<AddCandidate> createState() => _AddCandidateState();
}

class _AddCandidateState extends State<AddCandidate> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController voteController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    voteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var candidateService = context.watch<CandidateServices>();
    var temp = context.watch<CandidateProvider>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Add Candidates'),
        actions: [
          PopupMenuButton(onSelected: (value) {
            switch (value) {
              case "Out":
                {
                  Navigator.popAndPushNamed(context, '/login');
                }
                break;
              case "Create":
                {
                  if (temp.candidatesData.isNotEmpty) {
                    chooseDialog(
                        context,
                        () => createCollation(temp, context, 'parlimentary'),
                        () => createCollation(temp, context, 'presidential'));
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text('No entry to collate'),
                          );
                        });
                  }
                }
                break;
              case "Show":
                {
                  chooseDialog(context, () {},
                      () => Navigator.popAndPushNamed(context, '/show'));
                }
            }
          }, itemBuilder: (buildContext) {
            return [
              PopupMenuItem(
                value: 'Create',
                child: Text('Create Collations'),
              ),
              PopupMenuItem(
                value: 'Show',
                child: Text('Show Collations'),
              ),
              PopupMenuItem(
                value: 'Out',
                child: Text('Log Out'),
              ),
            ];
          })
        ],
      ),
      body: temp.candidatesData.isEmpty
          ? const Center(
              child: Text(
                'Tap on the Plus Sign To Begin',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              itemCount: temp.candidatesData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(temp.candidatesData[index]['name']),
                  subtitle: SizedBox(
                      height: 20,
                      child: Text(temp.candidatesData[index]['voteCount'])),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      temp.removeCandidate(index);
                    },
                  ),
                );
              },
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
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Name',
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.phone,
                      controller: voteController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Vote Count',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty &&
                          voteController.text.isNotEmpty) {
                        temp.addCandidate({
                          'name': nameController.text,
                          'voteCount': voteController.text
                        });
                        /*data.add({
                        'name': nameController.text,
                        'vote': voteController.text
                      });*/
                        print(temp.candidatesData);
                        voteController.clear();
                        nameController.clear();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add'),
                  ),
                  TextButton(
                    onPressed: () {
                      voteController.clear();
                      nameController.clear();
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

  void createCollation(
      CandidateProvider temp, BuildContext context, String category) {
    temp.submit(category, temp.candidatesData);
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        temp.candidatesData.clear();
      });
    });
    Navigator.pop(context);
  }
}
