import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  late String id;

  UserData.fromFirebase(User user) {
    id = user.uid;
  }
}
