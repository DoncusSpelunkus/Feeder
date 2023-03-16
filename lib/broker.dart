import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fooddataagg/ui.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';



class Broker {

  final client = MqttServerClient('mqtt.flespi.io', '1883');

  void brokerSetup(){
    client.logging(on: true);
    client.keepAlivePeriod = 60;
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.pongCallback = pong;
    client.onSubscribed = onSubscribed;

    final connMess = MqttConnectMessage()
        .authenticateAs("Mr7DlDWxIjdRE412ku8uxCnxGeZnSISvZQWbjHyPOBwiun8EH6W2x7q1adcSLVbB",
        "Mr7DlDWxIjdRE412ku8uxCnxGeZnSISvZQWbjHyPOBwiun8EH6W2x7q1adcSLVbB")
        .withClientIdentifier('dart_client')
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    print('client connecting....');
    client.connectionMessage = connMess;
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      print('OnDisconnected callback is solicited, this is correct');
    }
  }

  /// The successful connect callback
  void onConnected() {
    print('OnConnected client callback - Client connection was sucessful');
    client.subscribe("topic/this", MqttQos.atMostOnce);
  }

  /// Pong callback
  void pong() {
    print('Ping response client callback invoked');
  }

  void onSubscribed(String message){
    const pubTopic = 'topic/this';
    final builder = MqttClientPayloadBuilder();
    builder.addString('Hello from mqtt_client');

    print('Subscribing to the $pubTopic topic');
    client.subscribe(pubTopic, MqttQos.exactlyOnce);

    print('Publishing our topic');
    client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);
  }


}