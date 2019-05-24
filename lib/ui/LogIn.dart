import 'package:flutter/material.dart';
import 'package:real_final_mobile/dbms/DatabaseManage.dart';
import 'package:real_final_mobile/models/Users.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';

class LogIn extends StatefulWidget{
  
  List<Users> items = new List();
  LogIn(this.items);



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LogInState(items);
  }
}

class LogInState extends State<LogIn>{

  List<Users> items = new List();
  LogInState(this.items);

  final _formKey = GlobalKey<FormState>();

  TextEditingController useridControl = new TextEditingController();
  TextEditingController passwordControl = new TextEditingController();

  final prefs = SharedPreferences.getInstance();

  DatabaseManage db = DatabaseManage();
  //UserId Form Text
  TextFormField userId(){
    return TextFormField(
      controller: useridControl,
      decoration: InputDecoration(
        labelText: "User Id",
        hintText: "Enter your user id",
        icon: Icon(Icons.person)
      ),
      keyboardType: TextInputType.text,
      validator: (value){
        
      }
    );
  }

  //Password Form Text
  TextFormField password(){
    return TextFormField(
      controller: passwordControl,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your user id",
        icon: Icon(Icons.person)
      ),
      keyboardType: TextInputType.text,
      validator: (value){
        
      },
      obscureText: true,
    );
  }

  Image img(){
    return Image(
      image: AssetImage("images/1.png"),
      height: 100,
    );
  }

  RaisedButton login(){
    return RaisedButton(
      child: Text("LogIn"),
      onPressed: () async {
        if(_formKey.currentState.validate()){
          if(useridControl.text.isEmpty || passwordControl.text.isEmpty){
            Alert(
              context: context,
              type: AlertType.success,
              title: "Success",
              desc: "Your account have been create.",
              buttons: [
                DialogButton(
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: (){
                    Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context) => LogIn(items)
                    ));
                  },
                  width: 120,
                )
              ],
            ).show();
          }else{
            for(var user in items){
              if(useridControl.text == user.userid && passwordControl.text == user.password){
                final prefs = await SharedPreferences.getInstance();
                prefs.setInt("ID", user.id);
                print(prefs.getInt('ID') ?? 0);
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(user, items)
                ));
                break;
              }else{
                Alert(
                  context: context,
                  type: AlertType.error,
                  title: "Error",
                  desc: "Incorrect username and password.",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: (){
                        Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (context) => LogIn(items)
                        ));
                      },
                      width: 120,
                    )
                  ],
                ).show();
              }
            }
          }
        }
      },
    );
  }

  FlatButton noAccount(){
    return FlatButton(
      child: Text(
        "Register New Account",
        style: TextStyle(color: Colors.blue),
      ),
      onPressed: (){
        Navigator.pushReplacementNamed(context, "/register");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Log In"),
      ),

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(32.0),
            shrinkWrap: true,
            children: <Widget>[
              img(),
              userId(),
              password(),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0
                ),
                child: login()
              ),
              Align(
                alignment: Alignment.centerRight,
                child: noAccount(),
              )
            ],
          ),
        ),
      ),
    );
  }

}