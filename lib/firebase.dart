import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

class FireBaseDB {
  DatabaseReference? _ref;

  static final FireBaseDB _singleton = FireBaseDB._internal();

  factory FireBaseDB() {
    return _singleton;
  }

  FireBaseDB._internal();

  Future<void> initDB() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    print("Get's called");
  }

  void setRef(String tree) {
    _ref = FirebaseDatabase.instance.ref(tree);
  }

  DatabaseReference? getRef() {
    return _ref;
  }

  Future<String> testGet(dynamic data, String ref) async {
    setRef(ref);
    final snapshot = await _ref!.get();
    if (snapshot.exists) {
      return snapshot.value.toString();
    } else {
      return 'No data available.';
    }
  }

  Future<void> testSet(double weight, String ref) async {
    setRef(ref);
    await _ref!.set({
      "Time": DateFormat("yyyy-MM-dd - HH:mm:ss").format(DateTime.now()),
      "Weight": weight.toString(),
    });
  }


  Future<void> makeSetting(double time, double weight) async {
    setRef("Setting");
    await _ref!.set({
      "Time": DateFormat("yyyy-MM-dd - HH:mm:ss").format(DateTime.fromMillisecondsSinceEpoch(time.toInt())),
      "Weight": weight.toString()
    });
  }
}
