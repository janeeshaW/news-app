
import 'package:shared_preferences/shared_preferences.dart';



class SessionManager {


   Future setUser(var value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool("user", value);
  }

  Future<bool> getUser() async {
    var prefs = await SharedPreferences.getInstance();
    var value = prefs.getBool("user") ?? false;
    return value;
  }
 

  Future setUsers(var name, var pass) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("user$name", pass);
  }

  Future <bool?> validateUser(var name, var pass) async {
    var prefs = await SharedPreferences.getInstance();
    var value = prefs.getString("user$name") ?? false;
    if (value == false) {
      return false;
    } else if(value == pass) {
      return true; 
    } else{
       return null;
    }
  }

  Future deleteUser() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  
}