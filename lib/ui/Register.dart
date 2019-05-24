import 'package:flutter/material.dart';
import 'package:real_final_mobile/dbms/DatabaseManage.dart';
import 'package:real_final_mobile/models/Users.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'LogIn.dart';

class Register extends StatefulWidget {
  @override
  RegisterState createState() {
    // TODO: implement createState
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
  TextEditingController useridcontrol = TextEditingController();
  TextEditingController usernamecontrol = TextEditingController();
  TextEditingController agecontrol = TextEditingController();
  TextEditingController new_pass = TextEditingController();
  DatabaseManage db = DatabaseManage();

  List<Users> items = new List();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int countspace(String text){
    int space = 0;
    for (int i = 0; i < text.length ; i ++){
      if (text[i] == ' '){
        space++;
      }
    }
    return space;
  }

  TextFormField userid() {
    return TextFormField(
      controller: useridcontrol,
      decoration: InputDecoration(
        labelText: "User Id",
        hintText: "sample",
        icon: Icon(Icons.perm_identity),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.length < 6 || value.length > 12 || value.contains(' ')) {
          return "Please input correct valid userId";
        }
      },
    );
  }

  TextFormField username() {
    return TextFormField(
      controller: usernamecontrol,
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "JJ Abrums",
        icon: Icon(Icons.perm_identity),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if (countspace(value) != 1){
          return "A name must contain exactly 1 spacebar";
        }
      },
    );
  }

  TextFormField age() {
    return TextFormField(
      controller: agecontrol,
      decoration: InputDecoration(
        labelText: "Age",
        hintText: "10 - 80 years old",
        icon: Icon(Icons.perm_contact_calendar),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (int.parse(value) == null ||
            (int.parse(value) < 10 || int.parse(value) > 80)) {
          return "Please input correct age value";
        }
      },
      obscureText: false,
    );
  }

  TextFormField password() {
    return TextFormField(
      controller: new_pass,
      decoration: InputDecoration(
          labelText: "Password",
          hintText: "more than 6 characters",
          icon: Icon(Icons.lock)),
      obscureText: true,
      validator: (value) {
        if (value.length < 6) {
          return "Password length must exceed 6 character.";
        }
      },
    );
  }

  RaisedButton register() {
    return RaisedButton(
      color: Theme.of(context).accentColor,
      splashColor: Colors.blueGrey,
      child: Text(
        "Register",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          if (new_pass.text == "" ||
              new_pass.text == "" ||
              useridcontrol.text == "" ||
              usernamecontrol.text == "") {
            _scaffoldKey.currentState.showSnackBar(new SnackBar(
              content: Text("Please fill up form"),
            ));
          } else if (usernamecontrol.text == "admin") {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text("user นี้มีอยู่ในระบบแล้ว"),
            ));
          } else {
            db.saveNewUsers(Users.getValue(
              useridcontrol.text,
              usernamecontrol.text,
              agecontrol.text,
              new_pass.text
            )).then((_){
              items.clear();
              db.getAllUsers().then((users){
                setState(() {
                print(users.length);
                users.forEach((user){
                  items.add(Users.fromMap(user));
                  print(items.length);
                }); 
                });
              });
            });
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
            
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
                userid(),
                username(),
                age(),
                password(),
                register(),
              ]),
        ));
  }
}

// import 'package:flutter/material.dart';
// import 'package:real_final_mobile/dbms/DatabaseManage.dart';
// import 'package:real_final_mobile/models/Users.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'LogIn.dart';

// class Register extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return RegisterState();
//   }

// }

// class RegisterState extends State<Register>{

//   List<Users> items = new List();
//   DatabaseManage db = DatabaseManage();

//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController useridControl = new TextEditingController();
//   final TextEditingController passwordControl = new TextEditingController();
//   final TextEditingController ageControl = new TextEditingController();
//   final TextEditingController nameControl = new TextEditingController();

//   //UserId Form Text
//   TextFormField userId(){
//     return TextFormField(
//       controller: useridControl,
//       decoration: InputDecoration(
//         labelText: "User Id",
//         hintText: "Enter your user id",
//         icon: Icon(Icons.person)
//       ),
//       keyboardType: TextInputType.text,
//       validator: (value){
//         if(value.length < 6 || value.length > 12 || value.contains(' ')){
//           Alert(
//             context: context,
//             type: AlertType.error,
//             title: "Error",
//             desc: "Please Enter correct userid form.",
//             buttons: [
//               DialogButton(
//                 child: Text(
//                   "OK",
//                   style: TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//                 onPressed: () => Navigator.pop(context),
//                 width: 120,
//               )
//             ],
//           ).show();
//         }
//       }
//     );
//   }

