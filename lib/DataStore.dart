import 'dart:convert';

import 'package:first_card_project/Models/ServiceProviderUser.dart';
import 'package:first_card_project/Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DataStore {


  UserModel _user;
  UserModel get user => _user;

  String _lang;
 String get lang => _lang;
  static final DataStore _dataStore = new DataStore._internal();
  DataStore._internal();
  factory DataStore() => _dataStore;
  Future<bool> setLang(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _lang = value;
    return prefs.setString('Lang', value);
  }

  Future<String> getLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _lang = prefs.getString('Lang') ?? 'ar';
    return _lang;
  }

  Future<bool> setUser(UserModel value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _user = value;
    return prefs.setString('User', value == null? null: json.encode(value.toJson()));
  }

  Future<UserModel> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String val = prefs.getString('User');
    _user = val == null ? null : UserModel.fromJson(json.decode(val));
   /* print("_user.data.apiToken");
    print(_user.data.apiToken);*/
    return _user;
  }
  Future<bool> getFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool val = prefs.getBool('isFirst');
    return val;
  }
  Future<void> setFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setBool('isFirst', false);
  }
}

final dataStore = DataStore();
