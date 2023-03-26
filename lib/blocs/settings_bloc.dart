import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsBloc extends ChangeNotifier {
  String socketURL = "ws://192.168.4.1:81";

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    socketURL = prefs.getString("socketURL") ?? socketURL;
    notifyListeners();
  }

  void setSocketURL(String url) async {
    socketURL = url;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("socketURL", url);
    notifyListeners();
  }

  void resetSocketURL() async {
    setSocketURL("ws://192.168.4.1:81");
  }
}