//   int haveSpace(String value){
//     int box = 0;
//     for (int i = 0; i < value.length; i++){
//       if(value[i] == ' '){
//         box += 1;
//       }
//       return box;
//     }
//   }

//   //Name field
//   TextFormField userName(){
//     return TextFormField(
//       controller: nameControl,
//       decoration: InputDecoration(
//         labelText: "Name",
//         hintText: "Enter your user id",
//         icon: Icon(Icons.contacts)
//       ),
//       keyboardType: TextInputType.text,
//       validator: (value){
//         if(haveSpace(value) != 1){
//           Alert(
//             context: context,
//             type: AlertType.error,
//             title: "Error",
//             desc: "Name must contains exactly 1 spacebar.",
//             buttons: [
//               DialogButton(
//                 child: Text(
//                   "OK",
//                   style: TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//                 onPressed: () => Navigator.pop(context),
//                 width: 120,
//               )
//             ],
//           ).show();
//         }
//       }
//     );
//   }

//   //age form
//   TextFormField userAge(){
//     return TextFormField(
//       controller: ageControl,
//       decoration: InputDecoration(
//         labelText: "Age",
//         hintText: "Enter your user id",
//         icon: Icon(Icons.calendar_today)
//       ),
//       keyboardType: TextInputType.number,
//       validator: (value){
//         if(int.parse(value) == null || (int.parse(value) < 10 || int.parse(value) > 80)){
//           Alert(
//             context: context,
//             type: AlertType.error,
//             title: "Error",
//             desc: "Age must not less than 10 and more than 80.",
//             buttons: [
//               DialogButton(
//                 child: Text(
//                   "OK",
//                   style: TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//                 onPressed: () => Navigator.pop(context),
//                 width: 120,
//               )
//             ],
//           ).show();
//         }
//       }
//     );
//   }

//   //Password Form Text
//   TextFormField password(){
//     return TextFormField(
//       controller: passwordControl,
//       decoration: InputDecoration(
//         labelText: "Password",
//         hintText: "Enter your user password",
//         icon: Icon(Icons.https)
//       ),
//       keyboardType: TextInputType.text,
//       validator: (value){
//         if(value.length < 6){
//           Alert(
//             context: context,
//             type: AlertType.error,
//             title: "Error",
//             desc: "Password must not less than 6 letter.",
//             buttons: [
//               DialogButton(
//                 child: Text(
//                   "OK",
//                   style: TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//                 onPressed: () => Navigator.pop(context),
//                 width: 120,
//               )
//             ],
//           ).show();
//         }
//       },
//       obscureText: true,
//     );
//   }

//   //regiset submit button
//   RaisedButton regis(){
//     return RaisedButton(
//       child: Text("REGISTER NEW ACCOUNT"),
//       onPressed: () async {
//         if(_formKey.currentState.validate()){
//           if(useridControl.text.isEmpty ||
//            passwordControl.text.isEmpty ||
//            ageControl.text.isEmpty ||
//            nameControl.text.isEmpty){
//             Alert(
//               context: context,
//               type: AlertType.error,
//               title: "Error",
//               desc: "Please Enter all form.",
//               buttons: [
//                 DialogButton(
//                   child: Text(
//                     "OK",
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                   onPressed: () => Navigator.pop(context),
//                   width: 120,
//                 )
//               ],
//             ).show();
//           }else{
//             db.saveNewUsers(Users.getValue(
//               useridControl.text,
//               nameControl.text,
//               ageControl.text,
//               passwordControl.text
//             )).then((_){
//               items.clear();
//               db.getAllUsers().then((users){
//                 setState(() {
//                 print(users.length);
//                 users.forEach((user){
//                   items.add(Users.fromMap(user));
//                   print(items.length);
//                 }); 
//                 });
//               });
//             });
//             Alert(
//               context: context,
//               type: AlertType.success,
//               title: "Success",
//               desc: "Your account have been create.",
//               buttons: [
//                 DialogButton(
//                   child: Text(
//                     "OK",
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                   onPressed: (){
//                     Navigator.push(context, 
//                     MaterialPageRoute(
//                       builder: (context) => LogIn(items)
//                     ));
//                   },
//                   width: 120,
//                 )
//               ],
//             ).show();
//           }
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Register"),
//       ),

//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             padding: EdgeInsets.all(32.0),
//             shrinkWrap: true,
//             children: <Widget>[
//               userId(),
//               userName(),
//               userAge(),
//               password(),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   vertical: 8.0
//                 ),
//                 child: regis()
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }