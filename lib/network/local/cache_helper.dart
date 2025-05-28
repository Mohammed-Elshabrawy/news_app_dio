import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

 static Future<bool> putBool({required key, required value})async {
    return await sharedPreferences.setBool(key, value);
  }
  static bool? getBool({required key}) {
    print(sharedPreferences.getBool(key));
    return  sharedPreferences.getBool(key);
  }
}
