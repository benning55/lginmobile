import 'package:flutter/material.dart';
import 'package:real_final_mobile/models/Users.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LogIn.dart';
import 'Profile.dart';

class Home extends StatefulWidget{

  List<Users> all_user = new List();
  Users userInfo;
  Home(this.userInfo, this.all_user);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState(userInfo, all_user);
  }

}

class HomeState extends State<Home>{
  List<Users> all_user = new List();
  Users userInfo;
  HomeState(this.userInfo, this.all_user);


  RaisedButton profile(){
    return RaisedButton(
      child: Text(
        "PROFILE SETUP"
      ),
      onPressed: (){
        Navigator.push(context, 
          MaterialPageRoute(
          builder: (context) => Profile(userInfo, all_user)
        ));
      },
      color: Theme.of(context).accentColor,
    );
  }

  RaisedButton myfriend(){
    return RaisedButton(
      child: Text(
        "MY FRIENDS"
      ),
      onPressed: (){
      },
      color: Theme.of(context).accentColor,
    );
  }

  RaisedButton logout(){
    return RaisedButton(
      child: Text(
        "SIGN OUT"
      ),
      onPressed: () async {
        final prefs = await SharedPreferences.getInstance();
        final check = prefs.get('ID') ?? 0;
        print(check);
        prefs.remove('ID');
        Navigator.push(context, 
          MaterialPageRoute(
          builder: (context) => LogIn(all_user)
        ));
      },
      color: Theme.of(context).accentColor,
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),

      body: SingleChildScrollView(
        child: ListView(
          padding: EdgeInsets.all(32),
          shrinkWrap: true,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 5.0
                ),
                child: Text("Hello "+ userInfo.name.toString()
                +"\n"+"This is my quote "+userInfo.quote.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            profile(),
            myfriend(),
            logout()
          ],
        ),
      ),
    );
  }
}