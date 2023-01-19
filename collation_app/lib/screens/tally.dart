import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collation_app/models/temp.dart';
import 'package:collation_app/candidate_services.dart';
import 'package:collation_app/custom/global.dart';
import 'package:collation_app/custom/functions.dart';

class Tally extends StatefulWidget {
  const Tally({Key? key}) : super(key: key);

  @override
  State<Tally> createState() => _TallyState();
}

class _TallyState extends State<Tally> {
  @override
  Widget build(BuildContext context) {
    var temp = context.watch<Temporary>();
    var candidateService = context.watch<CandidateServices>();
    List<String> strs = colate.map((e) => e.toString()).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tally'),
        actions: [
          PopupMenuButton(onSelected: (value) async {
            switch (value) {
              case "Block":
                {
                  print(strs);
                  print(strs.runtimeType);
                  candidateService.addCollation(
                    'titleController.text',
                    strs,
                  );
                }
                break;
            }
          }, itemBuilder: (buildContext) {
            return [
              const PopupMenuItem(
                value: 'Block',
                child: Text('Transact'),
              ),
            ];
          })
        ],
      ),
      body: temp.collect.isEmpty
          ? const Center(
              child: Text(
                'Tap on the Tally Sign To Begin',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              itemCount: temp.collect.length,
              itemBuilder: (context, index) {
                return Container(
                  child: temp.collect[index],
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          chooseDialog(context, () {}, () => fetchTally(temp, context));
        },
        label: const Text(
          'Tally',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  void fetchTally(Temporary temp, BuildContext context) {
    temp.collect.clear();
    temp.fetchTally('presidential');
    print(temp.collect);
    Navigator.pop(context);
  }
}
