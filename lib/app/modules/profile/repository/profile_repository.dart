import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileRepository {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  void uploadFile(File file, String userId) async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('profiles/$userId.jpg')
          .putFile(file);
    } catch (e) {
      // e.g, e.code == 'canceled'
    }
  }
}
