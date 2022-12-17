// ignore_for_file: prefer_const_constructors
import 'package:collation_app/custom/functions.dart';
import 'package:flutter/material.dart';

// Show For Presidential(Regional)

class ShowReg extends StatefulWidget {
  const ShowReg({Key? key}) : super(key: key);

  @override
  State<ShowReg> createState() => _ShowRegState();
}

class _ShowRegState extends State<ShowReg> {
  @override
  void initState() {
    super.initState();
    getCollation('presidential', 'no').then((value) {
      setState(() {
        if (value != null) value.forEach((item) => use.add(item));
      });
    });
  }

  List use = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        actions: [
          PopupMenuButton(onSelected: (value) async {
            switch (value) {
              case "Block":
                {}
                break;
            }
          }, itemBuilder: (buildContext) {
            return [
              PopupMenuItem(
                value: 'Block',
                child: Text('Transact'),
              ),
            ];
          })
        ],
      ),
      body: ListView.builder(
        itemCount: use.length,
        itemBuilder: (context, index) {
          return Container(
            child: use[index],
          );
        },
      ),
    );
  }
}
