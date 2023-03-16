import 'package:firebase_database/firebase_database.dart';
import 'package:fooddataagg/firebase.dart';

abstract class Command{
 void execute(k);
}


class instantFeedCommand implements Command{
  FireBaseDB db = FireBaseDB();
  @override
  void execute(dynamic weight){
    db.testSet(weight);
  }
}