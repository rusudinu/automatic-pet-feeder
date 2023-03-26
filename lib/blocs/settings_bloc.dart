import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

class SettingsBloc extends ChangeNotifier {
  String socketURL = "ws://192.168.4.1:81";
  int feedingInterval = -1;
  bool connected = false;
  late IOWebSocketChannel channel;

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

  void connect() {
    try {
      channel = IOWebSocketChannel.connect("ws://192.168.4.1:81");
      channel.stream.listen(
        (message) {
          if (message == "connected") {
            connected = true;
          }
          notifyListeners();
        },
        onDone: () {
          connected = false;
          notifyListeners();
        },
        onError: (error) {
          print(error.toString());
        },
      );
    } catch (_) {
      print("error on connecting to websocket.");
    }
  }

  Future<void> sendCommand(String cmd) async {
    if (connected == true) {
      // if (servoStatus == false && cmd != "poweron" && cmd != "poweroff") {
      //   print("Send the valid command");
      // } else {
      //   channel.sink.add(cmd);
      // }
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
