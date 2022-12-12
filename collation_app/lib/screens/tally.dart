import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collation_app/models/temp.dart';

class Tally extends StatefulWidget {
  const Tally({Key? key}) : super(key: key);

  @override
  State<Tally> createState() => _TallyState();
}

class _TallyState extends State<Tally> {
  @override
  Widget build(BuildContext context) {
    var temp = context.watch<Temporary>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tally'),
      ),
      body: temp.collect.isEmpty
          ? const Center(
              child: Text(
                'Tap on the Plus Sign To Begin',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              itemCount: temp.collect.length,
              itemBuilder: (context, index) {
                return Container(
                  child: temp.collect[index],
                );
                /*ListTile(
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
                );*/
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          temp.fetchTally('tttt');
          print(temp.collect);
        },
        label: const Text(
          'Tally',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
