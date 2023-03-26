import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

class SettingsBloc extends ChangeNotifier {
  String socketURL = "ws://192.168.4.1:81";
  int feedingInterval = -1;
  bool connected = false;
  List<String> logs = [];
  late IOWebSocketChannel channel;

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    socketURL = prefs.getString("socketURL") ?? socketURL;
    notifyListeners();
    connect();
  }

  void setSocketURL(String url) async {
    socketURL = url;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("socketURL", url);
    logs.insert(0,"Socket URL set to $url");
    notifyListeners();
  }

  void resetSocketURL() async {
    logs.insert(0,"Socket URL reset to default.");
    setSocketURL("ws://192.168.4.1:81");
  }

  void connect() {
    logs.insert(0,"Connecting to websocket...");
    try {
      channel = IOWebSocketChannel.connect("ws://192.168.4.1:81");
      channel.stream.listen(
        (message) {
          logs.insert(0,message);
          if (message == "connected:-1" || message == "connected:3" || message == "connected:6" || message == "connected:12") {
            connected = true;

            List<String> split = message.split(":");
            if (split[1] == "3") {
              feedingInterval = 3;
            } else if (split[1] == "6") {
              feedingInterval = 6;
            } else if (split[1] == "12") {
              feedingInterval = 12;
            }
          }
          notifyListeners();
        },
        onDone: () {
          connected = false;
          notifyListeners();
        },
        onError: (error) {
          logs.insert(0,error.toString());
          print(error.toString());
        },
      );
    } catch (e) {
      logs.insert(0,"error on connecting to websocket: $e");
      print("error on connecting to websocket.");
    }
  }

  Future<void> sendCommand(String cmd) async {
    if (connected == true) {
      channel.sink.add(cmd);
    } else {
      connect();
      print("Websocket is not connected.");
    }
  }

  Future<void> feedNow() async {
    sendCommand("feednow");
  }

  Future<void> feedIn3Hours() async {
    feedingInterval = 3;
    notifyListeners();
    sendCommand("feedin3hours");
  }

  Future<void> feedIn6Hours() async {
    feedingInterval = 6;
    notifyListeners();
    sendCommand("feedin6hours");
  }

  Future<void> feedIn12Hours() async {
    feedingInterval = 12;
    notifyListeners();
    sendCommand("feedin12hours");
  }
}
