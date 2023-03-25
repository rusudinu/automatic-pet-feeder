import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PetFeederController(),
    );
  }
}

class PetFeederController extends StatefulWidget {
  const PetFeederController({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WebSocketLed();
  }
}

class _WebSocketLed extends State<PetFeederController> {
  bool servoStatus = false;
  bool connected = false;
  late IOWebSocketChannel channel;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      channelconnect();
    });

    super.initState();
  }

  channelconnect() {
    try {
      channel = IOWebSocketChannel.connect("ws://192.168.4.1:81");
      channel.stream.listen(
        (message) {
          print(message);
          setState(() {
            if (message == "connected") {
              connected = true;
            } else if (message == "poweron:success") {
              servoStatus = true;
            } else if (message == "poweroff:success") {
              servoStatus = false;
            }
          });
        },
        onDone: () {
          print("Web socket is closed");
          setState(() {
            connected = false;
          });
        },
        onError: (error) {
          print(error.toString());
        },
      );
    } catch (_) {
      print("error on connecting to websocket.");
    }
  }

  Future<void> sendcmd(String cmd) async {
    if (connected == true) {
      if (servoStatus == false && cmd != "poweron" && cmd != "poweroff") {
        print("Send the valid command");
      } else {
        channel.sink.add(cmd);
      }
    } else {
      channelconnect();
      print("Websocket is not connected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LED - ON/OFF NodeMCU"), backgroundColor: Colors.redAccent),
      body: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(child: connected ? Text("WEBSOCKET: CONNECTED") : Text("DISCONNECTED")),
              Container(child: servoStatus ? Text("LED IS: ON") : Text("LED IS: OFF")),
              Container(
                  margin: EdgeInsets.only(top: 30),
                  child: TextButton(
                      onPressed: () {
                        if (servoStatus) {
                          sendcmd("poweroff");
                          servoStatus = false;
                        } else {
                          sendcmd("poweron");
                          servoStatus = true;
                        }
                        setState(() {});
                      },
                      child: servoStatus ? Text("TURN LED OFF") : Text("TURN LED ON")))
            ],
          )),
    );
  }
}
