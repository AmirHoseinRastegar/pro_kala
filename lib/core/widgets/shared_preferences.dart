
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  late SharedPreferences prefs;
  Future<bool> getData() async {
     prefs = await SharedPreferences.getInstance();
    final bool status = prefs.getBool('intro') ?? false;

    return status;
  }

  Future<void> setData() async {
     prefs = await SharedPreferences.getInstance();

    await prefs.setBool('intro', true);
    
  }
// Obtain shared preferences.
}
