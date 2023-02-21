// ignore_for_file: prefer_const_constructors
import 'package:collation_app/custom/functions.dart';
import 'package:flutter/material.dart';

// Show For Presidential

class Show extends StatefulWidget {
  const Show({Key? key}) : super(key: key);

  @override
  State<Show> createState() => _ShowState();
}

class _ShowState extends State<Show> {
  @override
  void initState() {
    super.initState();
    getCollation('presidential', 'no').then((value) {
      setState(() {
        if (value != null) value.forEach((item) => items.add(item));
      });
    });
  }

  List items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Presidential'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            child: items[index],
          );
        },
      ),
    );
  }
}
