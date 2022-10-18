// ignore_for_file: prefer_const_constructors, avoid_print
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:collation_app/global.dart';

// Show For Presidential

class ShowParty extends StatefulWidget {
  const ShowParty({Key? key}) : super(key: key);

  @override
  State<ShowParty> createState() => _ShowPartyState();
}

class _ShowPartyState extends State<ShowParty> {
  @override
  void initState() {
    super.initState();
    getCollation().then((value) {
      setState(() {
        if (value != null) value.forEach((item) => use.add(item));
      });
    });
  }

  List use = [];
  dynamic getCollation() async {
    try {
      var response =
          await Dio().get('http://localhost:3000/collation/parlimentary/$ID');
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
  }

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
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => NewGroup()));
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
                value: 'out',
                child: Text('Log Out'),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          try {
            var response = await Dio().put(
                'http://localhost:3000/collation/parlimentary/$ID',
                options: Options(headers: {
                  HttpHeaders.contentTypeHeader:
                      "application/x-www-form-urlencoded"
                }));
          } catch (e) {
            //print(e);
            print('didnt send');
          }
        },
        label: Text(
          'Approve',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
