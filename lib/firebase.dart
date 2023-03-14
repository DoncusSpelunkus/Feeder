import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import  'package:intl/intl.dart';

class FireBaseDB{

  DatabaseReference ref = FirebaseDatabase.instance.ref("");

  initDB() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Get's called");
  }

  testSet(double weight) async{
    setRef();
    await ref.set({
      "Weight": weight.toString(),
    });
  }

  setRef(){
    ref = FirebaseDatabase.instance.ref("Weight/${DateFormat("yyyy-MM-dd").format(DateTime.now())}/${DateFormat("HH:mm:ss").format(DateTime.now())}");
  }
}