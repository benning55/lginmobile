    
import 'package:flutter/material.dart';
import 'package:real_final_mobile/dbms/DatabaseManage.dart';
import 'package:real_final_mobile/models/Users.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';
import 'LogIn.dart';

class Wait extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WaitState();
  }
}

class WaitState extends State {
  List<Users> items = new List();
  final prefs = SharedPreferences.getInstance();

  DatabaseManage db = DatabaseManage();
  @override
  Future initState() {
    super.initState();
    db.getAllUsers().then((users) {
      setState(() {
        users.forEach((user) {
          items.add(Users.fromMap(user));
        });
        getLogin();
      });
    });
  }

  Future<String> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final stateLogin = prefs.get('ID') ?? 0;
    print(stateLogin);
    if (stateLogin != 0) {
      print("Alrady login");
      var dataUser =
          items.singleWhere((i) => i.id == stateLogin, orElse: () => null);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Home(dataUser, items)));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LogIn(items)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}