// ignore_for_file: prefer_const_constructors

import 'package:collation_app/global.dart';
import 'package:flutter/material.dart';

// Some form of Login Screen

class Authorize extends StatelessWidget {
  const Authorize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController keyController = TextEditingController();
    TextEditingController IDController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
      ),
      body: level == 'Party'
          ? Container(
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
                      controller: IDController,
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
                          if ((passwordController.text == password1 &&
                                  IDController.text == ID1) ||
                              (passwordController.text == password2 &&
                                  IDController.text == ID2)) {
                            ID = IDController.text;
                            Navigator.popAndPushNamed(context, '/showP');
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
            )
          : Container(
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
                      controller: IDController,
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                          if ((passwordController.text == password3 &&
                                  IDController.text == ID1) ||
                              (passwordController.text == password4 &&
                                  IDController.text == ID2)) {
                            ID = IDController.text;
                            Navigator.popAndPushNamed(context, '/add');
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Authentication Failed'),
                                    content: Text(
                                      'Incorrect Password Or Name ',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  );
                                });
                          }
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
            ),
    );
  }
}
