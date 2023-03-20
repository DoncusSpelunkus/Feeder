import 'package:flutter/cupertino.dart';
import 'package:fooddataagg/broker.dart';
import 'package:fooddataagg/ui.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Broker broker = Broker();

  await broker.brokerSetup();

  broker.startUp();

  runApp(const MyApp());


}

