import 'dart:io';
import 'package:fooddataagg/firebase.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';



class Broker {

  static final Broker _singleton = Broker._internal();

  factory Broker() { // Making the database singleton allows us to share the instance in the command pattern
    return _singleton;
  }

  Broker._internal();

  final client = MqttServerClient('mqtt.flespi.io', '1883');

  Future<int> brokerSetup() async {
    client.logging(on: true);
    client.keepAlivePeriod = 60;
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.pongCallback = pong;
    client.autoReconnect = true;
    client.resubscribeOnAutoReconnect = true;
    FireBaseDB db = FireBaseDB();


    final connMess = MqttConnectMessage()
        .authenticateAs("Mr7DlDWxIjdRE412ku8uxCnxGeZnSISvZQWbjHyPOBwiun8EH6W2x7q1adcSLVbB",
        "Mr7DlDWxIjdRE412ku8uxCnxGeZnSISvZQWbjHyPOBwiun8EH6W2x7q1adcSLVbB")
        .withClientIdentifier('dart_client')
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMess;

    await connectBroker();

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('connected');
    } else {
      print('connection failed, status is ${client.connectionStatus}');
      client.disconnect();
      exit(-1);
    }

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      var messageDouble = double.parse(pt.toString());
      db.testSet(messageDouble, "CurrentWeight");
      print(messageDouble);
    });

    return 0;


  }

  Future<void> connectBroker() async {
    try {
      await client.connect();
    } on NoConnectionException catch (e) {
      print('client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      print('socket exception - $e');
      client.disconnect();
    }
  }


  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('Disconnected');
    if (client.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {}
  }

  /// The successful connect callback
  void onConnected() {
    print('Connected');
    client.subscribe("ESP/Publish", MqttQos.atMostOnce);

  }

  /// Pong callback
  void pong() {
    print('Ping');
  }

  void publish(String message){
    const pubTopic = 'APP/Publish';
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);

    client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);
  }

  void startUp(){
    const pubTopic = 'APP/Startup';
    final builder = MqttClientPayloadBuilder();
    builder.addString("Hello");

    client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);

  }


}