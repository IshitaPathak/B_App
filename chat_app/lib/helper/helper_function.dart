import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  //keys
  static String userLoggedInKey = "LOKEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USERMAILKEY";

  // for saving the data
  static Future<bool> savedUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> savedUserName(String userName) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setString(userLoggedInKey, userNameKey);
  }

  static Future<bool> savedUserEmail(String userEmail) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setString(userLoggedInKey, userEmailKey);
  }
  //for getting the data

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool(userLoggedInKey);
  }
}
