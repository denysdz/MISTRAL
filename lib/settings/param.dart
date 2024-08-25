import 'dart:convert';

import 'package:elrond/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// For SharedPreferences
class PARAM {
  static late SharedPreferences prefs;

  static Future<void> init() async =>
      prefs = await SharedPreferences.getInstance();

  static UserModel? tempUser;

  //# дані UserModel
  static UserModel? get user {
    String? account = prefs.getString('UserModel');
    return account != null ? UserModel.fromJson(jsonDecode(account)) : null;
  }

  static set user(UserModel? val) {
    if (val != null) {
      final account = jsonEncode(val.toJson());
      prefs.setString('UserModel', account);
    } else {
      prefs.remove('UserModel');
    }
  }

  //# чи закрили око, чи ні на екрані HomeScreen
  static bool get switchBtn => prefs.getBool('switchBtn') ?? true;
  static set switchBtn(bool val) => prefs.setBool('switchBtn', val);
}
