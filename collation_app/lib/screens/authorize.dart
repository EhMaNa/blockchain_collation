// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:collation_app/custom/global.dart';
import 'package:flutter/material.dart';
import 'package:collation_app/screens/show_for_parl.dart';
import 'package:collation_app/custom/functions.dart';

// Login Screen

class Authorize extends StatelessWidget {
  const Authorize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController idController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Log In'),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  maxLength: 20,
                  decoration: InputDecoration(
                    hintText: 'Name of Constituency',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  controller: idController,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                // ignore: sort_child_properties_last
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  obscureText: true,
                  controller: passwordController,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        primary: Colors.red,
                        side: BorderSide(
                          color: Colors.red,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      login(idController, passwordController, context);
                    },
                    child: Container(
                        width: 200,
                        height: 50,
                        child: Center(
                            child: Text('Log In ',
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600))))),
              ),
            ],
          ),
        ));
  }

  void login(TextEditingController idController,
      TextEditingController passwordController, BuildContext context) {
    currentUser =
        validateUser(idController.text.trim(), passwordController.text);
    if (currentUser.id != 1234) {
      if (currentUser.level == 'pOfficer') {
        Navigator.popAndPushNamed(context, '/add');
      } else if (currentUser.level == 'Party') {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ShowParl(
                      category: 'parlimentary',
                      add: 'never',
                    )));
      } else if (currentUser.level == 'cOfficer') {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ShowParl(
                      category: 'parlimentary',
                      add: 'yes',
                    )));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Authentication Failed'),
              content: Text(
                'Incorrect Password Or Name ',
                style: TextStyle(fontSize: 20),
              ),
            );
          });
    }
  }
}
