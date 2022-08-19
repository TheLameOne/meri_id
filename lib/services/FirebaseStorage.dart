import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class UploadFileFirebase {
  UploadFileFirebase._();

  factory UploadFileFirebase.getInstance() => _instance;
  static final UploadFileFirebase _instance = UploadFileFirebase._();
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadFile(
      File file, String fileName, String folderName) async {
    try {
      Reference reference =
          _firebaseStorage.ref().child('$folderName/$fileName');
      await reference.putFile(file);
      print('File Uploaded');
      String url = await reference.getDownloadURL();
      return url;
    } catch (e) {
      throw e;
    }
  }
}
