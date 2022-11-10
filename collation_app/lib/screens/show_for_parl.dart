// ignore_for_file: prefer_const_constructors, avoid_print, use_key_in_widget_constructors
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:collation_app/custom/global.dart';
import 'package:collation_app/custom/functions.dart';

// Show For Presidential

class ShowParl extends StatefulWidget {
  final String category;
  final String add;
  const ShowParl({required this.category, required this.add});

  @override
  State<ShowParl> createState() => _ShowParlState();
}

class _ShowParlState extends State<ShowParl> {
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
  /*dynamic getCollation() async {
    try {
      var response = await Dio()
          .get('http://localhost:3000/collation/parlimentary?ID=$ID');
      List list = response.data.toList();
      List<Widget> wid = [];
      for (int i = 0; i < list.length; i++) {
        for (int j = 0; j < list[i]['candidates'].length; j++) {
          //print(param[j]['candidates'].length);
          //print(param[i]['candidates'][j]);
          wid.add(ListTile(
            title: Text(list[i]['candidates'][j]['name']),
            trailing: Text(list[i]['candidates'][j]['voteCount']),
          ));
        }
        wid.add(const Divider(thickness: 7.0));
      }
      //print(wid.runtimeType);
      //print(wid);
      return wid.toList();

      //return list;
    } catch (e) {
      print('not workingg');
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Parlimentary'),
        actions: [
          PopupMenuButton(onSelected: (value) async {
            switch (value) {
              case "Pres":
                {
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => NewGroup()));
                }
                break;
              case "Out":
                {
                  Navigator.pop(context);
                }
                break;
            }
          }, itemBuilder: (buildContext) {
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
          })
        ],
      ),
      body: ListView.builder(
        itemCount: displayList.length,
        itemBuilder: (context, index) {
          return Container(
            child: displayList[index],
          );
        },
      ),
      floatingActionButton: widget.add == 'never'
          ? FloatingActionButton.extended(
              onPressed: () async {
                if (count == '') {
                  print(count);
                  try {
                    count = 'done';
                    var response = await Dio().put(
                        'http://localhost:3000/collation/${widget.category}?ID=${currentUser.area}',
                        options: Options(headers: {
                          HttpHeaders.contentTypeHeader:
                              "application/x-www-form-urlencoded"
                        }));
                  } catch (e) {
                    //print(e);
                    print('didnt send');
                  }
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
