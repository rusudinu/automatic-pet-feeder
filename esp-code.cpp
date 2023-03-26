#include "ESP8266WiFi.h"
#include <Servo.h>
#include <WebSocketsServer.h>

int SERVO_PIN = D3;    // The pin which the servo is attached to
int CLOSE_ANGLE = 0;  // The closing angle of the servo motor arm
int OPEN_ANGLE = 180;  // The opening angle of the servo motor arm
const char* ssid = "esp8266";
const char* passw = "iamspeed";

WebSocketsServer webSocket = WebSocketsServer(81); //websocket init with port 81
String message_TS = "";
Servo servo;
int feedingInterval = -1;
long oneHour = 3600000;
long lastFeedTime = 0;

void feed(){
  open_door();
  delay(1000);
  close_door();
  }

void open_door() {
  servo.write(OPEN_ANGLE);
  delay(20);
}

void close_door() {
  servo.write(CLOSE_ANGLE);
  delay(20);
}

void webSocketEvent(uint8_t num, WStype_t type, uint8_t * payload, size_t length) {
  String cmd = "";
  String connectedMSG = "connected:" + String(feedingInterval);
  switch (type) {
    case WStype_DISCONNECTED:
      Serial.println("Websocket is disconnected");
      break;
    case WStype_CONNECTED: {
        Serial.println("Websocket is connected");
        Serial.println(webSocket.remoteIP(num).toString());
        webSocket.sendTXT(num, connectedMSG);
      }
      break;
    case WStype_TEXT:
      cmd = "";
      for (int i = 0; i < length; i++) {
        cmd = cmd + (char) payload[i];
      }
      Serial.println(cmd);

      if (cmd == "feednow") {
        feed();
      } else if (cmd == "feedin3hours"){
        feedingInterval = 3;
      } else if (cmd == "feedin6hours"){
        feedingInterval = 6;
      } else if (cmd == "feedin12hours"){
        feedingInterval = 12;
      }

      message_TS = cmd + ":success";
      webSocket.sendTXT(num, message_TS);
      break;
    case WStype_FRAGMENT_TEXT_START:
      break;
    case WStype_FRAGMENT_BIN_START:
      break;
    case WStype_BIN:
      hexdump(payload, length);
      break;
    default:
      break;
  }
}

void setup(void)
{
  Serial.begin(9600); //serial start

  WiFi.mode(WIFI_AP);
  WiFi.softAP(ssid, passw);

  webSocket.begin();
  webSocket.onEvent(webSocketEvent);
  Serial.println("Websocket is started");

  servo.attach(SERVO_PIN);
  close_door();
}

void loop() {
  webSocket.loop();

  if (feedingInterval > 0) {
    if (millis() - lastFeedTime > feedingInterval * oneHour) {
      feed();
      lastFeedTime = millis();
    }
  }
}
