import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  getUserByUsername() {}
  updateUserInfo(userInfoMap) {
    try {
      FirebaseFirestore.instance.collection('users').add(userInfoMap);
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }
}
