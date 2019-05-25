import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableUsers = 'users';
final String colId = "id";
final String colUserId = 'userid';
final String colName = "name";
final String colAge = "age";
final String colPass = "password";
final String colQuote = "quote";

class Users{
  int _id;
  String _userid;
  String _name;
  String _age;
  String _password;
  String _quote;

  Users.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._userid = map['userid'];
    this._name = map['name'];
    this._age = map['age'];
    this._password = map['password'];
    this._quote = map['quote'];
  }

  Map<String, dynamic> toMap() {
    // map data between _username and _done as Map
    Map<String, dynamic> map = {
      colId: _id,
      colUserId: _userid,
      colName: _name,
      colAge: _age,
      colPass: _password,
      colQuote: _quote
    };
    if (_id != null) {
      map[colId] = _id;
    }
    return map;
  }

  Users.getValue(userid, name, age, password){
    this._userid = userid;
    this._name = name;
    this._age = age;
    this._password = password;
  }

  Users.map(dynamic obj) {
    this._id = obj['id'];
    this._userid = obj['userid'];
    this._name = obj['name'];
    this._age = obj['age'];
    this._password = obj['password'];
    this._quote = obj['quote'];
  }

  int get id => _id;
  String get userid => _userid;
  String get password => _password;
  String get name => _name;
  String get age => _age;
  String get quote => _quote;

  void setUsers(id, userid, name, age, password, quote){
    this._id = id;
    this._userid = userid;
    this._name = name;
    this._age = age;
    this._password = password;
    this._quote = quote; 
  }

  Users();
}