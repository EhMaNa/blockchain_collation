import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
      var response = await Dio().get('http://localhost:3000/collation');
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
        title: const Text('Collations'),
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
