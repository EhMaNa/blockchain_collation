// ignore_for_file: prefer_const_constructors, avoid_print, use_key_in_widget_constructors
import 'dart:io';
import 'package:collation_app/screens/tally.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:collation_app/custom/global.dart';
import 'package:collation_app/custom/functions.dart';

// Show For Parlimentary

class ShowToParty extends StatefulWidget {
  final String category;
  final String add;
  const ShowToParty({required this.category, required this.add});

  @override
  State<ShowToParty> createState() => _ShowToPartyState();
}

class _ShowToPartyState extends State<ShowToParty> {
  @override
  void initState() {
    super.initState();
    getCollation(widget.category, widget.add).then((value) {
      setState(() {
        if (value != null) value.forEach((item) => displayList.add(item));
      });
    });
  }

  List displayList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            widget.category == 'presidential' ? true : false,
        title: Text(widget.category.capitalizeFirst()),
        actions: widget.category == 'presidential'
            ? []
            : [
                PopupMenuButton(onSelected: (value) async {
                  if (widget.add == "yes") {
                    switch (value) {
                      case "Pres":
                        {}
                        break;
                      case "Tally":
                        {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Tally()));
                        }
                        break;
                      case "Out":
                        {
                          Navigator.popAndPushNamed(context, '/login');
                        }
                        break;
                    }
                  } else {
                    switch (value) {
                      case "Pres":
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShowToParty(
                                        category: 'presidential',
                                        add: 'never',
                                      )));
                        }
                        break;
                      case "Out":
                        {
                          Navigator.popAndPushNamed(context, '/login');
                        }
                        break;
                    }
                  }
                }, itemBuilder: (buildContext) {
                  if (widget.add == "yes") {
                    return [
                      PopupMenuItem(
                        value: 'Pres',
                        child: Text('View Presidential'),
                      ),
                      PopupMenuItem(
                        value: 'Tally',
                        child: Text('Tally'),
                      ),
                      PopupMenuItem(
                        value: 'Out',
                        child: Text('Log Out'),
                      ),
                    ];
                  } else {
                    return [
                      PopupMenuItem(
                        value: 'Pres',
                        child: Text('View Presidential'),
                      ),
                      PopupMenuItem(
                        value: 'Out',
                        child: Text('Log Out'),
                      ),
                    ];
                  }
                })
              ],
      ),
      body: ListView.builder(
        itemCount: displayList.length,
        itemBuilder: (context, index) {
          return Container(child: displayList[index]);
        },
      ),
      floatingActionButton: widget.add == 'never'
          ? FloatingActionButton.extended(
              onPressed: () async {
                try {
                  var response = await Dio().put(
                      'http://localhost:3000/collation/${widget.category}?ID=${currentUser.area}',
                      options: Options(headers: {
                        HttpHeaders.contentTypeHeader:
                            "application/x-www-form-urlencoded"
                      }));
                } catch (e) {
                  print('didnt send');
                }
              },
              label: Text(
                'Approve',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            )
          : null,
    );
  }
}
