import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class FireBaseDB{
  DatabaseReference ref = FirebaseDatabase.instance.ref("Data/Client1/new");


  initDB() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    print("Get's called");
  }

  testSet() async{
    await ref.set({
      "name": "John",
      "age": 18,
      "address": {
        "line1": "100 Mountain View"
      }
    });
  }
}