import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:sonhador/app/modules/profile/model/profile_model.dart';

class ProfileRepository {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  void uploadFile(File file, String userId) async {
    try {
      await storage.ref('profiles/$userId.jpg').putFile(file);
    } catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  Future<ProfileModel> downloadFile(String userId) async {
    String downloadUrl =
        await storage.ref('profiles/$userId.jpg').getDownloadURL();

    ProfileModel profile = ProfileModel(photoUrl: downloadUrl, userId: userId);

    print(downloadUrl);
    return profile;
  }
}
