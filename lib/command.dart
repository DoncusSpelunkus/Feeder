import 'package:firebase_database/firebase_database.dart';
import 'package:fooddataagg/broker.dart';
import 'package:fooddataagg/firebase.dart';

abstract class Command{
 void execute(k);
}


class instantFeedCommand implements Command{
  FireBaseDB db = FireBaseDB();
  Broker broker = Broker();
  @override
  void execute(dynamic weight){
    broker.publish(weight.toString());
  }
}