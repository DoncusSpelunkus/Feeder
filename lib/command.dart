import 'package:firebase_database/firebase_database.dart';
import 'package:fooddataagg/broker.dart';
import 'package:fooddataagg/firebase.dart';

abstract class Command{
 void executeSet(k);
 Future<String> executeGet(k);
}

class instantFeedCommand implements Command{
  FireBaseDB db = FireBaseDB();
  Broker broker = Broker();
  @override
  void executeSet(dynamic weight){
    broker.publish(weight.toString());
    db.testSet(weight);
  }

  @override
  Future<String> executeGet(k) {
    throw UnimplementedError();
  }
}

class getDataCommand implements Command{
  FireBaseDB db = FireBaseDB();
  @override
  Future<String> executeGet(dynamic data) async {
    return await db.testGet(data);
  }

  @override
  void executeSet(k) {
  }
}