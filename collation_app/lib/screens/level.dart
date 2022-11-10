// ignore_for_file: prefer_const_constructors

import 'package:collation_app/custom/global.dart';
import 'package:flutter/material.dart';

// Choose which access level you are
class Level extends StatelessWidget {
  const Level({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collation dApp'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                level = 'Constituency';
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                elevation: 5,
              ),
              child: Text('Constituency'),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                level = 'Regional';
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                elevation: 5,
              ),
              child: Text('                '),
            ),
          ],
        ),
      ),
    );
  }
}
