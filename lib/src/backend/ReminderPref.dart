import 'package:motivation_quotes/src/controller/AppConfigurations/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderPrefs {
  
  //getters
  get startTime async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getString(kStartTimeHour);
  }

  get endTime async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getString(kEndTimeMin);
  }

  get notificationCount async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getInt(kNotificationCount);
  }

  //setters
  setstartTime(String value) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.setString(kStartTimeHour, value);
  }


  setendTime(String value) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.setString(kEndTimeMin, value);
  }

  setNotificationCount(int value) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.setInt(kNotificationCount, value);
  }
 
}
