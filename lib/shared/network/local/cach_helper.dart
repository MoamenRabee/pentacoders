import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{

  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key,String value) async {
   return await sharedPreferences!.setString(key, value);
  }

  static Future<bool> setBoolen(String key,bool value) async {
    return await sharedPreferences!.setBool(key, value);
  }

  static dynamic getData(String key) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> removeData(String key) async {
    return await sharedPreferences!.remove(key);
  }


}