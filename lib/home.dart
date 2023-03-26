import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Text("Home");
  }
}

/*
Container(
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
 */
