// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:collation_app/models/temp.dart';
import 'package:collation_app/show_collation.dart';
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
    var temp = context.watch<Temporary>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Add Candidates'),
        actions: [
          PopupMenuButton(onSelected: (value) {
            switch (value) {
              case "Out":
                {
                  Navigator.pop(context);
                }
                break;
              case "Create":
                {
                  if (temp.routines.isNotEmpty) {
                    chooseDialog(
                        context,
                        () => createCollation(temp, context, 'parlimentary'),
                        () => createCollation(temp, context, 'presidental'));
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
      body: temp.routines.isEmpty
          ? const Center(
              child: Text(
                'Tap on the Plus Sign To Begin',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              itemCount: temp.routines.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(temp.routines[index]['name']),
                  subtitle: SizedBox(
                      height: 20,
                      child: Text(temp.routines[index]['voteCount'])),
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
                        print(temp.routines);
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

  void createCollation(Temporary temp, BuildContext context, String category) {
    temp.submit(category, temp.routines);
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        temp.routines.clear();
      });
    });
    Navigator.pop(context);
  }

  Future<dynamic> chooseDialog(BuildContext context, Function() onParlimentary,
      Function() onPresidential) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose an Option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: onParlimentary,
                child: Text('Parlimentary'),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () => onPresidential, child: Text('Presidential')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
