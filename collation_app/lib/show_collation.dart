// ignore_for_file: prefer_const_constructors
import 'package:collation_app/custom/functions.dart';
import 'package:flutter/material.dart';

// Show Collation(Simple) without popMenus

class Show extends StatefulWidget {
  const Show({Key? key, required this.category}) : super(key: key);
  final String category;
  @override
  State<Show> createState() => _ShowState();
}

class _ShowState extends State<Show> {
  @override
  void initState() {
    super.initState();
    getCollation(widget.category, 'no').then((value) {
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
        title: Text(widget.category.capitalizeFirst()),
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
