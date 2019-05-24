import 'package:flutter/material.dart';
import 'package:real_final_mobile/dbms/DatabaseManage.dart';
import 'package:real_final_mobile/ui/Wait.dart';

import 'models/Users.dart';
import 'ui/LogIn.dart';
import 'ui/Register.dart';


void main() => runApp(MyApp());

List<Users> items = new List();


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xffa1887f),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => Wait(),
        "/register": (context) => Register(),
        "/login": (context) => LogIn(items)
      },
    );
  }
}


